###############
# to run use:
#
#   $ ruby no3/composite.rb


require './boot'


recs = read_csv( './no3/punks.csv' )
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


## 10x10 grid with every tile 49x49
punks = CompositeImage.new( 10, 10, width: 49, height: 49 )

recs.each_with_index do |rec,i|
  punk = art.generate( rec )

  punk_sketch = punk.sketch( 1, line: 1 )

  punks << punk_sketch
end

punks.save( './o/no3/punks.png')


