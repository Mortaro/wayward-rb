require 'ostruct'
require 'net/http'
require 'json'
require "wayward/version"
require "wayward/blueprint"

class Wayward < OpenStruct

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

  def save
    begin
      puts post_endpoint
      req = Net::HTTP::Post.new(post_endpoint, initheader = {'Content-Type' =>'application/json'})
      req['email'] = Wayward.configuration.email
      req['secret'] = Wayward.configuration.secret
      req.set_form_data(to_h)
      http = Net::HTTP.new('www.wayward.com.br').start {|http| http.request(req) }
      response = JSON.parse(http.body.force_encoding('UTF-8'), symbolize_names: true)
    rescue Exception => ex
      response = {errors: [ex.message]}
    end
    self.errors = response[:errors]
    self.id = response[:id] if response[:id]
    !self.errors.any?
  end

  private

    def post_endpoint
      "/api/#{Wayward.configuration.api_version}/projects"
    end

end
