<p align="right">
  <a href="https://rubygems.org/gems/schoolgirl_uniform"><img align="right" src="https://user-images.githubusercontent.com/2478436/51829691-c55cc000-22f6-11e9-99a5-42f88a8f2a55.png" width="56" height="56" /></a>
</p>
<p align="center">
  <a href="#">
    <img align="center" width="75%" src="https://user-images.githubusercontent.com/2478436/210048098-9d09b442-f057-42e1-b77b-94277928e452.png"/> 
  </a>
</p>
<br>

# Schoolgirl Uniform

<p align="right">
  <a href="#schoolgirl-uniform">
    <img align="right" width="30%" src="https://user-images.githubusercontent.com/2478436/210023063-339c9be3-5ac3-4d9b-87a1-60d1d8462861.png"/> 
  </a>
</p>

:feet: Multistep form concept for Rails projects. Allows to create complex forms for a few models simultaneously. Supports selectable per step validations without data persistence into db.
> Currently uses session to store data before actual save. If your sessions are stored in cookies then it has a 4 KB limit.

<br>

### Installation

To start using it just add this line to your application's Gemfile:

```ruby
gem 'schoolgirl_uniform'
```
<br>

Then you need to generate scaffold for future multistep form:

```ruby
$ rails generate schoolgirl_uniform:install CatgirlsSurvey
```

> You can also use snake case, so `catgirls_survey` would be identical to `CatgirlsSurvey` and will generate the same output during scaffolding.

<br>

### Usage and Config

To achieve working multistep form you need to configure FVC:

- :womans_clothes: [**Form**](#womans_clothes-form)

- :dress: [**View**](#dress-view)

- :school_satchel: [**Controller**](#school_satchel-controller)
<hr>

<p align="center">
  <a href="#">
    <img align="center" width="75%" src="https://user-images.githubusercontent.com/2478436/210439098-6230592e-4e94-4236-88e6-70d162d5369a.png"/> 
  </a>
</p>

### :womans_clothes: Form
    e.g. CatgirlsSurveyForm - app/forms/catgirls_survey_form.rb

<br>

#### 1. Declare the steps and details if needed in your form:

  ```ruby
  steps %w[first second third]

  def self.steps_details
    {
      first: 'Credentials',
      second: 'Personal Details',
      third: 'Contact Information'
    }
  end
  ```
:blue_book: How to [customize steps titles and descriptions](https://github.com/vergilet/schoolgirl_uniform/wiki/1.-Decorate-steps)

<br>

#### 2. Define form fields:

  ```ruby
  attribute :username,         :string
  attribute :password,         :string

  attribute :date_of_birth,    :date
  attribute :gender,           :string
  attribute :favourite_color,  :string
  attribute :device_type,      :string

  attribute :email,            :string
  attribute :phone_number,     :string
  attribute :country,          :string
  attribute :city,             :string
  attribute :address_field_1,  :string
  attribute :address_field_2,  :string
  attribute :zip_code,         :string
  ```
:blue_book: Different types and [how to add custom types such as `Array` and `hash` explained.](https://github.com/vergilet/schoolgirl_uniform/wiki/4.-Array-and-Hash-and-other-custom-types)

<br>

#### 3. Use block validations with step condition to group needed checks:

  ```ruby
  with_options if: :first? do |step|
    step.validates :username, presence: true, length: 3..10
    step.validate :custom_username_validation
    ...
  end

  with_options if: :second? do |step|
    step.validates :date_of_birth, presence: true
    step.validate :custom_date_of_birth_validation
    ...
  end
  ```
<br>

#### 4. Inside `save!` method build your records, set them with form attributes and save.
  
  ```ruby

  attr_reader :identifier

  def save!
    user.save!(validate: false)
    personal_detail.save!(validate: false)
    contact_info.save!(validate: false)

    @identifier = user.id
  end
  ```
:blue_book: Check more [complex examples and how to read them on the controller](https://github.com/vergilet/schoolgirl_uniform/wiki/5.-Returning-Complex-Results). 

<br>

### :dress: View
 - Scaffolding will generate example structure of view files:
    - _show.html.erb_
    - _finish.html.erb_
    - __wizard.html.erb_
    - __form_errors.html.erb_
    
    and steps/:
    - __first.html.erb_
    - __second.html.erb_
    - __third.html.erb_

:exclamation: Please notice that **_show_** and **_finish_** are action views, others are partials. \
:art: Feel free to modify html and styles around the form.
<br>

#### :infinity: Steps

By default Scaffolding generates 3 steps, but you can modify, delete or add new steps. \
Just make sure that steps are **__partials_** and match corresponded names inside **_Form_** (e.g. CatgirlsSurveyForm): 

  ```ruby
  # app/views/catgirls_survey/steps/_first.html.erb
  
  <%= form.label :username %>
  <%= form.text_field :username %>
  <br>
  <%= form.label :password %>
  <%= form.text_field :password %>
  ```
<br>

### :school_satchel: Controller
    e.g. CatgirlsSurveyController - app/controllers/catgirls_survey_controller.rb

Fetch resource(s) from DB using `identifier`, which you set in `.save!`
```ruby
  def finish
    @record = User.find_by(id: params[:identifier])
  end
```
:blue_book: Check more [complex examples and how to read them on the controller](https://github.com/vergilet/schoolgirl_uniform/wiki/5.-Returning-Complex-Results). 

<br>

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vergilet/schoolgirl_uniform
    
Feel free to contribute:
1. Fork it (https://github.com/vergilet/schoolgirl_uniform/fork)
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request



## License
The gem is available as open source under the terms of the MIT License.

Copyright © 2016 Yaro.

[![GitHub license](https://img.shields.io/badge/license-MIT-brightgreen)](https://raw.githubusercontent.com/vergilet/schoolgirl_uniform/master/LICENSE)

