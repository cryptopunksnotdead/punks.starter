## boot up / shared generation code for all collection samples

require 'pixelart'
require 'csvreader'


def read_csv( path )
  CsvHash.read( path )
end



## check: find a better name? why? why not?
##    rename Art to Machine, Artmachine, Readymades,
##           Blocks? Collection?
class Art
  def initialize( dir: '.' )
    @dir = dir
  end

  def generate( attributes )
    pp attributes

    img = nil

    attributes.each do |type,key|
       next if key.nil? || key.empty?  ## note: skip nil or empty string attributes

       basename =  key.downcase.gsub( ' ', '' )
       path = "#{@dir}/#{basename}.png"
       puts "  reading >#{path}<..."

       part = Image.read( path )
       puts "     #{part.width}x#{part.height}"
       if img   ## compose
          ## hack for doge hats - cut off / clean top (ears)
          if @dir.index( 'dodge' ) && ['beanie',
                                       'cap',
                                       'cowboyhat',
                                       'knittedcap'].include?( basename )
             puts "  apply dodge hat hack..."
             ## "wipe-out" pixel lines 7,8,9 (top)
             [7,8,9].each do |y|
               img.width.times do |x|
                  img[ x, y ] = Color::TRANSPARENT
               end
             end
          end

         img.compose!( part )
       else     ## first layer; use a base
         img = part
       end
    end

    img
  end # method generate
end   # class Art


