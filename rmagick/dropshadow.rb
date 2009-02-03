require 'RMagick'

class DropShadow
  def initialize(config={})
    @shadow_width = config[:shadow_width] || 10
    @with_border = config[:with_border]
    @with_frame = config[:with_frame]
    @border_margin = config[:border_margin] || 0
    @border_color = config[:border_color] || 'black'
    @shadow_color = config[:shadow_color] || 'gray75'
  end

  def draw(image)
    image = draw_frame(image) if @with_frame
    image = draw_border(image) if @with_border
    image = draw_shadow(image) unless @without_shadow
  end

  def draw_frame(image)
    image = image.border(1, 1, 'gray')
    frame_width = @shadow_width / 2
    image.border(frame_width, frame_width, 'white')
  end

  def draw_border(image)
    image.border(1, 1, @border_color)
  end

  def draw_shadow(image)
    width = image.columns
    height = image.rows
    magick = image.format
    if ['GIF', 'PNG'].include?(magick)
      color = '#facade'
    else
      color = 'white'
    end
    image = image.border(@shadow_width, @shadow_width, color)

    x2 = width + @shadow_width
    y2 = height + @shadow_width

    image.crop!(@shadow_width, @shadow_width, x2, y2)

    draw = Magick::Draw.new
    draw.fill(@shadow_color)
    draw.rectangle(@shadow_width, height, x2, y2)
    draw.rectangle(width, @shadow_width, x2, y2)
    draw.draw(image)

    return image
  end
end

if __FILE__ == $0
  require 'optparse'

  def parse_options
    options = Hash.new

    argv = ARGV.options do |opts|

      opts.on('-w', '--width=N', Integer) {|v| options[:shadow_width] = v }
      opts.on('-b', '--border') { |v| options[:with_border] = true }
      opts.on('-f', '--frame') { |v| options[:with_frame] = true }
      opts.on('-n', '--no-shadow') { |v| options[:without_shadow] = true }
      opts.on('-c', '--shadow-color=COLOR', String) { |v|
        options[:shadow_color] = v
      }
      opts.on('-C', '--border-color=COLOR', String) { |v|
        options[:border_color] = v
      }

      opts.parse!
    end

    exit(1) unless argv

    options
  end

  def read_image(fname)
    ary = Magick::Image.read(fname)
    ary[0]
  end

  def main
    options = parse_options
    drop_shadow = DropShadow.new(options)

    exit unless ARGV.size >= 1

    image = read_image(ARGV[0] || '-')
    image = drop_shadow.draw(image)

    ext = image.format
    image.write("#{ext}:-")
  end

  main()
end

