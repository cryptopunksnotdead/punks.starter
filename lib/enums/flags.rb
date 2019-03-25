require 'pp'


class Enum

  private

  def self.enum_attr(name, num)
    name = name.to_s

    define_method(name + '?') do
      @attrs & num != 0
    end

    define_method(name + '=') do |set|
      if set
        @attrs |= num
      else
        @attrs &= ~num
      end
    end
  end

  public

  def initialize(attrs = 0)
    @attrs = attrs
  end

  def to_i
    @attrs
  end
end


class Flag
  def initialize( key, power )
    ## start with power (base) 0
    ## e.g. 2^0 = 1 = 0001
    #       2^1 = 2 = 0010
    #       2^2 = 3 = 00010

    @key  = key
    @flag = 2**power
  end

  def to_s
    @flag.to_s(2)
  end
end

f1 = Flag.new( :readonly, 0 )
pp f1
pp f1.to_s

f2 = Flag.new( :hidden, 1 )
pp f2
pp f2.to_s

f3 = Flag.new( :system, 2 )
pp f3
pp f3.to_s

f4 = Flag.new( :system, 3 )
pp f4
pp f4.to_s


__END__
class FileAttributes < Enum
  READONLY = 0b0001      # 2^1 = 2
  enum_attr :hidden,         0b0010      # 2^2 = 4
  enum_attr :system,         0b0100      # 2^3 = 8
  enum_attr :directory,      0b1000      # 2^4 = 16
  enum_attr :archive,        0b1_0000    # 2^5 = 32
  enum_attr :in_rom,         0b10_0000   # 2^6 = 64
  enum_attr :normal,         0b100_0000
  enum_attr :temporary,      0x0100
  enum_attr :sparse,         0x0200
  enum_attr :reparse_point,  0x0400
  enum_attr :compressed,     0x0800
  enum_attr :rom_module,     0x2000
end


pp example = FileAttributes.new(3)
pp example.readonly?
pp example.hidden?
pp example.system?
pp example.system = true
pp example.system?
pp example.to_i
