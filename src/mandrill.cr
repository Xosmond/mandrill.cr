require "crest"
require "json"

require "./mandrill/api"

module Mandrill
  class API
    @host : String
    @path : String
    @session : Crest::Resource
    @debug : Bool
    @apikey : String

    def initialize(apikey = nil, debug = false)
      @host = "https://mandrillapp.com"
      @path = "/api/1.0/"

      @session = Crest::Resource.new(
        @host,
        headers: {"Content-Type" => "application/json"}
      )
      @debug = debug

      unless apikey
        if ENV["MANDRILL_APIKEY"]
          apikey = ENV["MANDRILL_APIKEY"]
        end
      end

      raise "You must provide a Mandrill API key" unless apikey
      @apikey = apikey
    end

    def key
      @apikey
    end

    def call(url, params)
      r = @session["#{@path}#{url}.json"].post(form: params)
      return JSON.parse(r.body)
    end

    def users
      Users.new self
    end

    def messages
      Messages.new self
    end
  end
end
