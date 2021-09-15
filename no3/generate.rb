###############
# to run use:
#
#   $ ruby no3/generate.rb


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

recs.each_with_index do |rec,i|
  name = "punk#{i}"
  punk = art.generate( rec )

  # note: 49x49px (24 inner pixels + 25 outline pixels = 49px minimum sketch size
  punk_sketch = punk.sketch( 1, line: 1 )
  punk_sketch.save( "./o/no3/#{name}.png" )

  # 580x580px (20 *24 + 4+25 = 580px)
  punk_sketch = punk.sketch( 20, line: 4 )
  punk_sketch.save( "./o/no3/#{name}@20x.png" )
end

