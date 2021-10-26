require_relative './version'
require 'faraday'

module Nilpart
  class Nilpart
    PRODUCTION_SERVER = "https://api.partoo.co/v2/"
    SANDBOX_SERVER = "https://sandbox.api.partoo.co/v2/"

    attr_accessor :my_api_key
    attr_accessor :mode # prod / sandbox

    #def self.connector
    #response = Faraday.get()
    #end

    def server_url
      self.mode == "production" ? PRODUCTION_SERVER : SANDBOX_SERVER
    end

    def api_keys
      params = ""
      response = Faraday.get(self.server_url, params, { 'x-APIKey' => self.my_api_key })
      if response.status != 200 # Faraday has not constante for status 200
        puts "ApiKeys : Status => #{response.status}"
      end
      return JSON.parse(response.body)
    end
  end
end
