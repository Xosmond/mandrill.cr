# Mandrill

## Requirements

Crystal 0.27.0

## Getting the Library

Install the Mandrill API client as a shard:

```crystal
dependencies:
  mandrill:
    github: xosmond/mandrill
    branch: master
```


## Using the Library

Now that you have a copy of the library in your project, you're ready to start using it. All uses of the Mandrill API start by including the library module and instantiating the `Mandrill::API class`.

```crystal
require 'mandrill'
mandrill = Mandrill::API.new 'YOUR_API_KEY'
```

After that, you're ready to start making calls.

Questions? Problems?

Have you run into difficulties or a method just doesn't seem to work right? Check out our API Support options and we'll be happy to assist you.

### API Call Categories:

* Users
* Messages
* Tags
* Rejects
* Whitelists
* Senders
* Urls
* Templates
* Webhooks
* Subaccounts
* Inbound
* Exports
* Ips
* Metadata

## Contributors

- [xosmond](https://github.com/xosmond) Jordano Moscoso - creator, maintainer