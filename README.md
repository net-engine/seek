![Seek](http://www.seek.com.au/content/images/logos/logo-seek-main@2x.gif)

Client library to integrate your app with [Seek](http://seek.com.au/).

This gem works with both Rails and non-Rails apps.

## Seek Documentation

[developer.seek.com.au](http://developer.seek.com.au/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'seek', github: 'net-engine/seek'
```

And then execute:

    $ bundle

## Usage

### Important notes

* Any call to *live* environment will overide current jobs in there.
* Any call to *test* environment will not be saved in Seek database.

### Enumerations

Seek will only accept some attributes if they are valid.
You can use enumerations to list valid values for the following resources in your form and also to validate the data before you send it.

```ruby
Seek::Enumerations.work_types      # => [...]
Seek::Enumerations.items           # => [...]
Seek::Enumerations.classifications # => [#<OpenStruct ... sub_classifications = [...]]
Seek::Enumerations.nations         # => [#<OpenStruct ... nations = [#<OpenStruct ... states = [#<OpenStruct ... locations = [#<OpenStruct ... areas = [...]]]]]
```

### How to create a job object

You will need to use Job objects in order to send it through Fastland Plus API.

```ruby
job = Seek::Job.new(
  reference:                  'ABC1234',
  title:                      'Graduate Architect',
  search_title:               'Graduate Architect',
  description:                'Graduate Architect',
  ad_details:                 '<br\>\<b\>This line is bold\</b\>', # This attribute accepts HTML
  listing_market_segments:    'Main Campus',
  listing_location:           'Brisbane',
  listing_work_type:          'FullTime',
  listing_classification:     'DesignArchitecture',
  listing_sub_classification: 'Architecture',
  salary_type:                'AnnualPackage',
  salary_min:                 '50000',
  salary_max:                 '69999',
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
* `item_bullet1`
* `item_bullet2`
* `item_bullet3`
* `item_contact_name`
* `item_phone_number`
* `item_fax_number`
* `item_reference_number`
* `listing_area`
* `salary_additional_text`
* `stand_out_logo_id`
* `stand_out_bullet_1`
* `stand_out_bullet_2`
* `stand_out_bullet_3`

In order to check if the Job object is valid, just use `job.valid?`.

### Fastlane Plus API

You can send jobs to Seek though Fastlane Plus API.

First, create a `fastlane_plus_integration` object:

```ruby
fastlane_plus_integration = Seek::Integrations::FastlanePlus.new(
  username:          'your_username',
  password:          'your_password',
  role:              'Uploader', # Other possible values: 'Client', 'Agent'
  uploader_id:       1234,
  client_id:         1234, # This is your SEEK ID
  test_environment:  false # You can also use: !%w(staging production).include?(Rails.env)
)
```

Then, send the jobs:

```ruby
job_1 = Seek::Job.new({ ... })
job_2 = Seek::Job.new({ ... })

fastlane_plus_integration.send_jobs([job_1, job_2])
```

[Documention](http://developer.seek.com.au/docs/partner-api/methods/fastlaneplus-api)

### Application Export API

Not supported yet.

[Documention](http://developer.seek.com.au/docs/partner-api/methods/application-export-api)

## Contributing

1. Fork it (https://github.com/net-engine/seek/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
