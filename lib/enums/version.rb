# encoding: utf-8

## note: use a (new) module Enums  (with s!! at the end) for version info
##   why? avoids "pollution" Enum namespace with (library) version info etc.
module Enums

  MAJOR = 1
  MINOR = 1
  PATCH = 1
  VERSION = [MAJOR,MINOR,PATCH].join('.')

  def self.version
    VERSION
  end

  def self.banner
    "enums/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

  def self.root
    "#{File.expand_path( File.dirname(File.dirname(File.dirname(__FILE__))) )}"
  end

end # module Enums
