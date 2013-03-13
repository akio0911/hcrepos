# -*- coding: utf-8 -*-

require 'fcntl'
require 'termios'
include Termios

require 'socket'
require 'thread'

class Tds01v
  BAUDRATE = B9600
  def initialize
  end
  def dev_open(path)
    dev = open(path, File::RDWR | File::NONBLOCK)
    mode = dev.fcntl(Fcntl::F_GETFL, 0)
    dev.fcntl(Fcntl::F_SETFL, mode & ~File::NONBLOCK)
    dev
  end
  def dump_termios(tio, banner)
    puts banner
    puts "  ispeed = #{BAUDS[tio.ispeed]}, ospeed = #{BAUDS[tio.ospeed]}"
    ["iflag", "oflag", "cflag", "lflag"].each do |x|
      flag = tio.send(x)
      flags = []
      eval("#{x.upcase}S").each do |f, sym|
        flags << sym.to_s if flag & f != 0
      end
      puts "   #{x} = #{flags.sort.join(' | ')}"
    end
    print "      cc ="
    cc = tio.cc
    cc.each_with_index do |x, idx|
      print " #{CCINDEX[idx]}=#{x}" if CCINDEX.include?(idx)
    end
    puts
  end
end

exit

#DEVICE = '/dev/tty.usbserial-00001004'
BAUDRATE = B9600

def dev_open(path)
  dev = open(path, File::RDWR | File::NONBLOCK)
  mode = dev.fcntl(Fcntl::F_GETFL, 0)
  dev.fcntl(Fcntl::F_SETFL, mode & ~File::NONBLOCK)
  dev
end

def dump_termios(tio, banner)
  puts banner
  puts "  ispeed = #{BAUDS[tio.ispeed]}, ospeed = #{BAUDS[tio.ospeed]}"
  ["iflag", "oflag", "cflag", "lflag"].each do |x|
    flag = tio.send(x)
    flags = []
    eval("#{x.upcase}S").each do |f, sym|
      flags << sym.to_s if flag & f != 0
    end
    puts "   #{x} = #{flags.sort.join(' | ')}"
  end
  print "      cc ="
  cc = tio.cc
  cc.each_with_index do |x, idx|
    print " #{CCINDEX[idx]}=#{x}" if CCINDEX.include?(idx)
  end
  puts
end

def get_direction(dev)
  # 計測開始
  # 21<ENTER><ENTER>

  "21\x0d\x0a".each_byte {|c|
    c = c.chr
    #  p [:write_char, c]
    dev.putc c
  }

  # ACK 計測開始応答
  # DE

  #p :echo_back
  (2).times do |i|
    d = dev.getc
    #  putc d && d.chr || nil
    #  p d && d.chr || nil
  end
  (2).times do |i|
    d = dev.getc
    #  putc d && d.chr || nil
    #  p d && d.chr || nil
  end
  #puts ''

  # センサ情報要求
  # 29<ENTER><ENTER>

  "29\x0d\x0a".each_byte {|c|
    c = c.chr
    #  p [:write_char, c]
    dev.putc c
  }

  # センサ情報 全センサ全データ(ベクトルデータ+計測データ)
  # FE85 00A0 00A4 07B9
  # 0005 0006 FFB8 0024
  # FFE5 27AE FFEB 00D5 0B1B

  #p :echo_back

  #puts '# 地磁気センサ ベクトルデータ X'
  vector_x = ''
  4.times do |i|
    d = dev.getc
    c = d && d.chr || nil
    #  putc c
    vector_x += c
  end
=begin
     (2).times do |i|
      d = dev.getc
      c = d && d.chr || nil
      putc c
    end
=end
  #puts ''
  #p vector_x

  #puts '# 地磁気センサ ベクトルデータ Y'
  vector_y = ''
  4.times do |i|
    d = dev.getc
    c = d && d.chr || nil
    #  putc c
    vector_y += c
  end
=begin
     (2).times do |i|
      d = dev.getc
      c = d && d.chr || nil
      putc c
    end
=end
  #puts ''
  #p vector_y

  #puts '# 地磁気センサ ベクトルデータ Z'
  vector_z = ''
  4.times do |i|
    d = dev.getc
    c = d && d.chr || nil
    #  putc c
    vector_z += c
  end
=begin
     (2).times do |i|
      d = dev.getc
      c = d && d.chr || nil
      putc c
    end
=end
  #puts ''
  #p vector_z

  #puts '# 方位角'
  direction = ''
  4.times do |i|
    d = dev.getc
    c = d && d.chr || nil
    #  putc c
    direction += c
  end
=begin
     (2).times do |i|
      d = dev.getc
      c = d && d.chr || nil
      putc c
    end
