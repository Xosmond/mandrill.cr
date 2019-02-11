# Mandrill

Just migrated almost all implementation from ruby mandrill gem.

## Requirements

Crystal 0.27.0

## Getting the Library

Install the Mandrill API client as a shard:

```crystal
dependencies:
  mandrill:
    github: xosmond/mandrill.cr
    branch: master
```


## Using the Library

Now that you have a copy of the library in your project, you're ready to start using it. All uses of the Mandrill API start by including the library module and instantiating the `Mandrill::API class`.

```crystal
require 'mandrill'
mandrill = Mandrill::API.new 'YOUR_API_KEY'
```

After that, you're ready to start making calls.

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

## Documentation
Documentation Available [here](https://xosmond.github.io/mandrill.cr/index.html)

## Contributors

- [xosmond](https://github.com/xosmond) Jordano Moscoso - creator, maintainer