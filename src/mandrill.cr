require "crest"
require "json"

require "./mandrill/api"
require "./mandrill/errors"

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

      cast_error(r.body) if r.status_code != 200
      return JSON.parse(r.body)
    end

    def cast_error(body)
      error_map = {
        "ValidationError"            => ValidationError,
        "Invalid_Key"                => InvalidKeyError,
        "PaymentRequired"            => PaymentRequiredError,
        "Unknown_Subaccount"         => UnknownSubaccountError,
        "Unknown_Template"           => UnknownTemplateError,
        "ServiceUnavailable"         => ServiceUnavailableError,
        "Unknown_Message"            => UnknownMessageError,
        "Invalid_Tag_Name"           => InvalidTagNameError,
        "Invalid_Reject"             => InvalidRejectError,
        "Unknown_Sender"             => UnknownSenderError,
        "Unknown_Url"                => UnknownUrlError,
        "Unknown_TrackingDomain"     => UnknownTrackingDomainError,
        "Invalid_Template"           => InvalidTemplateError,
        "Unknown_Webhook"            => UnknownWebhookError,
        "Unknown_InboundDomain"      => UnknownInboundDomainError,
        "Unknown_InboundRoute"       => UnknownInboundRouteError,
        "Unknown_Export"             => UnknownExportError,
        "IP_ProvisionLimit"          => IPProvisionLimitError,
        "Unknown_Pool"               => UnknownPoolError,
        "NoSendingHistory"           => NoSendingHistoryError,
        "PoorReputation"             => PoorReputationError,
        "Unknown_IP"                 => UnknownIPError,
        "Invalid_EmptyDefaultPool"   => InvalidEmptyDefaultPoolError,
        "Invalid_DeleteDefaultPool"  => InvalidDeleteDefaultPoolError,
        "Invalid_DeleteNonEmptyPool" => InvalidDeleteNonEmptyPoolError,
        "Invalid_CustomDNS"          => InvalidCustomDNSError,
        "Invalid_CustomDNSPending"   => InvalidCustomDNSPendingError,
        "Metadata_FieldLimit"        => MetadataFieldLimitError,
        "Unknown_MetadataField"      => UnknownMetadataFieldError,
      }

      begin
        error_info = JSON.parse(body)
        if error_info["status"] != "error" || !error_info["name"]
          raise Error.new("We received an unexpected error: #{body}")
        end
        if error_map[error_info["name"]]
          raise error_map[error_info["name"]].new(error_info["message"].as_s?)
        else
          raise Error.new(error_info["message"].as_s?)
        end
      rescue JSON::ParseException
        raise Error.new("We received an unexpected error: #{body}")
      end
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