=end
  #puts ''
  #p direction

  puts "direction : #{direction} #{direction.hex}"
  if direction.hex < 45*10 then
    puts "北"
  elsif direction.hex < (90+45)*10
    puts "東"
  elsif direction.hex < (90*2+45)*10
    puts "南"
  elsif direction.hex < (90*3+45)*10
    puts "西"
  else
    puts "北"
  end


  #puts '# 加速度センサ ベクトルデータ X'
  acc_x = ''
  4.times do |i|
    d = dev.getc
    c = d && d.chr || nil
    #  putc c
    acc_x += c
  end
=begin
     (2).times do |i|
      d = dev.getc
      c = d && d.chr || nil
      putc c
    end
=end
  #puts ''
  #p acc_x

  #puts '# 加速度センサ ベクトルデータ Y'
  acc_y = ''
  4.times do |i|
    d = dev.getc
    c = d && d.chr || nil
    #  putc c
    acc_y += c
  end
=begin
     (2).times do |i|
      d = dev.getc
      c = d && d.chr || nil
      putc c
    end
=end
  #puts ''
  #p acc_y

  #puts '# 加速度センサ ベクトルデータ Z'
  acc_z = ''
  4.times do |i|
    d = dev.getc
    c = d && d.chr || nil
    #  putc c
    acc_z += c
  end
=begin
     (2).times do |i|
      d = dev.getc
      c = d && d.chr || nil
      putc c
    end
=end
  #puts ''
  #p acc_z

  #puts '# 傾斜角情報 Roll'
  roll = ''
  4.times do |i|
    d = dev.getc
    c = d && d.chr || nil
    #  putc c
    roll += c
  end
=begin
     (2).times do |i|
      d = dev.getc
      c = d && d.chr || nil
      putc c
    end
=end
  #puts ''
  #p roll

  #puts '# 傾斜角情報 Pitch'
  pitch = ''
  4.times do |i|
    d = dev.getc
    c = d && d.chr || nil
    #  putc c
    pitch += c
  end
=begin
     (2).times do |i|
      d = dev.getc
      c = d && d.chr || nil
      putc c
    end
=end
  #puts ''
  #p pitch

  #puts '# 気圧情報'
  pressure = ''
  4.times do |i|
    d = dev.getc
    c = d && d.chr || nil
    #  putc c
    pressure += c
  end
=begin
     (2).times do |i|
      d = dev.getc
      c = d && d.chr || nil
      putc c
    end
=end
  #puts ''
  #p pressure

  #puts '# 高度情報'
  altitude = ''
  4.times do |i|
    d = dev.getc
    c = d && d.chr || nil
    #  putc c
    altitude += c
  end
  #puts ''
  #p altitude

  #puts '# 温度情報'
  temp = ''
  4.times do |i|
    d = dev.getc
    c = d && d.chr || nil
    #  putc c
    temp += c
  end
  #puts ''
  #p temp

  #puts '# 電圧情報'
  voltage = ''
  4.times do |i|
    d = dev.getc
    c = d && d.chr || nil
    #  putc c
    voltage += c
  end
  #puts ''
  #p voltage

  (2).times do |i|
    d = dev.getc
    #  putc d && d.chr || nil
    #  p d && d.chr || nil
  end

=begin
     d = dev.getc
     #putc d && d.chr || nil
     #puts ''
=end

  ######################################
  #exit

  return direction.hex
end

if ARGV.size != 1
  puts "デバイスのパスを指定して下さい。"
  return
end

device = ARGV[0]

gs = TCPServer.open(12345)
addr = gs.addr # ["AF_INET6", 12345, "0.0.0.0", "0.0.0.0"]
addr.shift
p addr # [12345, "0.0.0.0", "0.0.0.0"]
printf("server is on %s\n", addr.join(":"))

while true
  # gs.accept は接続要求を待ち受ける
  # 接続要求がくると新しいソケットが作成され、
  # そのままスレッドの引数として渡される
  Thread.start(gs.accept) do |s|
    print(s, "is accepted\n")
#    puts(s.gets)

    #########################
dev = dev_open(device)

oldtio = getattr(dev)
dump_termios(oldtio, "current tio:")

newtio = new_termios()
newtio.iflag = IGNPAR
newtio.oflag = 0
newtio.cflag = (CRTSCTS | CS8 | CREAD)
newtio.lflag = 0
newtio.cc[VTIME] = 0
newtio.cc[VMIN] = 1
newtio.ispeed = BAUDRATE
newtio.ospeed = BAUDRATE
dump_termios(newtio, "new tio:")

flush(dev, TCIOFLUSH)
setattr(dev, TCSANOW, newtio)
dump_termios(getattr(dev), "current tio:")

# NL*	10	012	0x0a
# CR	13	015	0x0d
# http://gps.way-nifty.com/around_gps/2008/06/d_9549.html
# ３Ｄセンサーは改行コードがCR+LFになっています。
# * NL ： "New Line" (改行)の略。「LF」(Line Feed)と呼ばれることもある

# 計測条件設定

