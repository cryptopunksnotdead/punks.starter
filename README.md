# Pixel Art Collection Quick Starter - Generate Algorithmically Your Own Curated (or Randomized) Collection


Let's start and generate algorithmically a pixel art collection in three steps:

Step 1 - Generate A List of Your Pixel Art Collection in a Tabular Text Format (Spreadsheet)

Step 2 - Generate All Pixel Art Images in Original Format and In 20x

Step 3 - Bonus: Generate an All-In-One Composite Image



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

Attributes -
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
made up of the basic type  and one or more attributes.

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
require './generate'


recs = read_csv( './no1/dodge.csv' )
puts "  #{recs.size} punk(s)"
#=>  25 records


art = Art.new( dir: './dodge' )

recs.each_with_index do |rec,i|
  name = "punk#{i}"
  punk = art.generate( rec )

  punk.save( "./o/no1/#{name}.png" )
  punk.zoom(20).save( "./o/no1/#{name}x20.png" )
end
```

Yes, that's it.
Run the script to generate algorithmically your collection.

In the `/o` directory you will now find
two images per punk (in the orginal format, that is, 24x24
and x20, that is, 480x480) and get:

```
no1/
  punk0.png
  punk0x20.png
  punk1.png
  punk1x20.png
  punk2.png
  punk2x20.png
  punk3.png
  punk3x20.png
  punk4.png
  punk4x20.png
  punk5.png
  punk5x20.png
  punk6.png
  punk6x20.png
  punk7.png
  punk7x20.png
  punk8.png
  punk8x20.png
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


And let's have a looksie at the biggie 20x versions:

![](i/no1/punk0x20.png)

![](i/no1/punk1x20.png)

[...]

![](i/no1/punk24x20.png)



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
require './generate'


recs = read_csv( './no1/dodge.csv' )
puts "  #{recs.size} punk(s)"
#=>  25 records


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
Let's try to generate a pixel-perfect copy of the first one hundred punks in the original Larva Labs series in the classic 24x24
format.

Let's copy and (re)use all punk (building) blocks
in the original series (24x24):

Male 1/2/3/4 ![](original/male1.png)
![](original/male2.png)
![](original/male3.png)
![](original/male4.png),
Female 1/2/3/4 ![](original/female1.png)
![](original/female2.png)
![](original/female3.png)
![](original/female4.png),
Zombie ![](original/zombie.png),
Ape ![](original/ape.png),
Alien ![](original/alien.png)

<!-- note:
  sort attributes a-z for now - why? why not?
-->

Attributes -
- Hat -
  Bandana (m/f)
  ![](original/m/bandana.png)
  ![](original/f/bandana.png),
  Beanie (m)
  ![](original/m/beanie.png),
  Cap (m/f)
  ![](original/m/cap.png)
  ![](original/f/cap.png),
  Cap Forward (m)
  ![](original/m/capforward.png),
  Cowboy Hat (m)
  ![](original/m/cowboyhat.png),
  Do-rag (m)
  ![](original/m/dorag.png),
  Fedora (m)
  ![](original/m/fedora.png),
  Headband (m/f)
  ![](original/m/headband.png)
  ![](original/f/headband.png),
  Hoodie (m)
  ![](original/m/hoodie.png),
  Knitted Cap (m/f)
  ![](original/m/knittedcap.png)
  ![](original/f/knittedcap.png),
  Pilot Helmet (f)
  ![](original/f/pilothelmet.png),
  Police Cap (m)
  ![](original/m/policecap.png),
  Tassle Hat (f)
  ![](original/f/tasslehat.png),
  Tiara (f)
  ![](original/f/tiara.png),
  Top Hat (m)
  ![](original/m/tophat.png)
