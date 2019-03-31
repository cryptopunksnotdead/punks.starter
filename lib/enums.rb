# encoding: utf-8

## stdlibs
require 'pp'


## our own code
require 'enums/version'    # note: let version always go first


## forward declarations
module Safe

  ## todo/check/discuss: auto-include SafeHelper - why? why not?

  ## note: use ClassMethods pattern for auto-including class methods
  ##   note ClassMethods module is called SafeHelper
  def self.included( klass )
    klass.extend( SafeHelper )
  end

  module SafeHelper; end
  ## note: also extends (include a helper methods to Safe itself)
  ##  lets you use:
  ##  module Safe
  ##    enum :Color, :red, :green, :blue
  ##  end
  extend SafeHelper
end # module Safe


module Kernel
  def Bit( n ) 1 << n; end     ## add "global" bit conversion helper
end



require 'enums/enum'
require 'enums/enum_builder'
require 'enums/flag'
require 'enums/flag_builder'




module Safe

  ## note make Flags an alias of Flag
  Flags = Flag


module SafeHelper
  def enum( class_name, *args, flags: false, options: {}, **kwargs )

    ## note: allow "standalone" option flags or
    ## option hash
    defaults = { flags: flags }
    options = defaults.merge( options )
    pp options

    ########################################
    # note: lets you use:
    #   enum :Color, :red, :green, :blue
    #    -or-
    #   enum :Color, [:red, :green, :blue]
    if args.size > 0 && args[0].is_a?( Array )
      args = args[0]
    end

    if options[:flags]
      Flag.new( class_name, *args, **kwargs )
    else
      Enum.new( class_name, *args, **kwargs )
    end
  end
end # module SafeHelper
end # module Safe


puts Enums.banner   # say hello
