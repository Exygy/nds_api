# NdsApi

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/nds_api`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nds_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nds_api

## Usage

```ruby
nds = NdsApi::Client.new(
    user: 'username',
    password: '############'
)
```

##### CLIENT

https://developer.uatup.naccrraware.net/#42d4c898-5868-19a8-0704-18235fa44a5e

```ruby
nds.create_client(data)
```

```ruby
nds.update_client(data)

nds.clients
nds.client_by_email(email)      
nds.client_by_phone(phone)      
nds.client_by_first_name_and_last_name(first_name, last_name)      
nds.client_by_id(id)      
```

##### CHILDREN

```ruby

nds.create_child(data)
nds.update_child(data)

nds.children      
nds.child_by_uid(uid)      
nds.children_by_client_id(client_id)      
```

##### COMMUNITIES

```ruby
nds.communities()
```

##### PERSON

```ruby

nds.create_person(data)
nds.update_person(data)

nds.persons()
nds.person_by_id(id)      
```

#### POSITIONS

```ruby
nds.positions_by_work_email(email)      
```

##### PROVIDERS

```ruby
nds.update_provider(data)

nds.providers()      
nds.provider_by_uid(uid)      
nds.provider_by_id(id)      
nds.providers_by_center_name(center_name)      
nds.providers_by_email(email)      
nds.provider_schedule(uid)      
nds.provider_rates(uid)      
nds.provider_enrollments(uid)      
```

##### REFERRALS

```ruby
nds.create_referral(data)

nds.referrals()      
nds.referral_by_id(id)      
nds.referral_by_client_id(id)      
nds.referrals_before_date(date)      
nds.referrals_after_date(date)      
nds.referrals_in_date_range(start_date, end_date)      
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/nds_api.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