- Hair -
  Blonde Bob (f)
  ![](original/f/blondebob.png),
  Blonde Short (f)
  ![](original/f/blondeshort.png),
  Clown Hair Green (m/f)
  ![](original/m/clownhairgreen.png)
  ![](original/f/clownhairgreen.png),
  Crazy Hair (m/f)
  ![](original/m/crazyhair.png)
  ![](original/f/crazyhair.png),
  Dark Hair (f)
  ![](original/f/darkhair.png),
  Frumpy Hair (m/f)
  ![](original/m/frumpyhair.png)
  ![](original/f/frumpyhair.png),
  Half Shaved (f)
  ![](original/f/halfshaved.png),
  Messy Hair (m/f)
  ![](original/m/messyhair.png)
  ![](original/f/messyhair.png),
  Mohawk (m/f)
  ![](original/m/mohawk.png)
  ![](original/f/mohawk.png),
  Mohawk Dark (m/f)
  ![](original/m/mohawkdark.png)
  ![](original/f/mohawkdark.png),
  Mohawk Thin (m/f)
  ![](original/m/mohawkthin.png)
  ![](original/f/mohawkthin.png),
  Orange Side (f)
  ![](original/f/orangeside.png),
  Peak Spike (m)
  ![](original/m/peakspike.png),
  Pigtails (f)
  ![](original/f/pigtails.png),
  Pink With Hat (f)
  ![](original/f/pinkwithhat.png),
  Purple Hair (m)
  ![](original/m/purplehair.png),
  Red Mohawk (f)
  ![](original/f/redmohawk.png),
  Shaved Head (m)
  ![](original/m/shavedhead.png),
  Straight Hair (f)
  ![](original/f/straighthair.png),
  Straight Hair Blonde (f)
  ![](original/f/straighthairblonde.png),
  Straight Hair Dark (f)
  ![](original/f/straighthairdark.png),
  Stringy Hair (m/f)
  ![](original/m/stringyhair.png)
  ![](original/f/stringyhair.png),
  Vampire Hair (m)
  ![](original/m/vampirehair.png),
  Wild Blonde (f)
  ![](original/f/wildblonde.png),
  Wild Hair (m/f)
  ![](original/m/wildhair.png)
  ![](original/f/wildhair.png),
  Wild White Hair (f)
  ![](original/f/wildwhitehair.png)
- Eyes -
  3D Glasses (m/f)
   ![](original/m/3dglasses.png)
   ![](original/f/3dglasses.png),
  Big Shades (m/f)
  ![](original/m/bigshades.png)
  ![](original/f/bigshades.png),
  Classic Shades (m/f)
  ![](original/m/classicshades.png)
  ![](original/f/classicshades.png),
  Eye Mask (m/f)
  ![](original/m/eyemask.png)
  ![](original/f/eyemask.png),
  Eye Patch (m/f)
  ![](original/m/eyepatch.png)
  ![](original/f/eyepatch.png),
  Horned Rim Glasses (m/f)
  ![](original/m/hornedrimglasses.png)
  ![](original/f/hornedrimglasses.png),
  Nerd Glasses (m/f)
  ![](original/m/nerdglasses.png)
  ![](original/f/nerdglasses.png),
  Regular Shades (m/f)
  ![](original/m/regularshades.png)
  ![](original/f/regularshades.png),
  Small Shades (m)
  ![](original/m/smallshades.png),
  VR (m/f)
  ![](original/m/vr.png)
  ![](original/f/vr.png),
  Welding Goggles (f)
  ![](original/f/weldinggoggles.png)
- Eyes (Makeup) -
  Blue Eye Shadow (f)
  ![](original/f/blueeyeshadow.png),
  Clown Eyes Blue (m/f)
  ![](original/m/clowneyesblue.png)
  ![](original/f/clowneyesblue.png),
  Clown Eyes Green (m/f)
  ![](original/m/clowneyesgreen.png)
  ![](original/f/clowneyesgreen.png),
  Green Eye Shadow (f)
  ![](original/f/greeneyeshadow.png),
  Purple Eye Shadow (f)
  ![](original/f/purpleeyeshadow.png)
- Blemishes -
  Mole (m/f)
   ![](original/m/mole.png)
   ![](original/f/mole.png),
  Rosy Cheeks (m/f)
   ![](original/m/rosycheeks.png)
   ![](original/f/rosycheeks.png),
  Spots (m/f)
   ![](original/m/spots.png)
   ![](original/f/spots.png)
- Nose -
  Clown Nose (m/f)
   ![](original/m/clownnose.png)
   ![](original/f/clownnose.png),
- Ears -
  Earring (m/f)
   ![](original/m/earring.png)
   ![](original/f/earring.png)
- Mouth -
  Buck Teeth (m)
   ![](original/m/buckteeth.png),
  Frown (m)
   ![](original/m/frown.png),
  Smile (m)
   ![](original/m/smile.png)
- Mouth (Makeup) -
  Black Lipstick (f)
   ![](original/f/blacklipstick.png),
  Hot Lipstick (f)
   ![](original/f/hotlipstick.png),
  Purple Lipstick (f)
   ![](original/f/purplelipstick.png)
