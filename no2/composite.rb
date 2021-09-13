###############
# to run use:
#
#   $ ruby no2/composite.rb


require './boot'


recs = read_csv( './no2/punks.csv' )
puts "  #{recs.size} punk(s)"
#=>  100 punk(s)


art = Art.new( dir: './original',
               qualifier: { 'm' => ['Male 1', 'Male 2', 'Male 3', 'Male 4',
                                    'Zombie',
                                    'Ape',
                                    'Alien'],
                            'f' => ['Female 1', 'Female 2', 'Female 3', 'Female 4'],
                          }
             )


## 10x10 grid with every tile 24x24
punks = CompositeImage.new( 10, 10 )

recs.each_with_index do |rec,i|
  punk = art.generate( rec )
  punks << punk
end

punks.save( './o/no2/punks.png')


