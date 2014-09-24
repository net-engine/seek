![Seek](http://www.seek.com.au/content/images/logos/logo-seek-main@2x.gif)

Client library to integrate your Ruby application with [Seek](http://seek.com.au/).

This gem works with both Rails and non-Rails apps.

[Official documentation](http://developer.seek.com.au/)

# Installation

Add this line to your application's Gemfile:

```ruby
gem 'seek', github: 'net-engine/seek'
```

And then execute:

    $ bundle

# Usage

**Important**:

* Any call to *live* environment will overide current jobs in there.
* And any call to *test* environment will not be saved in Seek database.

## Enumerations

For some resources, Seek provides lists with valid values. You can use enumerations to list these valid values in your form and also to validate the data before snding it.

```ruby
Seek::Enumerations.work_types      # => [...]
Seek::Enumerations.items           # => [...]
Seek::Enumerations.classifications # => [#<OpenStruct ... sub_classifications = [...]]
Seek::Enumerations.nations         # => [#<OpenStruct ... nations = [#<OpenStruct ... states = [#<OpenStruct ... locations = [#<OpenStruct ... areas = [...]]]]]
Seek::Enumerations.salary_types    # => [...]
```

## How to create a job object

You will need to create Job objects in order to send it through Fastland Plus API.

```ruby
job = Seek::Job.new(
  reference:                  'ABC1234',
  title:                      'Graduate Architect',
  search_title:               'Graduate Architect',
  description:                'Graduate Architect',
  ad_details:                 '<br><b>This line is bold</b>', # This attribute accepts HTML code
  listing_location:           'Brisbane',
  listing_work_type:          'FullTime',
  listing_classification:     'DesignArchitecture',
  listing_sub_classification: 'Architecture',
  salary_type:                'AnnualPackage',
  salary_min:                 50000,
  salary_max:                 69999,
  is_stand_out:               false
)
```

Another possible attributes (but not required) are:

* `template_id`
* `screen_id`
* `application_email`
* `application_url`
* `residents_only`
* `item_job_title`
* `listing_area`
* `salary_additional_text`
* `stand_out_logo_id`
* `stand_out_bullet_1`
* `stand_out_bullet_2`
* `stand_out_bullet_3`

In order to check if the Job object is valid, just use `job.valid?`.

## Fastlane Plus API

You can send jobs to Seek though Fastlane Plus API.

First, create a `fastlane_plus_integration` object:

```ruby
fastlane_plus_integration = Seek::Integrations::FastlanePlus.new(
  username:          'your_username',
  password:          'your_password',
  role:              'Uploader', # Other possible values are 'Client' and 'Agent'
  uploader_id:       1234,
  client_id:         5678, # This is your SEEK ID
  test_environment:  false # If you are using Rails, you can use `!Rails.env.production?`
)
```

Then, create the jobs:

```ruby
job_1 = Seek::Job.new({ ... })
job_2 = Seek::Job.new({ ... })
```

And finally send them:

```ruby
fastlane_plus_integration.send_jobs([job_1, job_2])
```

[Fastlane Plus API documention](http://developer.seek.com.au/docs/partner-api/methods/fastlaneplus-api)

## Application Export API

Not supported yet.

[Application Export API documention](http://developer.seek.com.au/docs/partner-api/methods/application-export-api)

# Contributing

1. Fork it (https://github.com/net-engine/seek/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

---

Copyright (c) 2014 NetEngine
