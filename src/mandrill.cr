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

    def templates
      Templates.new self
    end

    def exports
      Exports.new self
    end

    def users
      Users.new self
    end

    def rejects
      Rejects.new self
    end

    def inbound
      Inbound.new self
    end

    def tags
      Tags.new self
    end

    def messages
      Messages.new self
    end

    def whitelists
      Whitelists.new self
    end

    def ips
      Ips.new self
    end

    def internal
      Internal.new self
    end

    def subaccounts
      Subaccounts.new self
    end

    def urls
      Urls.new self
    end

    def webhooks
      Webhooks.new self
    end

    def senders
      Senders.new self
    end

    def metadata
      Metadata.new self
    end
  end
end
