###############
# to run use:
#
#   $ ruby no4/generate.rb


require './boot'


recs = read_csv( './no4/aliens.csv' )
puts "  #{recs.size} punk(s)"
#=>  111 punk(s)


art = Art.new( dir: './basic',
               qualifier: { 'm' => ['Male 1', 'Male 2', 'Male 3', 'Male 4',
                                    'Zombie',
                                    'Ape',
                                    'Alien', 'Alien Ape'],
                            'f' => ['Female 1', 'Female 2', 'Female 3', 'Female 4',
                                    'Alien Female'],
                          }
             )


## 10x12 grid with every tile 24x24
punks = CompositeImage.new( 10, 12 )


recs.each_with_index do |rec,i|
  name = "punk#{i}"
  punk = art.generate( rec )

  punk.save( "./o/no4/#{name}.png" )
  punk.zoom(20).save( "./o/no4/#{name}@20x.png" )

  punks << punk  ## add to composite
end


punks.save( './o/no4/punks.png')   ## save composite
punks.zoom(2).save( './tmp/no4/punks@2x.png' )   ## save composite

