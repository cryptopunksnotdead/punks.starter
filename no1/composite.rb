###############
# to run use:
#
#   $ ruby no1/composite.rb


require './generate'


recs = read_csv( './no1/dodge.csv' )
puts "  #{recs.size} punk(s)"
#=>  25 records


art = Art.new( dir: './dodge' )


## 5x5 grid with every tile 32x32
punks = CompositeImage.new( 5, 5, width: 32, height: 32 )

recs.each_with_index do |rec,i|
  punk = art.generate( rec )
  punks << punk
end

punks.save( './o/no1/punks.png')


