# Pixel Art Collection Quick Starter - Generate Algorithmically Your Own Curated (or Randomized) Collection


Let's start and generate algorithmically a pixel art collection in three steps:

Step 1 - Generate A List of Your Pixel Art Collection in a Tabular Text Format (Spreadsheet)

Step 2 - Generate All Pixel Art Images in Original Format and In 20x

Step 3 - Bonus: Generate an All-In-One Composite Image



Sample Collections

- [Collection №1 -  Twenty-Five Dodge Pixel Art Punks](#collection-1----twenty-five-dodge-pixel-art-punks)
- [Collection №2 -  The First One Hundred Pixel Art Punks](#collection-2----the-first-one-hundred-pixel-art-punks)
- [Collection №3 -  The First One Hundred Pixel Art Punks - The Black & White (Pencil Drawing) Sketch Edition](#collection-3----the-first-one-hundred-pixel-art-punks---the-black--white-pencil-drawing-sketch-edition)





## Collection №1 -  Twenty-Five Dodge Pixel Art Punks

Let's start with an exclusive twenty-five Shiba Inu dogs
pixel art collection. Much wow. Super rare.

Let's copy and (re)use all punk (building) blocks
in the dodge series (24x24):

Classic ![](dodge/classic.png),
Dark ![](dodge/dark.png),
Zombie ![](dodge/zombie.png),
Alien ![](dodge/alien.png)

<!-- note:
  sort attributes a-z for now - why? why not?
-->

Attributes (by category and a-z):

- Hat  -
  Bandana ![](dodge/bandana.png),
  Beanie ![](dodge/beanie.png),
  Cap  ![](dodge/cap.png),
  Cap Forward ![](dodge/capforward.png),
  Cowboy Hat ![](dodge/cowboyhat.png),
  Fedora ![](dodge/fedora.png),
  Headband ![](dodge/headband.png),
  Knitted Cap ![](dodge/knittedcap.png),
  Tiara ![](dodge/tiara.png),
  Top Hat ![](dodge/tophat.png)
- Hair -
  Crazy Hair ![](dodge/crazyhair.png)
- Eyes -
  3D Glasses ![](dodge/3dglasses.png),
  Big Shades  ![](dodge/bigshades.png),
  Classic Shades ![](dodge/classicshades.png),
  Eye Patch   ![](dodge/eyepatch.png),
  Nerd Glasses  ![](dodge/nerdglasses.png),
  Regular Shades  ![](dodge/regularshades.png),
  Small Shades  ![](dodge/smallshades.png)


(Source: [Punk (Building) Blocks - Dodge Series (24x24)](https://github.com/cryptopunksnotdead/punks.blocks#dodge-series-24x24))



### Step 1 -  Generate A List of Your Pixel Art Collection in Tabular Text Format (Spreadsheet)

In the first sample let's generate the list of the pixel art collection
by hand. Let's use a rarity & popularity distribution of
10 classic Shibas, 7 darkies, 5 zombies and 3 aliens.  Example  -  [`dodge.csv`](no1/dodge.csv):

``` csv
type,       attribute1,   attribute2
Classic,    3D Glasses
Classic,    Beanie
Classic,    Cap,          Regular Shades
Classic,    Cowboy Hat
Classic,    Eye Patch
Classic,    Knitted Cap
Classic,    Nerd Glasses
Classic,    Big Shades
Classic,    Knitted Cap,  Regular Shades
Classic
Dark,       Tiara
Dark,       Big Shades
Dark,       3D Glasses
Dark,       Classic Shades
Dark,       Cap
Dark,       Cap,          Regular Shades
Dark,       Tiara,        Big Shades
Zombie,     Knitted Cap
Zombie,     Eye Patch
Zombie,     Regular Shades
Zombie,     Knitted Cap,  Regular Shades
Zombie
Alien,      Cap,          Small Shades
Alien,      Headband
Alien,      Classic Shades
```

Yes, that's it.
For the list format let's use the comma-separated values (.CSV) format supported by all spreadsheet programs.
Every line is a record of a punk
made up of the original type  and one or more attributes.

Note: Let's NOT add the index number (0,1,2,3, and so on).
Why? That way you can easily
reshuffle your collection anytime.
Let's try a more "random" look by hand:


``` csv
type,       attribute1,   attribute2
Classic,    3D Glasses
Dark,       Tiara
Classic,    Beanie
Zombie,     Knitted Cap
Alien,      Cap,          Small Shades
Dark,       Big Shades
Zombie,     Eye Patch
Classic,    Cap,          Regular Shades
Classic,    Cowboy Hat
Classic,    Eye Patch
Alien,      Headband
Classic,    Knitted Cap
Dark,       3D Glasses
Zombie,     Regular Shades
Classic,    Nerd Glasses
Classic,    Big Shades
Dark,       Cap
Zombie
Classic,    Knitted Cap,  Regular Shades
Classic
Dark,       Classic Shades
Dark,       Cap,          Regular Shades
Alien,      Classic Shades
Dark,       Tiara,        Big Shades
Zombie,     Knitted Cap,  Regular Shades
```



### Step 2  - Generate All Pixel Art Images in Original Format and In 20x


Now the "magic" let's read in the list
in the comma-separated values (.CSV) format
and generate all pixel art images in the original format
(24x24) and in 20x (480x480).


``` ruby
require './boot'


recs = read_csv( './no1/dodge.csv' )
puts "  #{recs.size} punk(s)"
#=>  25 punk(s)


art = Art.new( dir: './dodge' )

recs.each_with_index do |rec,i|
  name = "punk#{i}"
  punk = art.generate( rec )

  punk.save( "./o/no1/#{name}.png" )
  punk.zoom(20).save( "./o/no1/#{name}@20x.png" )
end
```

Yes, that's it.
Run the script to generate algorithmically your collection.

In the `/o` directory you will now find
two images per punk - in the orginal format, that is, 24x24
and 20x, that is, 480x480 - and get:

```
no1/
  punk0.png
  punk0@20x.png
  punk1.png
  punk1@20x.png
  punk2.png
  punk2@20x.png
  punk3.png
  punk3@20x.png
  punk4.png
  punk4@20x.png
  punk5.png
  punk5@20x.png
  punk6.png
  punk6@20x.png
  punk7.png
  punk7@20x.png
  punk8.png
  punk8@20x.png
  ...
```

Let's open up `punk0.png` to `punk24.png`:

![](i/no1/punk0.png)
![](i/no1/punk1.png)
![](i/no1/punk2.png)
![](i/no1/punk3.png)
![](i/no1/punk4.png)
![](i/no1/punk5.png)
![](i/no1/punk6.png)
![](i/no1/punk7.png)
![](i/no1/punk8.png)
![](i/no1/punk9.png)
![](i/no1/punk10.png)
![](i/no1/punk11.png)
![](i/no1/punk12.png)
![](i/no1/punk13.png)
![](i/no1/punk14.png)
![](i/no1/punk15.png)
![](i/no1/punk16.png)
![](i/no1/punk17.png)
![](i/no1/punk18.png)
![](i/no1/punk19.png)
![](i/no1/punk20.png)
![](i/no1/punk21.png)
![](i/no1/punk22.png)
![](i/no1/punk23.png)
![](i/no1/punk24.png)


And let's have a looksie at the biggie 20x (480x480) versions:

![](i/no1/punk0@20x.png)

![](i/no1/punk1@20x.png)

[...]

![](i/no1/punk24@20x.png)



Note: If you use your own artwork
make sure your type and attribute names
used in the list in the comma-separated values (.CSV) format
match the filenames (without the `.png` extension).
For the matching algorithm all names
get automatically downcased and all spaces deleted,
thus,
`Classic` will map to `classic.png` ![](dodge/classic.png)
and `3D Glasses` to `3dglasses.png` ![](dodge/3dglasses.png)
and `Knitted Cap` to `knittedcap.png` ![](dodge/knittedcap.png)
and so on.




### Step 3 - Bonus: Generate an All-In-One Composite Image

Let's generate an all-in-one composite image holding the complete
collection in a 5x5 grid.

``` ruby
require './boot'


recs = read_csv( './no1/dodge.csv' )
puts "  #{recs.size} punk(s)"
#=>  25 punk(s)


art = Art.new( dir: './dodge' )


## 5x5 grid with every tile 24x24
punks = CompositeImage.new( 5, 5 )

recs.each_with_index do |rec,i|
  punk = art.generate( rec )
  punks << punk
end

punks.save( './o/no1/punks.png')
```

Yes, that's it.
Run the script to generate algorithmically your collection
in an all-in-one composite.

Open up `punks.png` to have a looksie.

![](i/no1/punks.png)







## Collection №2 -  The First One Hundred Pixel Art Punks

Let's take on a bigger pixel art collection.
Let's generate a pixel-perfect copy of the first one hundred punks in the original Larva Labs series in the classic 24x24
format.


Let's copy and (re)use all punk (building) blocks
in the basic series (24x24):

Male 1/2/3/4 ![](basic/male1.png)
![](basic/male2.png)
![](basic/male3.png)
![](basic/male4.png),
Female 1/2/3/4 ![](basic/female1.png)
![](basic/female2.png)
![](basic/female3.png)
![](basic/female4.png),
Zombie ![](basic/zombie.png),
Ape ![](basic/ape.png),
Alien ![](basic/alien.png)

<!-- note:
  sort attributes a-z for now - why? why not?
-->

Attributes (by category and a-z):
- Hat -
  Bandana (m/f)
  ![](basic/m/bandana.png)
  ![](basic/f/bandana.png),
  Beanie (m)
  ![](basic/m/beanie.png),
  Cap (m/f)
  ![](basic/m/cap.png)
  ![](basic/f/cap.png),
  Cap Forward (m)
  ![](basic/m/capforward.png),
  Cowboy Hat (m)
  ![](basic/m/cowboyhat.png),
  Do-rag (m)
  ![](basic/m/dorag.png),
  Fedora (m)
  ![](basic/m/fedora.png),
  Headband (m/f)
  ![](basic/m/headband.png)
  ![](basic/f/headband.png),
  Hoodie (m)
  ![](basic/m/hoodie.png),
  Knitted Cap (m/f)
  ![](basic/m/knittedcap.png)
  ![](basic/f/knittedcap.png),
  Pilot Helmet (f)
  ![](basic/f/pilothelmet.png),
  Police Cap (m)
  ![](basic/m/policecap.png),
  Tassle Hat (f)
  ![](basic/f/tasslehat.png),
  Tiara (f)
  ![](basic/f/tiara.png),
  Top Hat (m)
  ![](basic/m/tophat.png)
- Hair -
  Blonde Bob (f)
  ![](basic/f/blondebob.png),
  Blonde Short (f)
  ![](basic/f/blondeshort.png),
  Clown Hair Green (m/f)
  ![](basic/m/clownhairgreen.png)
  ![](basic/f/clownhairgreen.png),
  Crazy Hair (m/f)
  ![](basic/m/crazyhair.png)
  ![](basic/f/crazyhair.png),
  Dark Hair (f)
  ![](basic/f/darkhair.png),
  Frumpy Hair (m/f)
  ![](basic/m/frumpyhair.png)
  ![](basic/f/frumpyhair.png),
  Half Shaved (f)
  ![](basic/f/halfshaved.png),
  Messy Hair (m/f)
  ![](basic/m/messyhair.png)
  ![](basic/f/messyhair.png),
  Mohawk (m/f)
  ![](basic/m/mohawk.png)
  ![](basic/f/mohawk.png),
  Mohawk Dark (m/f)
  ![](basic/m/mohawkdark.png)
  ![](basic/f/mohawkdark.png),
  Mohawk Thin (m/f)
  ![](basic/m/mohawkthin.png)
  ![](basic/f/mohawkthin.png),
  Orange Side (f)
  ![](basic/f/orangeside.png),
  Peak Spike (m)
  ![](basic/m/peakspike.png),
  Pigtails (f)
  ![](basic/f/pigtails.png),
  Pink With Hat (f)
  ![](basic/f/pinkwithhat.png),
  Purple Hair (m)
  ![](basic/m/purplehair.png),
  Red Mohawk (f)
  ![](basic/f/redmohawk.png),
  Shaved Head (m)
  ![](basic/m/shavedhead.png),
  Straight Hair (f)
  ![](basic/f/straighthair.png),
  Straight Hair Blonde (f)
  ![](basic/f/straighthairblonde.png),
  Straight Hair Dark (f)
  ![](basic/f/straighthairdark.png),
  Stringy Hair (m/f)
  ![](basic/m/stringyhair.png)
  ![](basic/f/stringyhair.png),
  Vampire Hair (m)
  ![](basic/m/vampirehair.png),
  Wild Blonde (f)
  ![](basic/f/wildblonde.png),
  Wild Hair (m/f)
  ![](basic/m/wildhair.png)
  ![](basic/f/wildhair.png),
  Wild White Hair (f)
  ![](basic/f/wildwhitehair.png)
- Eyes -
  3D Glasses (m/f)
   ![](basic/m/3dglasses.png)
   ![](basic/f/3dglasses.png),
  Big Shades (m/f)
  ![](basic/m/bigshades.png)
  ![](basic/f/bigshades.png),
  Classic Shades (m/f)
  ![](basic/m/classicshades.png)
  ![](basic/f/classicshades.png),
  Eye Mask (m/f)
  ![](basic/m/eyemask.png)
  ![](basic/f/eyemask.png),
  Eye Patch (m/f)
  ![](basic/m/eyepatch.png)
  ![](basic/f/eyepatch.png),
  Horned Rim Glasses (m/f)
  ![](basic/m/hornedrimglasses.png)
  ![](basic/f/hornedrimglasses.png),
  Nerd Glasses (m/f)
  ![](basic/m/nerdglasses.png)
  ![](basic/f/nerdglasses.png),
  Regular Shades (m/f)
  ![](basic/m/regularshades.png)
  ![](basic/f/regularshades.png),
  Small Shades (m)
  ![](basic/m/smallshades.png),
  VR (m/f)
  ![](basic/m/vr.png)
  ![](basic/f/vr.png),
  Welding Goggles (f)
  ![](basic/f/weldinggoggles.png)
- Eyes (Makeup) -
  Blue Eye Shadow (f)
  ![](basic/f/blueeyeshadow.png),
  Clown Eyes Blue (m/f)
  ![](basic/m/clowneyesblue.png)
  ![](basic/f/clowneyesblue.png),
  Clown Eyes Green (m/f)
  ![](basic/m/clowneyesgreen.png)
  ![](basic/f/clowneyesgreen.png),
  Green Eye Shadow (f)
  ![](basic/f/greeneyeshadow.png),
  Purple Eye Shadow (f)
  ![](basic/f/purpleeyeshadow.png)
- Blemishes -
  Mole (m/f)
   ![](basic/m/mole.png)
   ![](basic/f/mole.png),
  Rosy Cheeks (m/f)
   ![](basic/m/rosycheeks.png)
   ![](basic/f/rosycheeks.png),
  Spots (m/f)
   ![](basic/m/spots.png)
   ![](basic/f/spots.png)
- Nose -
  Clown Nose (m/f)
   ![](basic/m/clownnose.png)
   ![](basic/f/clownnose.png),
- Ears -
  Earring (m/f)
   ![](basic/m/earring.png)
   ![](basic/f/earring.png)
- Mouth -
  Buck Teeth (m)
   ![](basic/m/buckteeth.png),
  Frown (m)
   ![](basic/m/frown.png),
  Smile (m)
   ![](basic/m/smile.png)
- Mouth (Makeup) -
  Black Lipstick (f)
   ![](basic/f/blacklipstick.png),
  Hot Lipstick (f)
   ![](basic/f/hotlipstick.png),
  Purple Lipstick (f)
   ![](basic/f/purplelipstick.png)
- Mouth Prop -
  Cigarette (m/f)
   ![](basic/m/cigarette.png)
   ![](basic/f/cigarette.png),
  Medical Mask (m/f)
   ![](basic/m/medicalmask.png)
   ![](basic/f/medicalmask.png),
  Pipe (m/f)
   ![](basic/m/pipe.png)
   ![](basic/f/pipe.png),
  Vape (m/f)
   ![](basic/m/vape.png)
   ![](basic/f/vape.png)
- Beard -
  Big Beard (m)
   ![](basic/m/bigbeard.png),
  Chinstrap (m)
   ![](basic/m/chinstrap.png),
  Front Beard (m)
   ![](basic/m/frontbeard.png),
  Front Beard Dark (m)
   ![](basic/m/frontbearddark.png),
  Goat (m)
   ![](basic/m/goat.png),
  Handlebars (m)
   ![](basic/m/handlebars.png),
  Luxurious Beard (m)
   ![](basic/m/luxuriousbeard.png),
  Mustache (m)
   ![](basic/m/mustache.png),
  Muttonchops (m)
   ![](basic/m/muttonchops.png),
  Normal Beard (m)
   ![](basic/m/normalbeard.png),
  Normal Beard Black (m)
   ![](basic/m/normalbeardblack.png),
  Shadow Beard (m)
   ![](basic/m/shadowbeard.png)
- Neck Accessory -
  Choker (f)
   ![](basic/f/choker.png),
  Gold Chain (m/f)
   ![](basic/m/goldchain.png)
   ![](basic/f/goldchain.png),
  Silver Chain (m/f)
   ![](basic/m/silverchain.png)
   ![](basic/f/silverchain.png)


<!-- break -->

(Source: [Punk (Building) Blocks - Basic Series (24x24)](https://github.com/cryptopunksnotdead/punks.blocks#basic-punks-series-2424))


Bonus - Let's add Laser Eyes (m) ![](basic/m/lasereyes.png),
Laser Eyes Gold (m) ![](basic/m/lasereyesgold.png).




### Step 1 -  Generate A List of Your Pixel Art Collection in Tabular Text Format (Spreadsheet)

Let's again generate the list of the pixel art collection
by hand. Let's (re)use the rarity & popularity distribution of
the original series that starts with 56 males and 44 females.

Note: Let's use numbers for the four
male and female (arche)types
skintone variants, that is,
1 - darker, 2 - dark, 3 - light, 4 - lighter.
Example  -  [`punks.csv`](no2/punks.csv):

``` csv
type,        attribute1, attribute2, attribute3, attribute4, attribute5
Female 2, Earring, Blonde Bob, Green Eye Shadow
Male 1, Smile, Mohawk, Laser Eyes
Female 3, Wild Hair
Male 1, Wild Hair, Pipe, Nerd Glasses
Male 2, Goat, Earring, Wild Hair, Big Shades
Female 2, Earring, Half Shaved, Purple Eye Shadow
Male 2, Do-rag, Laser Eyes Gold
Female 2, Spots, Wild White Hair, Clown Eyes Blue
Male 1, Luxurious Beard, Messy Hair
Male 2, Big Beard, Police Cap, Clown Nose
Female 1, Mohawk, Blue Eye Shadow
Female 2, Black Lipstick, Straight Hair Dark, Clown Eyes Green
Female 1, Purple Lipstick, Blonde Short
Female 3, Black Lipstick, Straight Hair Blonde, Big Shades
Female 1, Hot Lipstick, Pilot Helmet, Pipe
Male 4, Luxurious Beard, Wild Hair, Regular Shades
Male 2, Earring, Stringy Hair, Small Shades
Male 3, Frown, Mohawk
Male 2, Muttonchops, Eye Mask
Female 1, Hot Lipstick, Bandana, Horned Rim Glasses
Male 3, Crazy Hair
Male 3, Earring, Messy Hair, Classic Shades
Female 1, Purple Lipstick, Pilot Helmet
Male 3, Handlebars, Earring, Do-rag
Male 3, Smile, Mohawk Dark
Female 1, Wild White Hair
Female 2, Dark Hair
Male 3, Earring, Peak Spike
Male 1, Crazy Hair, Big Shades
Female 2, Earring, Half Shaved, Horned Rim Glasses
Male 1, Normal Beard Black, Cap
Female 1, Stringy Hair
Male 3, Frown, VR
Male 3, Peak Spike
Female 3, Purple Lipstick, Frumpy Hair
Male 1, Normal Beard, Earring, Peak Spike, Cigarette, Horned Rim Glasses
Female 2, Red Mohawk
Female 1, Cap, Clown Eyes Blue
Female 3, Purple Lipstick, Frumpy Hair, Classic Shades
Male 3, Frown, Shaved Head, Regular Shades
Male 3, Smile, Chinstrap, Bandana
Male 1, Muttonchops, Wild Hair, Clown Eyes Green
Female 1, Wild Hair, Cigarette
Female 2, Half Shaved
Male 3, Messy Hair
Male 2, Mole, Earring
Female 2, Purple Lipstick, Straight Hair Dark
Male 1, Knitted Cap
Male 3, Mohawk, Big Shades
Female 1, Bandana, Purple Eye Shadow
Male 2, Spots, Fedora
Male 2, Muttonchops, Earring, Wild Hair
Male 1, Shadow Beard, Earring, Knitted Cap, Nerd Glasses
Female 3, Straight Hair, Big Shades
Male 1, Hoodie
Male 3, Eye Patch
Male 1, Shaved Head
Male 3, Headband
Male 2, Normal Beard Black, Hoodie
Male 4, Muttonchops, Cowboy Hat
Female 3, Purple Lipstick, Stringy Hair
Female 3, Dark Hair
Female 1, Hot Lipstick, Earring, Mohawk Dark, Clown Eyes Blue
Male 1, Earring, Shaved Head, Small Shades
Female 2, Purple Lipstick, Straight Hair Blonde
Female 2, Headband, Eye Mask
Female 1, Tassle Hat
Female 1, Purple Lipstick, Half Shaved, 3D Glasses
Male 1, Do-rag, Nerd Glasses
Male 2, Normal Beard Black, Fedora
Female 2, Earring, Crazy Hair, Cigarette, Regular Shades
Female 3, Purple Lipstick, Half Shaved, Green Eye Shadow
Male 1, Normal Beard, Earring, Fedora, Nerd Glasses
Female 2, Black Lipstick, Earring, Bandana
Male 1, Shadow Beard, Earring, Mohawk Dark
Male 3, Shadow Beard, Knitted Cap, Eye Patch
Male 3, Do-rag, Cigarette
Male 1, Handlebars, Stringy Hair
Male 2, Handlebars, Knitted Cap, Eye Patch
Male 1, Normal Beard, Mohawk Dark
Male 4, Mustache, Wild Hair
Male 3, Headband, Small Shades
Male 4, Headband
Male 3, Shaved Head, Vape, Small Shades
Male 3, Earring, Messy Hair, Big Shades
Female 1, Crazy Hair
Female 1, Hot Lipstick, Earring, Knitted Cap, Green Eye Shadow
Male 3, Earring, Hoodie
Female 3, Hot Lipstick, Cap
Female 1, Choker
Male 2, Hoodie, Eye Patch
Female 3, Straight Hair, Clown Nose
Female 3, Purple Lipstick, Pink With Hat, Nerd Glasses
Female 3, Bandana
Female 1, Earring, Pink With Hat, Regular Shades
Male 2, Earring, Mohawk
Female 3, Blonde Bob
Male 2, Wild Hair
Female 3, Black Lipstick, Dark Hair, Welding Goggles
Male 2, Hoodie, Cigarette
```

Note - see if you can spot the never-befor-seen super rare punks
with Laser Eyes and Laser Eyes Gold.



### Step 2  - Generate All Pixel Art Images in Original Format and In 20x

Now the "magic" let's read in the list
in the comma-separated values (.CSV) format
and generate all pixel art images in the original format
(24x24) and in 20x (480x480).


``` ruby
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
```

Note: The attributes (see above) come
in two editions, that is,  m - male (stored in the `/m` directory)
and f - female (stored in the `/f` directory).
To map the attribute (or "qualify"
the name with an extra auto-added directory)
let's configure
the "qualifier" by archetype, that is,
Male 1/2/3/4, Zombie, Ape and Alien will auto-add the `/m` directory
to the attribute image lookup and
Female 1/2/3/4 will aut-add the `/f` directory.


Yes, that's it.
Run the script to generate algorithmically your collection.

In the `/o` directory you will now find
two images per punk - in the orginal format, that is, 24x24
and 20x, that is, 480x480 - and get:

```
no2/
  punk0.png
  punk0@20x.png
  punk1.png
  punk1@20x.png
  punk2.png
  punk2@20x.png
  punk3.png
  punk3@20x.png
  punk4.png
  punk4@20x.png
  punk5.png
  punk5@20x.png
  punk6.png
  punk6@20x.png
  punk7.png
  punk7@20x.png
  punk8.png
  punk8@20x.png
  ...
```

Let's open up `punk0.png` to `punk99.png`:

![](i/no2/punk0.png)
![](i/no2/punk1.png)
![](i/no2/punk2.png)
![](i/no2/punk3.png)
![](i/no2/punk4.png)
![](i/no2/punk5.png)
![](i/no2/punk6.png)
![](i/no2/punk7.png)
![](i/no2/punk8.png)
![](i/no2/punk9.png)
![](i/no2/punk10.png)
![](i/no2/punk11.png)
![](i/no2/punk12.png)
![](i/no2/punk13.png)
![](i/no2/punk14.png)
![](i/no2/punk15.png)
![](i/no2/punk16.png)
![](i/no2/punk17.png)
![](i/no2/punk18.png)
![](i/no2/punk19.png)
![](i/no2/punk20.png)
![](i/no2/punk21.png)
![](i/no2/punk22.png)
![](i/no2/punk23.png)
![](i/no2/punk24.png)
![](i/no2/punk25.png)
![](i/no2/punk26.png)
![](i/no2/punk27.png)
![](i/no2/punk28.png)
![](i/no2/punk29.png)
![](i/no2/punk30.png)
![](i/no2/punk31.png)
![](i/no2/punk32.png)
![](i/no2/punk33.png)
![](i/no2/punk34.png)
![](i/no2/punk35.png)
![](i/no2/punk36.png)
![](i/no2/punk37.png)
![](i/no2/punk38.png)
![](i/no2/punk39.png)
![](i/no2/punk40.png)
![](i/no2/punk41.png)
![](i/no2/punk42.png)
![](i/no2/punk43.png)
![](i/no2/punk44.png)
![](i/no2/punk45.png)
![](i/no2/punk46.png)
![](i/no2/punk47.png)
![](i/no2/punk48.png)
![](i/no2/punk49.png)
![](i/no2/punk50.png)
![](i/no2/punk51.png)
![](i/no2/punk52.png)
![](i/no2/punk53.png)
![](i/no2/punk54.png)
![](i/no2/punk55.png)
![](i/no2/punk56.png)
![](i/no2/punk57.png)
![](i/no2/punk58.png)
![](i/no2/punk59.png)
![](i/no2/punk60.png)
![](i/no2/punk61.png)
![](i/no2/punk62.png)
![](i/no2/punk63.png)
![](i/no2/punk64.png)
![](i/no2/punk65.png)
![](i/no2/punk66.png)
![](i/no2/punk67.png)
![](i/no2/punk68.png)
![](i/no2/punk69.png)
![](i/no2/punk70.png)
![](i/no2/punk71.png)
![](i/no2/punk72.png)
![](i/no2/punk73.png)
![](i/no2/punk74.png)
![](i/no2/punk75.png)
![](i/no2/punk76.png)
![](i/no2/punk77.png)
![](i/no2/punk78.png)
![](i/no2/punk79.png)
![](i/no2/punk80.png)
![](i/no2/punk81.png)
![](i/no2/punk82.png)
![](i/no2/punk83.png)
![](i/no2/punk84.png)
![](i/no2/punk85.png)
![](i/no2/punk86.png)
![](i/no2/punk87.png)
![](i/no2/punk88.png)
![](i/no2/punk89.png)
![](i/no2/punk90.png)
![](i/no2/punk91.png)
![](i/no2/punk92.png)
![](i/no2/punk93.png)
![](i/no2/punk94.png)
![](i/no2/punk95.png)
![](i/no2/punk96.png)
![](i/no2/punk97.png)
![](i/no2/punk98.png)
![](i/no2/punk99.png)


And let's have a looksie at the biggie 20x (480x480) versions:

![](i/no2/punk0@20x.png)

![](i/no2/punk1@20x.png)

[...]

![](i/no2/punk99@20x.png)




### Step 3 - Bonus: Generate an All-In-One Composite Image

Again let's generate an all-in-one composite image holding the complete
collection in a 10x10 grid.

``` ruby
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


## 10x10 grid with every tile 24x24
punks = CompositeImage.new( 10, 10 )

recs.each_with_index do |rec,i|
  punk = art.generate( rec )
  punks << punk
end

punks.save( './o/no2/punks.png')
```

Yes, that's it.
Run the script to generate algorithmically your collection
in an all-in-one composite.

Open up `punks.png` to have a looksie.

![](i/no2/punks.png)





## Collection №3 -  The First One Hundred Pixel Art Punks - The Black & White (Pencil Drawing) Sketch Edition

Let's redo the the first one hundred pixel art punks collection
and let's pick a pixel art special effect.

Tip:  See [**Pixel Art Special Effects Gallery / Cheatsheet - Free Ideas & Recipes for Starting Your Own CryptoPunks Collection Today**](https://github.com/cryptopunksnotdead/programming-cryptopunks/blob/master/A1_special_effects.md)
in the free (online) Programming CryptoPunks & Copypasta Step-by-Step Book(let).



### Step 1 -  Generate A List of Your Pixel Art Collection in Tabular Text Format (Spreadsheet)

Same as in collection №2 above.
Let's (re)use [`punks.csv`](no3/punks.csv).


### Step 2  - Generate All Pixel Art Images in Original Format and In 20x


Same as in collection №2 above.
Plus let's try the black & white (pencil drawing) sketch special effect.


``` ruby
#  [..]

recs.each_with_index do |rec,i|
  name = "punk#{i}"
  punk = art.generate( rec )

  punk_sketch = punk.sketch( 1, line: 1 )
  punk_sketch.save( "./o/no3/#{name}.png" )

  punk_sketch = punk.sketch( 20, line: 4 )
  punk_sketch.save( "./o/no3/#{name}@20x.png" )
end
```

Note: The minimum format for a black & white (pencil drawing) sketch
is 49x49px (24\*1 + 25\*1 = 49px), that is,  24 "inner" white pixels and 25 "outline" black pixels.
And the 20x version becomes 580x580px (20\*24 + 4\*25 = 580px),
that is, with a 24\*20 "inner"
white pixel and 25\*4 "outline" black pixels.


Yes, that's it.
Run the script to generate algorithmically your collection.

In the `/o` directory you will now find
two images per punk - in the orginal format, that is, 49x49
and 20x, that is, 580x580 - and get:

```
no3/
  punk0.png
  punk0@20x.png
  punk1.png
  punk1@20x.png
  punk2.png
  punk2@20x.png
  punk3.png
  punk3@20x.png
  punk4.png
  punk4@20x.png
  punk5.png
  punk5@20x.png
  punk6.png
  punk6@20x.png
  punk7.png
  punk7@20x.png
  punk8.png
  punk8@20x.png
  ...
```

Let's open up `punk0.png` to `punk99.png`:

![](i/no3/punk0.png)
![](i/no3/punk1.png)
![](i/no3/punk2.png)
![](i/no3/punk3.png)
![](i/no3/punk4.png)
![](i/no3/punk5.png)
![](i/no3/punk6.png)
![](i/no3/punk7.png)
![](i/no3/punk8.png)
![](i/no3/punk9.png)
![](i/no3/punk10.png)
![](i/no3/punk11.png)
![](i/no3/punk12.png)
![](i/no3/punk13.png)
![](i/no3/punk14.png)
![](i/no3/punk15.png)
![](i/no3/punk16.png)
![](i/no3/punk17.png)
![](i/no3/punk18.png)
![](i/no3/punk19.png)
![](i/no3/punk20.png)
![](i/no3/punk21.png)
![](i/no3/punk22.png)
![](i/no3/punk23.png)
![](i/no3/punk24.png)
![](i/no3/punk25.png)
![](i/no3/punk26.png)
![](i/no3/punk27.png)
![](i/no3/punk28.png)
![](i/no3/punk29.png)
![](i/no3/punk30.png)
![](i/no3/punk31.png)
![](i/no3/punk32.png)
![](i/no3/punk33.png)
![](i/no3/punk34.png)
![](i/no3/punk35.png)
![](i/no3/punk36.png)
![](i/no3/punk37.png)
![](i/no3/punk38.png)
![](i/no3/punk39.png)
![](i/no3/punk40.png)
![](i/no3/punk41.png)
![](i/no3/punk42.png)
![](i/no3/punk43.png)
![](i/no3/punk44.png)
![](i/no3/punk45.png)
![](i/no3/punk46.png)
![](i/no3/punk47.png)
![](i/no3/punk48.png)
![](i/no3/punk49.png)
![](i/no3/punk50.png)
![](i/no3/punk51.png)
![](i/no3/punk52.png)
![](i/no3/punk53.png)
![](i/no3/punk54.png)
![](i/no3/punk55.png)
![](i/no3/punk56.png)
![](i/no3/punk57.png)
![](i/no3/punk58.png)
![](i/no3/punk59.png)
![](i/no3/punk60.png)
![](i/no3/punk61.png)
![](i/no3/punk62.png)
![](i/no3/punk63.png)
![](i/no3/punk64.png)
![](i/no3/punk65.png)
![](i/no3/punk66.png)
![](i/no3/punk67.png)
![](i/no3/punk68.png)
![](i/no3/punk69.png)
![](i/no3/punk70.png)
![](i/no3/punk71.png)
![](i/no3/punk72.png)
![](i/no3/punk73.png)
![](i/no3/punk74.png)
![](i/no3/punk75.png)
![](i/no3/punk76.png)
![](i/no3/punk77.png)
![](i/no3/punk78.png)
![](i/no3/punk79.png)
![](i/no3/punk80.png)
![](i/no3/punk81.png)
![](i/no3/punk82.png)
![](i/no3/punk83.png)
![](i/no3/punk84.png)
![](i/no3/punk85.png)
![](i/no3/punk86.png)
![](i/no3/punk87.png)
![](i/no3/punk88.png)
![](i/no3/punk89.png)
![](i/no3/punk90.png)
![](i/no3/punk91.png)
![](i/no3/punk92.png)
![](i/no3/punk93.png)
![](i/no3/punk94.png)
![](i/no3/punk95.png)
![](i/no3/punk96.png)
![](i/no3/punk97.png)
![](i/no3/punk98.png)
![](i/no3/punk99.png)


And let's have a looksie at the biggie 20x (580x580) versions:

![](i/no3/punk0@20x.png)

![](i/no3/punk1@20x.png)

[...]

![](i/no3/punk99@20x.png)



### Step 3 - Bonus: Generate an All-In-One Composite Image

Same as in collection №2 above.
Plus let's try the black & white (pencil drawing) sketch special effect.


``` ruby
#  [..]

## 10x10 grid with every tile 49x49
punks = CompositeImage.new( 10, 10, width: 49, height: 49 )

recs.each_with_index do |rec,i|
  punk = art.generate( rec )

  punk_sketch = punk.sketch( 1, line: 1 )

  punks << punk_sketch
end

punks.save( './o/no3/punks.png')
```

Yes, that's it.
Run the script to generate algorithmically your collection
in an all-in-one composite.

Open up `punks.png` to have a looksie.

![](i/no3/punks.png)


To be continued...








## Appendix


### Frequently Asked Questions (F.A.Qs)

**Q:  Can I use a different pixel format for the collection e.g. 16x16 (instead of the classic 24x24)?**

A: Yes,  it works with any square pixel size (e.g. 16x16, 24x24, 32x32).
Note: If you use the `CompositeImage` the default width x height is set to 24 x 24 - if you use a different size
you have to pass in width and height e.g.

``` ruby
# 5x5 grid with every tile 16x16
composite = CompositeImage.new( 5, 5, width: 16, height: 16 )
```

**Q: I am trying to make a composite of 30 variations with a base size of 125x125 px each. I can't seem to figure out how to adjust the settings to make it generate a composite without all of the results overlapping each other. Any ideas?**

The CompositeImage defaults to width: 24, height: 24, thus, if you use a different dimension / canvas
you have to pass along the "custom" width and height.
Example with a 10x3 grid (equal to 30 tiles / variations)  and 125x125 width x height:

``` ruby
composite = CompositeImage.new( 10, 3, width: 125, height: 125 )
```



### Troubleshooting


**Q: I cannot get the `./generate.rb` script to run [in Powershell / in Sublime / in ...]?**

A: Make sure you run the script in the "top-level", that is, `/punks.starter` and you use `no1/generate.rb` or `no2/generate.rb` or `no3/generate.rb`:

```
/punks.starter
   boot.rb
   /no1
      dodge.csv
      generate.rb
   /no2
      punks.csv
      generate.rb
   /no3
      punks.csv
      generate.rb
```

And run inside the `/punks.starter` directory:

```
$ ruby no1/generate.rb          # start in /punks.starter
```


**Q: When running `ruby no1/generate.rb` (in /punks.starter) I get the error `wrong number of arguments (given 2, expected 1) (ArgumentError)` after upgrading to ruby 3.x, before that all was fine, please help.**

```
punks.starter> $ ruby no1/generate.rb
pixelart/0.2.2 on Ruby 3.0.2 (2021-07-07)
  csvreader-1.2.4/lib/csvreader/parser_std.rb:116:in `parse': wrong number of arguments (given 2, expected 1) (ArgumentError)
    [...]
    from punks.starter/generate.rb:8:in `read_csv'
    from no1/generate.rb:10:in `<main>'
```


A: Sorry for the trouble -  this is a known issue / bug -
the scripts run only on the ruby 2.x series for now.
This is a ruby 3.x non-backwards-compatibility issue (with keyword arguments) that needs to get fixed.
If you can downgrade to the 2.x series and retry.

To check that reading your .csv dataset works use something like (save as `testcsv.rb` in `/punks.starter`,
for example and run as `ruby ./testcsv.rb`):

``` ruby
require 'csvreader'

def read_csv( path )
  CsvHash.read( path )
end

recs = read_csv( './no1/dodge.csv' )
puts "  #{recs.size} record(s)"
#=>  25 record(s)
```

Of course you might change `dodge.csv` to `punks.csv` or such and the record size will be different
depending on how many records you have and so on.






## Questions? Comments?

Post them on the [CryptoPunksDev reddit](https://old.reddit.com/r/CryptoPunksDev). Thanks.



