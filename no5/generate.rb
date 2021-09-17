###############
# to run use:
#
#   $ ruby no5/generate.rb


require './boot'


recs = read_csv( './no5/aliens.csv' )
puts "  #{recs.size} punk(s)"
#=>  111 punk(s)


qualifier = { 'm' => ['Male 1', 'Male 2', 'Male 3', 'Male 4',
                      'Zombie',
                     'Ape',
                     'Alien', 'Alien Ape'],
              'f' => ['Female 1', 'Female 2', 'Female 3', 'Female 4',
                      'Alien Female'],
            }



#################
#  cyber green (hue 90°)

art_a = Art.new( dir: './basic',
               qualifier: qualifier,
               mapping: {
                  'Alien'        => 'alien_90',
                  'Alien Ape'    => 'alienape_90',
                  'Alien Female' => 'alienfemale_90',
               }
             )


## 10x12 grid with every tile 24x24
punks_a = CompositeImage.new( 10, 12 )


recs.each_with_index do |rec,i|
  name = "punk#{i}"
  punk = art_a.generate( rec )

  punk.save( "./o/no5a/#{name}.png" )
  punk.zoom(20).save( "./o/no5a/#{name}@20x.png" )

  punks_a << punk  ## add to composite
end


punks_a.save( './o/no5a/punks.png')   ## save composite
punks_a.zoom(2).save( './tmp/no5a/punks@2x.png' )   ## save composite




#################
#  burning red (hue 0°)

art_b = Art.new( dir: './basic',
               qualifier: qualifier,
               mapping: {
                  'Alien'        => 'alien_0',
                  'Alien Ape'    => 'alienape_0',
                  'Alien Female' => 'alienfemale_0',
               }
             )


## 10x12 grid with every tile 24x24
punks_b = CompositeImage.new( 10, 12 )


recs.each_with_index do |rec,i|
  name = "punk#{i}"
  punk = art_b.generate( rec )

  punk.save( "./o/no5b/#{name}.png" )
  punk.zoom(20).save( "./o/no5b/#{name}@20x.png" )

  punks_b << punk  ## add to composite
end


punks_b.save( './o/no5b/punks.png')   ## save composite
punks_b.zoom(2).save( './tmp/no5b/punks@2x.png' )   ## save composite

