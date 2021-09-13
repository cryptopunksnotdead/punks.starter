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
  def initialize( dir: '.', mapping: {}, qualifier: {} )
    @dir = dir

    ## note: (auto-)normalize passed in from names for mappings for convenience
    ##      e.g.  Male II  => maleii  and so on
    @mapping = mapping.reduce( {} ) do |h, (from, to)|
                 h[ normalize( from ) ] = to
                 h
               end

    ## pp @mapping

    ## reorg qualifer structure internally
    ##  reverse for lookup by normalized basename
    ##   e.g.    { 'f' => ['Female I', 'Female II'],
    ##             'm' => ['Male I', 'Male II'] }
    ##              to
    ##           { 'Female I'  => 'f',
    ##             'Female II' => 'f',
    ##             'Male I'    => 'm',
    ##             'Male II'   => 'm' }
    @qualifier = qualifier.reduce( {} ) do |h, (q, keys)|
                  keys.each do |key|
                    norm = normalize( key )
                    norm = @mapping[ norm ] || norm   ## allow original names too
                    h[ norm ] = q
                  end
                  h
                end

     ##pp @qualifier
  end


  def generate( attributes )
    pp attributes

    img       = nil
    qualifier = nil      ## e.g. m/f - switch / qualifier depending on archetype (base)

    attributes.each_with_index do |(_,key), col|
       next if key.nil? || key.empty?  ## note: skip nil or empty string attributes

       basename =  normalize( key )

       ## check for known (re)mapping
       basename =  @mapping[ basename ] || basename

       path =  if qualifier && col != 0
                 "#{@dir}/#{qualifier}/#{basename}.png"
               else
                 "#{@dir}/#{basename}.png"
               end
       puts "  reading >#{path}<..."

       part = Image.read( path )
       puts "     #{part.width}x#{part.height}"

       if img   ## compose
          ## hack for doge hats - cut off / clean top (ears)
          ##   todo/fix: make "postprocessing" configurable / generic / reusable for all!!!!
          if @dir.index( 'dodge' ) && ['beanie',
                                       'cap',
                                       'forwardcap',
                                       'bandana',
                                       'cowboyhat',
                                       'fedora',
                                       'tophat',
                                       'knittedcap'].include?( basename )
             puts "  apply dodge hat hack..."
             ## "wipe-out" pixel lines 3,4,5 (top)
             [3,4,5].each do |y|
               img.width.times do |x|
                  img[ x, y ] = Color::TRANSPARENT
               end
             end
          end

         img.compose!( part )
       else     ## first layer; use a base
         img       = part

         qualifier = @qualifier[ basename ]   ## note: (optional) qualifier only works for base (first layer) for now
         if @qualifier.size > 0 && qualifier.nil?    ## note: add strict assert for required qualifier for now - why? why not?
            puts "!! ERROR - no qualifier defined for #{key} => #{basename}, sorry - please fix:"
            pp @qualifier
            exit 1
         end
       end
    end

    img
  end # method generate

  ######
  # helpers
  def normalize( str )
    ## allow (ignore) space ( ), underscore (_), dash (-), plus (+) and paras (())
    str.downcase.gsub( /[ _()+-]/, '' ).strip
  end

end   # class Art