- Mouth Prop -
  Cigarette (m/f)
   ![](original/m/cigarette.png)
   ![](original/f/cigarette.png),
  Medical Mask (m/f)
   ![](original/m/medicalmask.png)
   ![](original/f/medicalmask.png),
  Pipe (m/f)
   ![](original/m/pipe.png)
   ![](original/f/pipe.png),
  Vape (m/f)
   ![](original/m/vape.png)
   ![](original/f/vape.png)
- Beard -
  Big Beard (m)
   ![](original/m/bigbeard.png),
  Chinstrap (m)
   ![](original/m/chinstrap.png),
  Front Beard (m)
   ![](original/m/frontbeard.png),
  Front Beard Dark (m)
   ![](original/m/frontbearddark.png),
  Goat (m)
   ![](original/m/goat.png),
  Handlebars (m)
   ![](original/m/handlebars.png),
  Luxurious Beard (m)
   ![](original/m/luxuriousbeard.png),
  Mustache (m)
   ![](original/m/mustache.png),
  Muttonchops (m)
   ![](original/m/muttonchops.png),
  Normal Beard (m)
   ![](original/m/normalbeard.png),
  Normal Beard Black (m)
   ![](original/m/normalbeardblack.png),
  Shadow Beard (m)
   ![](original/m/shadowbeard.png)
- Neck Accessory -
  Choker (f)
   ![](original/f/choker.png),
  Gold Chain (m/f)
   ![](original/m/goldchain.png)
   ![](original/f/goldchain.png),
  Silver Chain (m/f)
   ![](original/m/silverchain.png)
   ![](original/f/silverchain.png)


<!-- break -->

