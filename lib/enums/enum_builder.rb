# encoding: utf-8


module Safe
class Enum


###################
##  meta-programming "macro" - build class (on the fly)
def self.build_class( class_name, *args, **kwargs )

  if args.size > 0
    keys   = args
    values = (0...keys.size).to_a   # note: use ... (exclusive) range
    e = Hash[ keys.zip( values ) ]
  else
    ## assume kwargs
    e = kwargs
  end


  ## todo/fix:
  ##  check class name MUST start with uppercase letter

  ## check if all keys are symbols and follow the ruby id(entifier) naming rules
  e.keys.each do |key|
    if key.is_a?( Symbol ) && key =~ /\A[a-z][a-zA-Z0-9_]*\z/
    else
      raise ArgumentError.new( "[Enum] arguments to Enum.new must be all symbols following the ruby id naming rules; >#{key}< failed" )
    end
  end

  klass = Class.new( Enum )

  ## add self.new too - note: call/forward to "old" orginal self.new of Event (base) class
  klass.define_singleton_method( :new ) do |*new_args|
    old_new( *new_args )
  end

  e.each do |key,value|
    klass.class_eval( <<RUBY )
      #{key.upcase} = new( :#{key}, #{value} )

      def #{key}?
        self == #{key.upcase}
      end

      def self.#{key}
        #{key.upcase}
      end
RUBY
  end

  klass.class_eval( <<RUBY )
    def self.members
      @members ||= [#{e.keys.map {|key|key.upcase}.join(',')}].freeze
    end
RUBY

  ## note: use Kernel for "namespacing"
  ##   make all enums Kernel convenience converters (always) global
  ##     including uppercase methods (e.g. State(), Color(), etc.) does NOT work otherwise (with other module includes)

  ## add global convenience converter function
  ##  e.g. State(0) is same as State.convert(0)
  ##       Color(0) is same as Color.convert(0)
  Kernel.class_eval( <<RUBY )
    def #{class_name}( arg )
       #{class_name}.convert( arg )
    end
RUBY

  ## note: use Safe (module) and NO Object for namespacing
  ##   use include Safe to make all enums constants and machinery global
  Safe.const_set( class_name, klass )   ## returns klass (plus sets global constant class name)
end


class << self
  alias_method :old_new, :new           # note: store "old" orginal version of new
  alias_method :new,     :build_class   #   replace original version with build_class
end

end  # class Enum
end  # module Safe
