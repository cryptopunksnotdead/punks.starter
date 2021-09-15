###############
# to run use:
#
#   $ ruby no2/generate.rb


require './boot'


recs = read_csv( './no2/punks.csv' )
puts "  #{recs.size} punk(s)"
#=>  100 punk(s)


art = Art.new( dir: './basic',
               qualifier: { 'm' => ['Male 1', 'Male 2', 'Male 3', 'Male 4',
                                    'Zombie',
                                    'Ape',
                                    'Alien'],
                            'f' => ['Female 1', 'Female 2', 'Female 3', 'Female 4'],
                          }
             )

recs.each_with_index do |rec,i|
  name = "punk#{i}"
  punk = art.generate( rec )

  punk.save( "./o/no2/#{name}.png" )
  punk.zoom(20).save( "./o/no2/#{name}@20x.png" )
end

