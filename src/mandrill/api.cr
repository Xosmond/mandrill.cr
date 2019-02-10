module Mandrill
  class Users
    @master : API

    def initialize(master)
      @master = master
    end

    # Return the information about the API-connected user
    # @return [Hash] the user information including username, key, reputation, quota, and historical sending stats
    #     - [String] username the username of the user (used for SMTP authentication)
    #     - [String] created_at the date and time that the user's Mandrill account was created as a UTC string in YYYY-MM-DD HH:MM:SS format
    #     - [String] public_id a unique, permanent identifier for this user
    #     - [Integer] reputation the reputation of the user on a scale from 0 to 100, with 75 generally being a "good" reputation
    #     - [Integer] hourly_quota the maximum number of emails Mandrill will deliver for this user each hour.  Any emails beyond that will be accepted and queued for later delivery.  Users with higher reputations will have higher hourly quotas
    #     - [Integer] backlog the number of emails that are queued for delivery due to exceeding your monthly or hourly quotas
    #     - [Hash] stats an aggregate summary of the account's sending stats
    #         - [Hash] today stats for this user so far today
    #             - [Integer] sent the number of emails sent for this user so far today
    #             - [Integer] hard_bounces the number of emails hard bounced for this user so far today
    #             - [Integer] soft_bounces the number of emails soft bounced for this user so far today
    #             - [Integer] rejects the number of emails rejected for sending this user so far today
    #             - [Integer] complaints the number of spam complaints for this user so far today
    #             - [Integer] unsubs the number of unsubscribes for this user so far today
    #             - [Integer] opens the number of times emails have been opened for this user so far today
    #             - [Integer] unique_opens the number of unique opens for emails sent for this user so far today
    #             - [Integer] clicks the number of URLs that have been clicked for this user so far today
    #             - [Integer] unique_clicks the number of unique clicks for emails sent for this user so far today
    #         - [Hash] last_7_days stats for this user in the last 7 days
    #             - [Integer] sent the number of emails sent for this user in the last 7 days
    #             - [Integer] hard_bounces the number of emails hard bounced for this user in the last 7 days
    #             - [Integer] soft_bounces the number of emails soft bounced for this user in the last 7 days
    #             - [Integer] rejects the number of emails rejected for sending this user in the last 7 days
    #             - [Integer] complaints the number of spam complaints for this user in the last 7 days
    #             - [Integer] unsubs the number of unsubscribes for this user in the last 7 days
    #             - [Integer] opens the number of times emails have been opened for this user in the last 7 days
    #             - [Integer] unique_opens the number of unique opens for emails sent for this user in the last 7 days
    #             - [Integer] clicks the number of URLs that have been clicked for this user in the last 7 days
    #             - [Integer] unique_clicks the number of unique clicks for emails sent for this user in the last 7 days
    #         - [Hash] last_30_days stats for this user in the last 30 days
    #             - [Integer] sent the number of emails sent for this user in the last 30 days
    #             - [Integer] hard_bounces the number of emails hard bounced for this user in the last 30 days
    #             - [Integer] soft_bounces the number of emails soft bounced for this user in the last 30 days
    #             - [Integer] rejects the number of emails rejected for sending this user in the last 30 days
    #             - [Integer] complaints the number of spam complaints for this user in the last 30 days
    #             - [Integer] unsubs the number of unsubscribes for this user in the last 30 days
    #             - [Integer] opens the number of times emails have been opened for this user in the last 30 days
    #             - [Integer] unique_opens the number of unique opens for emails sent for this user in the last 30 days
    #             - [Integer] clicks the number of URLs that have been clicked for this user in the last 30 days
    #             - [Integer] unique_clicks the number of unique clicks for emails sent for this user in the last 30 days
    #         - [Hash] last_60_days stats for this user in the last 60 days
    #             - [Integer] sent the number of emails sent for this user in the last 60 days
    #             - [Integer] hard_bounces the number of emails hard bounced for this user in the last 60 days
    #             - [Integer] soft_bounces the number of emails soft bounced for this user in the last 60 days
    #             - [Integer] rejects the number of emails rejected for sending this user in the last 60 days
    #             - [Integer] complaints the number of spam complaints for this user in the last 60 days
    #             - [Integer] unsubs the number of unsubscribes for this user in the last 60 days
    #             - [Integer] opens the number of times emails have been opened for this user in the last 60 days
    #             - [Integer] unique_opens the number of unique opens for emails sent for this user in the last 60 days
    #             - [Integer] clicks the number of URLs that have been clicked for this user in the last 60 days
    #             - [Integer] unique_clicks the number of unique clicks for emails sent for this user in the last 60 days
    #         - [Hash] last_90_days stats for this user in the last 90 days
    #             - [Integer] sent the number of emails sent for this user in the last 90 days
    #             - [Integer] hard_bounces the number of emails hard bounced for this user in the last 90 days
    #             - [Integer] soft_bounces the number of emails soft bounced for this user in the last 90 days
    #             - [Integer] rejects the number of emails rejected for sending this user in the last 90 days
    #             - [Integer] complaints the number of spam complaints for this user in the last 90 days
    #             - [Integer] unsubs the number of unsubscribes for this user in the last 90 days
    #             - [Integer] opens the number of times emails have been opened for this user in the last 90 days
    #             - [Integer] unique_opens the number of unique opens for emails sent for this user in the last 90 days
    #             - [Integer] clicks the number of URLs that have been clicked for this user in the last 90 days
    #             - [Integer] unique_clicks the number of unique clicks for emails sent for this user in the last 90 days
    #         - [Hash] all_time stats for the lifetime of the user's account
    #             - [Integer] sent the number of emails sent in the lifetime of the user's account
    #             - [Integer] hard_bounces the number of emails hard bounced in the lifetime of the user's account
    #             - [Integer] soft_bounces the number of emails soft bounced in the lifetime of the user's account
    #             - [Integer] rejects the number of emails rejected for sending this user so far today
    #             - [Integer] complaints the number of spam complaints in the lifetime of the user's account
    #             - [Integer] unsubs the number of unsubscribes in the lifetime of the user's account
    #             - [Integer] opens the number of times emails have been opened in the lifetime of the user's account
    #             - [Integer] unique_opens the number of unique opens for emails sent in the lifetime of the user's account
    #             - [Integer] clicks the number of URLs that have been clicked in the lifetime of the user's account
    #             - [Integer] unique_clicks the number of unique clicks for emails sent in the lifetime of the user's account
    def info
      _params = {} of Symbol => String
      return @master.call "users/info", _params
    end

    # Validate an API key and respond to a ping (anal JSON parser version)
    # @return [Hash] a struct with one key "PING" with a static value "PONG!"
    def ping
      _params = {} of Symbol => String
      return @master.call "users/ping2", _params
    end

    # Return the senders that have tried to use this account, both verified and unverified
    # @return [Array] an array of sender data, one for each sending addresses used by the account
    #     - [Hash] return[] the information on each sending address in the account
    #         - [String] address the sender's email address
    #         - [String] created_at the date and time that the sender was first seen by Mandrill as a UTC date string in YYYY-MM-DD HH:MM:SS format
    #         - [Integer] sent the total number of messages sent by this sender
    #         - [Integer] hard_bounces the total number of hard bounces by messages by this sender
    #         - [Integer] soft_bounces the total number of soft bounces by messages by this sender
    #         - [Integer] rejects the total number of rejected messages by this sender
    #         - [Integer] complaints the total number of spam complaints received for messages by this sender
    #         - [Integer] unsubs the total number of unsubscribe requests received for messages by this sender
    #         - [Integer] opens the total number of times messages by this sender have been opened
    #         - [Integer] clicks the total number of times tracked URLs in messages by this sender have been clicked
    #         - [Integer] unique_opens the number of unique opens for emails sent for this sender
    #         - [Integer] unique_clicks the number of unique clicks for emails sent for this sender
    def senders
      _params = {} of Symbol => String
      return @master.call "users/senders", _params
    end
  end

  class Messages
    @master : API

    def initialize(master)
      @master = master
    end

    # Send a new transactional message through Mandrill
    # @param [Hash] message the information on the message to send
    #     - [String] html the full HTML content to be sent
    #     - [String] text optional full text content to be sent
    #     - [String] subject the message subject
    #     - [String] from_email the sender email address.
    #     - [String] from_name optional from name to be used
    #     - [Array] to an array of recipient information.
    #         - [Hash] to[] a single recipient's information.
    #             - [String] email the email address of the recipient
    #             - [String] name the optional display name to use for the recipient
    #             - [String] type the header type to use for the recipient, defaults to "to" if not provided
    #     - [Hash] headers optional extra headers to add to the message (most headers are allowed)
    #     - [Boolean] important whether or not this message is important, and should be delivered ahead of non-important messages
    #     - [Boolean] track_opens whether or not to turn on open tracking for the message
    #     - [Boolean] track_clicks whether or not to turn on click tracking for the message
    #     - [Boolean] auto_text whether or not to automatically generate a text part for messages that are not given text
    #     - [Boolean] auto_html whether or not to automatically generate an HTML part for messages that are not given HTML
    #     - [Boolean] inline_css whether or not to automatically inline all CSS styles provided in the message HTML - only for HTML documents less than 256KB in size
    #     - [Boolean] url_strip_qs whether or not to strip the query string from URLs when aggregating tracked URL data
    #     - [Boolean] preserve_recipients whether or not to expose all recipients in to "To" header for each email
    #     - [Boolean] view_content_link set to false to remove content logging for sensitive emails
    #     - [String] bcc_address an optional address to receive an exact copy of each recipient's email
    #     - [String] tracking_domain a custom domain to use for tracking opens and clicks instead of mandrillapp.com
    #     - [String] signing_domain a custom domain to use for SPF/DKIM signing instead of mandrill (for "via" or "on behalf of" in email clients)
    #     - [String] return_path_domain a custom domain to use for the messages's return-path
    #     - [Boolean] merge whether to evaluate merge tags in the message. Will automatically be set to true if either merge_vars or global_merge_vars are provided.
    #     - [String] merge_language the merge tag language to use when evaluating merge tags, either mailchimp or handlebars
    #     - [Array] global_merge_vars global merge variables to use for all recipients. You can override these per recipient.
    #         - [Hash] global_merge_vars[] a single global merge variable
    #             - [String] name the global merge variable's name. Merge variable names are case-insensitive and may not start with _
    #             - [Mixed] content the global merge variable's content
    #     - [Array] merge_vars per-recipient merge variables, which override global merge variables with the same name.
    #         - [Hash] merge_vars[] per-recipient merge variables
    #             - [String] rcpt the email address of the recipient that the merge variables should apply to
    #             - [Array] vars the recipient's merge variables
    #                 - [Hash] vars[] a single merge variable
    #                     - [String] name the merge variable's name. Merge variable names are case-insensitive and may not start with _
    #                     - [Mixed] content the merge variable's content
    #     - [Array] tags an array of string to tag the message with.  Stats are accumulated using tags, though we only store the first 100 we see, so this should not be unique or change frequently.  Tags should be 50 characters or less.  Any tags starting with an underscore are reserved for internal use and will cause errors.
    #         - [String] tags[] a single tag - must not start with an underscore
    #     - [String] subaccount the unique id of a subaccount for this message - must already exist or will fail with an error
    #     - [Array] google_analytics_domains an array of strings indicating for which any matching URLs will automatically have Google Analytics parameters appended to their query string automatically.
    #     - [Array, String] google_analytics_campaign optional string indicating the value to set for the utm_campaign tracking parameter. If this isn't provided the email's from address will be used instead.
    #     - [Array] metadata metadata an associative array of user metadata. Mandrill will store this metadata and make it available for retrieval. In addition, you can select up to 10 metadata fields to index and make searchable using the Mandrill search api.
    #     - [Array] recipient_metadata Per-recipient metadata that will override the global values specified in the metadata parameter.
    #         - [Hash] recipient_metadata[] metadata for a single recipient
    #             - [String] rcpt the email address of the recipient that the metadata is associated with
    #             - [Array] values an associated array containing the recipient's unique metadata. If a key exists in both the per-recipient metadata and the global metadata, the per-recipient metadata will be used.
    #     - [Array] attachments an array of supported attachments to add to the message
    #         - [Hash] attachments[] a single supported attachment
    #             - [String] type the MIME type of the attachment
    #             - [String] name the file name of the attachment
    #             - [String] content the content of the attachment as a base64-encoded string
    #     - [Array] images an array of embedded images to add to the message
    #         - [Hash] images[] a single embedded image
    #             - [String] type the MIME type of the image - must start with "image/"
    #             - [String] name the Content ID of the image - use <img src="cid:THIS_VALUE"> to reference the image in your HTML content
    #             - [String] content the content of the image as a base64-encoded string
    # @param [Boolean] async enable a background sending mode that is optimized for bulk sending. In async mode, messages/send will immediately return a status of "queued" for every recipient. To handle rejections when sending in async mode, set up a webhook for the 'reject' event. Defaults to false for messages with no more than 10 recipients; messages with more than 10 recipients are always sent asynchronously, regardless of the value of async.
    # @param [String] ip_pool the name of the dedicated ip pool that should be used to send the message. If you do not have any dedicated IPs, this parameter has no effect. If you specify a pool that does not exist, your default pool will be used instead.
    # @param [String] send_at when this message should be sent as a UTC timestamp in YYYY-MM-DD HH:MM:SS format. If you specify a time in the past, the message will be sent immediately. An additional fee applies for scheduled email, and this feature is only available to accounts with a positive balance.
    # @return [Array] of structs for each recipient containing the key "email" with the email address, and details of the message status for that recipient
    #     - [Hash] return[] the sending results for a single recipient
    #         - [String] email the email address of the recipient
    #         - [String] status the sending status of the recipient - either "sent", "queued", "scheduled", "rejected", or "invalid"
    #         - [String] reject_reason the reason for the rejection if the recipient status is "rejected" - one of "hard-bounce", "soft-bounce", "spam", "unsub", "custom", "invalid-sender", "invalid", "test-mode-limit", or "rule"
    #         - [String] _id the message's unique id
    def send(message, async = false, ip_pool = nil, send_at = nil)
      _params = {:key => @master.key, :message => message, :async => async, :ip_pool => ip_pool, :send_at => send_at}
      return @master.call "messages/send", _params.to_json
    end

    # Send a new transactional message through Mandrill using a template
    # @param [String] template_name the immutable name or slug of a template that exists in the user's account. For backwards-compatibility, the template name may also be used but the immutable slug is preferred.
    # @param [Array] template_content an array of template content to send.  Each item in the array should be a struct with two keys - name: the name of the content block to set the content for, and content: the actual content to put into the block
    #     - [Hash] template_content[] the injection of a single piece of content into a single editable region
    #         - [String] name the name of the mc:edit editable region to inject into
    #         - [String] content the content to inject
    # @param [Hash] message the other information on the message to send - same as /messages/send, but without the html content
    #     - [String] html optional full HTML content to be sent if not in template
    #     - [String] text optional full text content to be sent
    #     - [String] subject the message subject
    #     - [String] from_email the sender email address.
    #     - [String] from_name optional from name to be used
    #     - [Array] to an array of recipient information.
    #         - [Hash] to[] a single recipient's information.
    #             - [String] email the email address of the recipient
    #             - [String] name the optional display name to use for the recipient
    #             - [String] type the header type to use for the recipient, defaults to "to" if not provided
    #     - [Hash] headers optional extra headers to add to the message (most headers are allowed)
    #     - [Boolean] important whether or not this message is important, and should be delivered ahead of non-important messages
    #     - [Boolean] track_opens whether or not to turn on open tracking for the message
    #     - [Boolean] track_clicks whether or not to turn on click tracking for the message
    #     - [Boolean] auto_text whether or not to automatically generate a text part for messages that are not given text
    #     - [Boolean] auto_html whether or not to automatically generate an HTML part for messages that are not given HTML
    #     - [Boolean] inline_css whether or not to automatically inline all CSS styles provided in the message HTML - only for HTML documents less than 256KB in size
    #     - [Boolean] url_strip_qs whether or not to strip the query string from URLs when aggregating tracked URL data
    #     - [Boolean] preserve_recipients whether or not to expose all recipients in to "To" header for each email
    #     - [Boolean] view_content_link set to false to remove content logging for sensitive emails
    #     - [String] bcc_address an optional address to receive an exact copy of each recipient's email
    #     - [String] tracking_domain a custom domain to use for tracking opens and clicks instead of mandrillapp.com
    #     - [String] signing_domain a custom domain to use for SPF/DKIM signing instead of mandrill (for "via" or "on behalf of" in email clients)
    #     - [String] return_path_domain a custom domain to use for the messages's return-path
    #     - [Boolean] merge whether to evaluate merge tags in the message. Will automatically be set to true if either merge_vars or global_merge_vars are provided.
    #     - [String] merge_language the merge tag language to use when evaluating merge tags, either mailchimp or handlebars
    #     - [Array] global_merge_vars global merge variables to use for all recipients. You can override these per recipient.
    #         - [Hash] global_merge_vars[] a single global merge variable
    #             - [String] name the global merge variable's name. Merge variable names are case-insensitive and may not start with _
    #             - [Mixed] content the global merge variable's content
    #     - [Array] merge_vars per-recipient merge variables, which override global merge variables with the same name.
    #         - [Hash] merge_vars[] per-recipient merge variables
    #             - [String] rcpt the email address of the recipient that the merge variables should apply to
    #             - [Array] vars the recipient's merge variables
    #                 - [Hash] vars[] a single merge variable
    #                     - [String] name the merge variable's name. Merge variable names are case-insensitive and may not start with _
    #                     - [Mixed] content the merge variable's content
    #     - [Array] tags an array of string to tag the message with.  Stats are accumulated using tags, though we only store the first 100 we see, so this should not be unique or change frequently.  Tags should be 50 characters or less.  Any tags starting with an underscore are reserved for internal use and will cause errors.
    #         - [String] tags[] a single tag - must not start with an underscore
    #     - [String] subaccount the unique id of a subaccount for this message - must already exist or will fail with an error
    #     - [Array] google_analytics_domains an array of strings indicating for which any matching URLs will automatically have Google Analytics parameters appended to their query string automatically.
    #     - [Array, String] google_analytics_campaign optional string indicating the value to set for the utm_campaign tracking parameter. If this isn't provided the email's from address will be used instead.
    #     - [Array] metadata metadata an associative array of user metadata. Mandrill will store this metadata and make it available for retrieval. In addition, you can select up to 10 metadata fields to index and make searchable using the Mandrill search api.
    #     - [Array] recipient_metadata Per-recipient metadata that will override the global values specified in the metadata parameter.
    #         - [Hash] recipient_metadata[] metadata for a single recipient
    #             - [String] rcpt the email address of the recipient that the metadata is associated with
    #             - [Array] values an associated array containing the recipient's unique metadata. If a key exists in both the per-recipient metadata and the global metadata, the per-recipient metadata will be used.
    #     - [Array] attachments an array of supported attachments to add to the message
    #         - [Hash] attachments[] a single supported attachment
    #             - [String] type the MIME type of the attachment
    #             - [String] name the file name of the attachment
    #             - [String] content the content of the attachment as a base64-encoded string
    #     - [Array] images an array of embedded images to add to the message
    #         - [Hash] images[] a single embedded image
    #             - [String] type the MIME type of the image - must start with "image/"
    #             - [String] name the Content ID of the image - use <img src="cid:THIS_VALUE"> to reference the image in your HTML content
    #             - [String] content the content of the image as a base64-encoded string
    # @param [Boolean] async enable a background sending mode that is optimized for bulk sending. In async mode, messages/send will immediately return a status of "queued" for every recipient. To handle rejections when sending in async mode, set up a webhook for the 'reject' event. Defaults to false for messages with no more than 10 recipients; messages with more than 10 recipients are always sent asynchronously, regardless of the value of async.
    # @param [String] ip_pool the name of the dedicated ip pool that should be used to send the message. If you do not have any dedicated IPs, this parameter has no effect. If you specify a pool that does not exist, your default pool will be used instead.
    # @param [String] send_at when this message should be sent as a UTC timestamp in YYYY-MM-DD HH:MM:SS format. If you specify a time in the past, the message will be sent immediately. An additional fee applies for scheduled email, and this feature is only available to accounts with a positive balance.
    # @return [Array] of structs for each recipient containing the key "email" with the email address, and details of the message status for that recipient
    #     - [Hash] return[] the sending results for a single recipient
    #         - [String] email the email address of the recipient
    #         - [String] status the sending status of the recipient - either "sent", "queued", "rejected", or "invalid"
    #         - [String] reject_reason the reason for the rejection if the recipient status is "rejected" - one of "hard-bounce", "soft-bounce", "spam", "unsub", "custom", "invalid-sender", "invalid", "test-mode-limit", or "rule"
    #         - [String] _id the message's unique id
    def send_template(template_name, template_content, message, async = false, ip_pool = nil, send_at = nil)
      _params = {:template_name => template_name, :template_content => template_content, :message => message, :async => async, :ip_pool => ip_pool, :send_at => send_at}
      return @master.call "messages/send-template", _params
    end

    # Search recently sent messages and optionally narrow by date range, tags, senders, and API keys. If no date range is specified, results within the last 7 days are returned. This method may be called up to 20 times per minute. If you need the data more often, you can use <a href="/api/docs/messages.html#method=info">/messages/info.json</a> to get the information for a single message, or <a href="http://help.mandrill.com/entries/21738186-Introduction-to-Webhooks">webhooks</a> to push activity to your own application for querying.
    # @param [String] query <a href="http://help.mandrill.com/entries/22211902">search terms</a> to find matching messages
    # @param [String] date_from start date
    # @param [String] date_to end date
    # @param [Array] tags an array of tag names to narrow the search to, will return messages that contain ANY of the tags
    # @param [Array] senders an array of sender addresses to narrow the search to, will return messages sent by ANY of the senders
    # @param [Array] api_keys an array of API keys to narrow the search to, will return messages sent by ANY of the keys
    # @param [Integer] limit the maximum number of results to return, defaults to 100, 1000 is the maximum
    # @return [Array] of structs for each matching message
    #     - [Hash] return[] the information for a single matching message
    #         - [Integer] ts the Unix timestamp from when this message was sent
    #         - [String] _id the message's unique id
    #         - [String] sender the email address of the sender
    #         - [String] template the unique name of the template used, if any
    #         - [String] subject the message's subject line
    #         - [String] email the recipient email address
    #         - [Array] tags list of tags on this message
    #             - [String] tags[] individual tag on this message
    #         - [Integer] opens how many times has this message been opened
    #         - [Array] opens_detail list of individual opens for the message
    #             - [Hash] opens_detail[] information on an individual open
    #                 - [Integer] ts the unix timestamp from when the message was opened
    #                 - [String] ip the IP address that generated the open
    #                 - [String] location the approximate region and country that the opening IP is located
    #                 - [String] ua the email client or browser data of the open
    #         - [Integer] clicks how many times has a link been clicked in this message
    #         - [Array] clicks_detail list of individual clicks for the message
    #             - [Hash] clicks_detail[] information on an individual click
    #                 - [Integer] ts the unix timestamp from when the message was clicked
    #                 - [String] url the URL that was clicked on
    #                 - [String] ip the IP address that generated the click
    #                 - [String] location the approximate region and country that the clicking IP is located
    #                 - [String] ua the email client or browser data of the click
    #         - [String] state sending status of this message: sent, bounced, rejected
    #         - [Hash] metadata any custom metadata provided when the message was sent
    #     - [Array] smtp_events a log of up to 3 smtp events for the message
    #         - [Hash] smtp_events[] information about a specific smtp event
    #             - [Integer] ts the Unix timestamp when the event occured
    #             - [String] type the message's state as a result of this event
    #             - [String] diag the SMTP response from the recipient's server
    def search(query = '*', date_from = nil, date_to = nil, tags = nil, senders = nil, api_keys = nil, limit = 100)
      _params = {:query => query, :date_from => date_from, :date_to => date_to, :tags => tags, :senders => senders, :api_keys => api_keys, :limit => limit}
      return @master.call "messages/search", _params
    end

    # Search the content of recently sent messages and return the aggregated hourly stats for matching messages
    # @param [String] query the search terms to find matching messages for
    # @param [String] date_from start date
    # @param [String] date_to end date
    # @param [Array] tags an array of tag names to narrow the search to, will return messages that contain ANY of the tags
    # @param [Array] senders an array of sender addresses to narrow the search to, will return messages sent by ANY of the senders
    # @return [Array] the array of history information
    #     - [Hash] return[] the stats for a single hour
    #         - [String] time the hour as a UTC date string in YYYY-MM-DD HH:MM:SS format
    #         - [Integer] sent the number of emails that were sent during the hour
    #         - [Integer] hard_bounces the number of emails that hard bounced during the hour
    #         - [Integer] soft_bounces the number of emails that soft bounced during the hour
    #         - [Integer] rejects the number of emails that were rejected during the hour
    #         - [Integer] complaints the number of spam complaints received during the hour
    #         - [Integer] unsubs the number of unsubscribes received during the hour
    #         - [Integer] opens the number of emails opened during the hour
    #         - [Integer] unique_opens the number of unique opens generated by messages sent during the hour
    #         - [Integer] clicks the number of tracked URLs clicked during the hour
    #         - [Integer] unique_clicks the number of unique clicks generated by messages sent during the hour
    def search_time_series(query = '*', date_from = nil, date_to = nil, tags = nil, senders = nil)
      _params = {:key => @master.key, :query => query, :date_from => date_from, :date_to => date_to, :tags => tags, :senders => senders}
      return @master.call "messages/search-time-series", _params
    end

    # Get the information for a single recently sent message
    # @param [String] id the unique id of the message to get - passed as the "_id" field in webhooks, send calls, or search calls
    # @return [Hash] the information for the message
    #     - [Integer] ts the Unix timestamp from when this message was sent
    #     - [String] _id the message's unique id
    #     - [String] sender the email address of the sender
    #     - [String] template the unique name of the template used, if any
    #     - [String] subject the message's subject line
    #     - [String] email the recipient email address
    #     - [Array] tags list of tags on this message
    #         - [String] tags[] individual tag on this message
    #     - [Integer] opens how many times has this message been opened
    #     - [Array] opens_detail list of individual opens for the message
    #         - [Hash] opens_detail[] information on an individual open
    #             - [Integer] ts the unix timestamp from when the message was opened
    #             - [String] ip the IP address that generated the open
    #             - [String] location the approximate region and country that the opening IP is located
    #             - [String] ua the email client or browser data of the open
    #     - [Integer] clicks how many times has a link been clicked in this message
    #     - [Array] clicks_detail list of individual clicks for the message
    #         - [Hash] clicks_detail[] information on an individual click
    #             - [Integer] ts the unix timestamp from when the message was clicked
    #             - [String] url the URL that was clicked on
    #             - [String] ip the IP address that generated the click
    #             - [String] location the approximate region and country that the clicking IP is located
    #             - [String] ua the email client or browser data of the click
    #     - [String] state sending status of this message: sent, bounced, rejected
    #     - [Hash] metadata any custom metadata provided when the message was sent
    #     - [Array] smtp_events a log of up to 3 smtp events for the message
    #         - [Hash] smtp_events[] information about a specific smtp event
    #             - [Integer] ts the Unix timestamp when the event occured
    #             - [String] type the message's state as a result of this event
    #             - [String] diag the SMTP response from the recipient's server
    def info(id)
      _params = {:key => @master.key, :id => id}
      return @master.call "messages/info", _params
    end

    # Get the full content of a recently sent message
    # @param [String] id the unique id of the message to get - passed as the "_id" field in webhooks, send calls, or search calls
    # @return [Hash] the content of the message
    #     - [Integer] ts the Unix timestamp from when this message was sent
    #     - [String] _id the message's unique id
    #     - [String] from_email the email address of the sender
    #     - [String] from_name the alias of the sender (if any)
    #     - [String] subject the message's subject line
    #     - [Hash] to the message recipient's information
    #         - [String] email the email address of the recipient
    #         - [String] name the alias of the recipient (if any)
    #     - [Array] tags list of tags on this message
    #         - [String] tags[] individual tag on this message
    #     - [Hash] headers the key-value pairs of the custom MIME headers for the message's main document
    #     - [String] text the text part of the message, if any
    #     - [String] html the HTML part of the message, if any
    #     - [Array] attachments an array of any attachments that can be found in the message
    #         - [Hash] attachments[] information about an individual attachment
    #             - [String] name the file name of the attachment
    #             - [String] type the MIME type of the attachment
    #             - [String] content the content of the attachment as a base64 encoded string
    def content(id)
      _params = {:key => @master.key, :id => id}
      return @master.call "messages/content", _params
    end

    # Parse the full MIME document for an email message, returning the content of the message broken into its constituent pieces
    # @param [String] raw_message the full MIME document of an email message
    # @return [Hash] the parsed message
    #     - [String] subject the subject of the message
    #     - [String] from_email the email address of the sender
    #     - [String] from_name the alias of the sender (if any)
    #     - [Array] to an array of any recipients in the message
    #         - [Hash] to[] the information on a single recipient
    #             - [String] email the email address of the recipient
    #             - [String] name the alias of the recipient (if any)
    #     - [Hash] headers the key-value pairs of the MIME headers for the message's main document
    #     - [String] text the text part of the message, if any
    #     - [String] html the HTML part of the message, if any
    #     - [Array] attachments an array of any attachments that can be found in the message
    #         - [Hash] attachments[] information about an individual attachment
    #             - [String] name the file name of the attachment
    #             - [String] type the MIME type of the attachment
    #             - [Boolean] binary if this is set to true, the attachment is not pure-text, and the content will be base64 encoded
    #             - [String] content the content of the attachment as a text string or a base64 encoded string based on the attachment type
    #     - [Array] images an array of any embedded images that can be found in the message
    #         - [Hash] images[] information about an individual image
    #             - [String] name the Content-ID of the embedded image
    #             - [String] type the MIME type of the image
    #             - [String] content the content of the image as a base64 encoded string
    def parse(raw_message)
      _params = {:key => @master.key, :raw_message => raw_message}
      return @master.call "messages/parse", _params
    end

    # Take a raw MIME document for a message, and send it exactly as if it were sent through Mandrill's SMTP servers
    # @param [String] raw_message the full MIME document of an email message
    # @param [String, nil] from_email optionally define the sender address - otherwise we'll use the address found in the provided headers
    # @param [String, nil] from_name optionally define the sender alias
    # @param [Array, nil] to optionally define the recipients to receive the message - otherwise we'll use the To, Cc, and Bcc headers provided in the document
    #     - [String] to[] the email address of the recipient
    # @param [Boolean] async enable a background sending mode that is optimized for bulk sending. In async mode, messages/sendRaw will immediately return a status of "queued" for every recipient. To handle rejections when sending in async mode, set up a webhook for the 'reject' event. Defaults to false for messages with no more than 10 recipients; messages with more than 10 recipients are always sent asynchronously, regardless of the value of async.
    # @param [String] ip_pool the name of the dedicated ip pool that should be used to send the message. If you do not have any dedicated IPs, this parameter has no effect. If you specify a pool that does not exist, your default pool will be used instead.
    # @param [String] send_at when this message should be sent as a UTC timestamp in YYYY-MM-DD HH:MM:SS format. If you specify a time in the past, the message will be sent immediately.
    # @param [String] return_path_domain a custom domain to use for the messages's return-path
    # @return [Array] of structs for each recipient containing the key "email" with the email address, and details of the message status for that recipient
    #     - [Hash] return[] the sending results for a single recipient
    #         - [String] email the email address of the recipient
    #         - [String] status the sending status of the recipient - either "sent", "queued", "scheduled", "rejected", or "invalid"
    #         - [String] reject_reason the reason for the rejection if the recipient status is "rejected" - one of "hard-bounce", "soft-bounce", "spam", "unsub", "custom", "invalid-sender", "invalid", "test-mode-limit", or "rule"
    #         - [String] _id the message's unique id
    def send_raw(raw_message, from_email = nil, from_name = nil, to = nil, async = false, ip_pool = nil, send_at = nil, return_path_domain = nil)
      _params = {:key => @master.key, :raw_message => raw_message, :from_email => from_email, :from_name => from_name, :to => to, :async => async, :ip_pool => ip_pool, :send_at => send_at, :return_path_domain => return_path_domain}
      return @master.call "messages/send-raw", _params
    end

    # Queries your scheduled emails.
    # @param [String] to an optional recipient address to restrict results to
    # @return [Array] a list of up to 1000 scheduled emails
    #     - [Hash] return[] a scheduled email
    #         - [String] _id the scheduled message id
    #         - [String] created_at the UTC timestamp when the message was created, in YYYY-MM-DD HH:MM:SS format
    #         - [String] send_at the UTC timestamp when the message will be sent, in YYYY-MM-DD HH:MM:SS format
    #         - [String] from_email the email's sender address
    #         - [String] to the email's recipient
    #         - [String] subject the email's subject
    def list_scheduled(to = nil)
      _params = {:key => @master.key, :to => to}
      return @master.call "messages/list-scheduled", _params
    end

    # Cancels a scheduled email.
    # @param [String] id a scheduled email id, as returned by any of the messages/send calls or messages/list-scheduled
    # @return [Hash] information about the scheduled email that was cancelled.
    #     - [String] _id the scheduled message id
    #     - [String] created_at the UTC timestamp when the message was created, in YYYY-MM-DD HH:MM:SS format
    #     - [String] send_at the UTC timestamp when the message will be sent, in YYYY-MM-DD HH:MM:SS format
    #     - [String] from_email the email's sender address
    #     - [String] to the email's recipient
    #     - [String] subject the email's subject
    def cancel_scheduled(id)
      _params = {:key => @master.key, :id => id}
      return @master.call "messages/cancel-scheduled", _params
    end

    # Reschedules a scheduled email.
    # @param [String] id a scheduled email id, as returned by any of the messages/send calls or messages/list-scheduled
    # @param [String] send_at the new UTC timestamp when the message should sent. Mandrill can't time travel, so if you specify a time in past the message will be sent immediately
    # @return [Hash] information about the scheduled email that was rescheduled.
    #     - [String] _id the scheduled message id
    #     - [String] created_at the UTC timestamp when the message was created, in YYYY-MM-DD HH:MM:SS format
    #     - [String] send_at the UTC timestamp when the message will be sent, in YYYY-MM-DD HH:MM:SS format
    #     - [String] from_email the email's sender address
    #     - [String] to the email's recipient
    #     - [String] subject the email's subject
    def reschedule(id, send_at)
      _params = {:key => @master.key, :id => id, :send_at => send_at}
      return @master.call "messages/reschedule", _params
    end
  end
end
