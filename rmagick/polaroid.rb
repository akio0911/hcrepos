require "RMagick"

if !ARGV[0]
    puts "Usage: photo.rb path-to-image"
    exit
end

image = Magick::Image.read(ARGV[0]).first

image.border!(18, 18, "#f0f0ff")

image.background_color = "none"

amplitude = image.columns * 0.01
wavelength = image.rows  * 2

image.rotate!(90)
image = image.wave(amplitude, wavelength)
image.rotate!(-90)

shadow = image.flop
shadow = shadow.colorize(1, 1, 1, "gray75")
shadow.background_color = "white"
shadow.border!(10, 10, "white")
shadow = shadow.blur_image(0, 3)

image = shadow.composite(image, -amplitude/2, 5,
                         Magick::OverCompositeOp)

image.rotate!(-5)
image.trim!

out = ARGV[0].sub(/\./, "-print.")
puts "Writing #{out}"
image.write(out)
