require 'ostruct'
require 'net/http'
require 'json'
require "wayward/version"
require "wayward/blueprint"

module Wayward

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= OpenStruct.new api_version: 'v1'
    yield(configuration)
  end

  def self.const_missing blueprint
    const_set blueprint, Class.new(Blueprint)
  end

end
