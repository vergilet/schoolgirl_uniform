<br>
<br>
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

:feet: Multistep form concept for Rails projects. Allows to create complex forms for a few models simultaneously. Supports selectable per step validations without data persistance into db.

<br>

## Installation

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

The result will look like this:

```flex
create  app/views/catgirls_survey/_wizard.html.erb
create  app/views/catgirls_survey/_form_errors.html.erb
create  app/views/catgirls_survey/show.html.erb
create  app/views/catgirls_survey/finish.html.erb
create  app/views/catgirls_survey/steps/_first.html.erb
create  app/views/catgirls_survey/steps/_second.html.erb
create  app/views/catgirls_survey/steps/_third.html.erb
create  app/forms/catgirls_survey_form.rb
create  app/controllers/catgirls_survey_controller.rb
 route  resource :catgirls_survey, controller: 'catgirls_survey', only: :show do
          collection do
            match :current, via: [:get, :post]
            get  :previous
            get  :finish
          end
        end

```

<br clear="right">
    
## Usage and Config

To achieve working multistep form you need to configure everything on 3 levels:

- [**1. Form**](#form)

- [**2. Controller**](#controller)

- [**2. View**](#view)


### Form
 - **CatgirlsSurveyForm**

1. Inside the `Form` file declare the steps:

  ```ruby
  # CatgirlsSurveyForm

  def self.steps
    %w[first second third]
  end
  ```
2. Define form fields

  ```ruby
  # CatgirlsSurveyForm  
  
  attribute :username, String
  ```
3. Define validation and select appropriate step for it
  ```ruby
  # CatgirlsSurveyForm 
  
  validates :username, presence: true, if: proc { on_step('second') }
  ```
4. Inside `save!` method build your records, set them with form attributes and save them in transaction. 
   Use `.save!(validate: false)` to skip native validations on model.
   In order to return the result set the `@identifier` with created records reference/references 
   
   ( e.g. simple `1234` or complex `{user_id: 1234, personal_data_id: 5678}` )
  ```ruby
  # CatgirlsSurveyForm 
  
  def save!
    user = User.new(username: username)
    personal_data = user.build_personal_data(email: email)
    
    ActiveRecord::Base.transaction do
      user.save!(validate: false)
      personal_data.save!(validate: false)
    end
    
    @identifier = user.id
  end
  ```
### Controller
 - **CatgirlsSurveyController**
 TODO

### View
 - **Steps, Show, Finish, etc.**
TODO


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