"050027950000\x0d\x0a".each_byte {|c|
  c = c.chr
  p [:write_char, c]
  dev.putc c
}

# ACK 計測条件設定応答

p :echo_back
(2).times do |i|
  d = dev.getc
  putc d && d.chr || nil
end
(2).times do |i|
  d = dev.getc
  putc d && d.chr || nil
end
puts ''

# センサ情報項目設定 全センサ全データ(ベクトルデータ+計測データ)
# 0DF7<ENTER><ENTER>

"0DF7\x0d\x0a".each_byte {|c|
  c = c.chr
  p [:write_char, c]
  dev.putc c
}

# ACK センサ情報項目設定応答
# F2

p :echo_back
(2).times do |i|
  d = dev.getc
  putc d && d.chr || nil
end
(2).times do |i|
  d = dev.getc
  putc d && d.chr || nil
end
puts ''

# 地磁気センサ初期化要求
# 27<ENTER><ENTER>

"27\x0d\x0a".each_byte {|c|
  c = c.chr
  p [:write_char, c]
  dev.putc c
}

# ACK 地磁気センサ初期化要求応答
# D8

p :echo_back
(2).times do |i|
  d = dev.getc
  putc d && d.chr || nil
end
(2).times do |i|
  d = dev.getc
  putc d && d.chr || nil
end
puts ''
    #########################

    99999.times do |i|
      p 111111111111
      data = get_direction(dev)
      p 222222222222

#      p s.recv("AAAAAAAA")
#      s.send data

      p s.gets("AAAAAAAAA")
      s.puts("BBBBBBBBBBBBB")

      p 333333333333
    end

    #########################
    #########################

    print(s, " is gone\n")
    s.close
  end
end

# % cu -s 9600 -l /dev/tty.usbserial-0000103D
# Connected.

# 計測条件設定
# 050027950000<ENTER><ENTER>
# ACK 計測条件設定応答
# FA

# センサ情報項目設定 全センサ全データ(ベクトルデータ+計測データ)
# 0DF7<ENTER><ENTER>
# ACK センサ情報項目設定応答
# F2

# 地磁気センサ初期化要求
# 27<ENTER><ENTER>
# ACK 地磁気センサ初期化要求応答
# D8

# 計測開始
# 21<ENTER><ENTER>
# ACK 計測開始応答
# DE

# センサ情報要求
# 29<ENTER><ENTER>
# センサ情報 全センサ全データ(ベクトルデータ+計測データ)
# FE8500A000A407B900050006FFB80024FFE527AEFFEB00D50B1B

# 計測開始
# 21<ENTER><ENTER>
# ACK 計測開始応答
# DE

# センサ情報要求
# 29<ENTER><ENTER>
# センサ情報 全センサ全データ(ベクトルデータ+計測データ)
# FE81009400A807B400020002FFB7000BFFF527B2FFE800D50B1B

# ~.

# akio0911:~# ls /dev/tty.usb*
# /dev/tty.usbserial-00001004
# akio0911:~# cu -s 9600 -l /dev/tty.usbserial-00001004
# Connected.

# REQ 050027950000 # 計測条件設定
# RES FA # ACK 計測条件設定応答

# REQ 0DF7 # センサ情報項目設定 全センサ全データ(ベクトルデータ+計測データ)
# RES F2 # ACK センサ情報項目設定応答

# REQ 27 # 地磁気センサ初期化要求
# RES D8 # ACK 地磁気センサ初期化要求応答

# REQ 21 # 計測開始
# RES DE # ACK 計測開始応答

# REQ 29 # センサ情報要求
# RES 0042 007D FDE5 0B7C 0004 0011 FFB8 0060 FFEC 27B7 FFE4 0137 0B17 # センサ情報 全センサ全データ(ベクトルデータ+計測データ)

# REQ 21 # 計測開始
# RES DE # ACK 計測開始応答

# REQ 29 # センサ情報要求
# RES 0042 007D FDED 0C2C 0004 FFFB FFB1 FFE5 FFEA 27B8 FFE3 0137 0B17 # センサ情報 全センサ全データ(ベクトルデータ+計測データ)

# ~.

# sudo gem install termios
# Building native extensions.  This could take a while...
# Successfully installed termios-0.9.4
# 1 gem installed

# port search termios
# rb-termios @0.9.4 (ruby, sysutils)
#     simple wrapper for termios(3)

# sudo port install rb-termios
# --->  Fetching rb-termios
# --->  Attempting to fetch ruby-termios-0.9.4.tar.gz from http://distfiles.macports.org/ruby
# --->  Verifying checksum(s) for rb-termios
# --->  Extracting rb-termios
# --->  Configuring rb-termios
# --->  Building rb-termios
# --->  Staging rb-termios into destroot
# --->  Installing rb-termios @0.9.4_0
# --->  Activating rb-termios @0.9.4_0
# --->  Cleaning rb-termios