(Source: [Punk (Building) Blocks - Original Series (24x24)](https://github.com/cryptopunksnotdead/punks.blocks#https://github.com/cryptopunksnotdead/punks.blocks#original-cryptopunks-series-2424))


Bonus - Let's add Laser Eyes (m) ![](original/m/lasereyes.png),
Laser Eyes Gold (m) ![](original/m/lasereyesgold.png).




### Step 1 -  Generate A List of Your Pixel Art Collection in Tabular Text Format (Spreadsheet)

Let's again generate the list of the pixel art collection
by hand. Let's (re)use the rarity & popularity distribution of
the original series that starts with 56 males and 44 females.

Note: Let's use roman numerals for the four
male and female (arche)types
skintone variants, that is,
I - lighter, II - light, III - dark, IV - darker.
Example  -  [`punks.csv`](no2/punks.csv):

``` csv
type,        attribute1, attribute2, attribute3, attribute4, attribute5
Female III,  Green Eye Shadow, Earring, Blonde Bob
Male IIII,   Smile, Mohawk
Female II,   Wild Hair
Male IIII,   Wild Hair, Nerd Glasses, Pipe
Male III,    Big Shades, Wild Hair, Earring, Goat
Female III,  Purple Eye Shadow, Half Shaved, Earring
Male III,    Do-rag
Female III,  Wild White Hair, Spots, Clown Eyes Blue
Male IIII,   Messy Hair, Luxurious Beard
Male III,    Clown Nose, Police Cap, Big Beard
Female IIII, Blue Eye Shadow, Mohawk
Female III,  Black Lipstick, Clown Eyes Green, Straight Hair Dark
Female IIII, Blonde Short, Purple Lipstick
Female II,   Big Shades, Black Lipstick, Straight Hair Blonde
Female IIII, Pipe, Pilot Helmet, Hot Lipstick
Male I,      Luxurious Beard, Wild Hair, Regular Shades
Male III,    Stringy Hair, Earring, Small Shades
Male II,     Frown, Mohawk
Male III,    Eye Mask, Muttonchops
Female IIII, Bandana, Horned Rim Glasses, Hot Lipstick
Male II,     Crazy Hair
Male II,     Messy Hair, Classic Shades, Earring
Female IIII, Pilot Helmet, Purple Lipstick
Male II,     Handlebars, Earring, Do-rag
Male II,     Smile, Mohawk Dark
Female IIII, Wild White Hair
Female III,  Dark Hair
Male II,     Peak Spike, Earring
Male IIII,   Big Shades, Crazy Hair
Female III,  Horned Rim Glasses, Half Shaved, Earring
Male IIII,   Normal Beard Black, Cap
Female IIII, Stringy Hair
Male II,     Frown, VR
Male II,     Peak Spike
Female II,   Frumpy Hair, Purple Lipstick
Male IIII,   Cigarette, Peak Spike, Earring, Horned Rim Glasses, Normal Beard
Female III,  Red Mohawk
Female IIII, Cap, Clown Eyes Blue
Female II,   Frumpy Hair, Classic Shades, Purple Lipstick
Male II,     Frown, Shaved Head, Regular Shades
Male II,     Bandana, Chinstrap, Smile
Male IIII,   Muttonchops, Wild Hair, Clown Eyes Green
Female IIII, Wild Hair, Cigarette
Female III,  Half Shaved
Male II,     Messy Hair
Male III,    Earring, Mole
Female III,  Purple Lipstick, Straight Hair Dark
Male IIII,   Knitted Cap
Male II,     Big Shades, Mohawk
Female IIII, Bandana, Purple Eye Shadow
Male III,    Spots, Fedora
Male III,    Muttonchops, Wild Hair, Earring
Male IIII,   Shadow Beard, Earring, Nerd Glasses, Knitted Cap
Female II,   Big Shades, Straight Hair
Male IIII,   Hoodie
Male II,     Eye Patch
Male IIII,   Shaved Head
Male II,     Headband
Male III,    Normal Beard Black, Hoodie
Male I,      Muttonchops, Cowboy Hat
Female II,   Stringy Hair, Purple Lipstick
Female II,   Dark Hair
Female IIII, Hot Lipstick, Earring, Mohawk Dark, Clown Eyes Blue
Male IIII,   Earring, Shaved Head, Small Shades
Female III,  Straight Hair Blonde, Purple Lipstick
Female III,  Eye Mask, Headband
Female IIII, Tassle Hat
Female IIII, Half Shaved, Purple Lipstick, 3D Glasses
Male IIII,   Nerd Glasses, Do-rag
Male III,    Normal Beard Black, Fedora
Female III,  Crazy Hair, Regular Shades, Earring, Cigarette
Female II,   Green Eye Shadow, Half Shaved, Purple Lipstick
Male IIII,   Fedora, Earring, Nerd Glasses, Normal Beard
Female III,  Black Lipstick, Bandana, Earring
Male IIII,   Shadow Beard, Earring, Mohawk Dark
Male II,     Shadow Beard, Knitted Cap, Eye Patch
Male II,     Cigarette, Do-rag
Male IIII,   Stringy Hair, Handlebars
Male III,    Handlebars, Knitted Cap, Eye Patch
Male IIII,   Normal Beard, Mohawk Dark
Male I,      Wild Hair, Mustache
Male II,     Headband, Small Shades
Male I,      Headband
Male II,     Vape, Shaved Head, Small Shades
Male II,     Messy Hair, Big Shades, Earring
Female IIII, Crazy Hair
Female IIII, Knitted Cap, Green Eye Shadow, Hot Lipstick, Earring
Male II,     Hoodie, Earring
Female II,   Cap, Hot Lipstick
Female IIII, Choker
Male III,    Hoodie, Eye Patch
Female II,   Clown Nose, Straight Hair
Female II,   Pink With Hat, Purple Lipstick, Nerd Glasses
Female II,   Bandana
Female IIII, Pink With Hat, Regular Shades, Earring
Male III,    Earring, Mohawk
Female II,   Blonde Bob
Male III,    Wild Hair
Female II,   Black Lipstick, Welding Goggles, Dark Hair
Male III,    Cigarette, Hoodie
```


To be continued...








## Appendix


### Frequently Asked Questions (F.A.Qs)

**Q:  Can I use a different pixel format for the collection e.g. 16x16 (instead of the classic 24x24)?**

A: Yes,  it works with any square pixel size (e.g. 16x16, 24x24, 32x32).
Note: If you use the `CompositeImage` the default width x height is set to 24 x 24 - if you use a different size
you have to pass in width and height e.g.

``` ruby
composite = CompositeImage.new( 5, 5, width: 16, height: 16 )   # 5x5 grid with every tile 16x16
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

A: Make sure you run the script in the "top-level", that is, `/punks.starter` and you use `no1/generate.rb`. Note: The "top-level"
`./generate.rb` script is a helper (library) script and does NOT run by itself e.g.:

```
/punks.starter
   generate.rb
   /no1
      dodge.csv
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



