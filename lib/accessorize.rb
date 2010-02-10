require 'accessorize/accessor'
require 'accessorize/base'
require 'accessorize/config'
require 'accessorize/extension'

module Accessorize
  def self.configure
    yield Accessorize::Config
  end
end