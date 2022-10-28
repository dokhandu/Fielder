# Fielder

Provides provision to Store and Customize the Query Fields Configurations for Client,
###### Note: works only with ActiveRecords

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fielder'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install Fielder

## Usage
1. Configuration
 
    You can configure the fielder in two ways, i.e by enabling the read model and not enabling it:
    ```ruby
    Fielder.configure.enable_read = true # to enable read model
    Fielder.configure.enable_read = false # normal mode
   
   # In block Format
   Fielder.configure do |config|
     config.enable_read = true
   end
   
   # To read configuration
   Fielder.configuration

   ```


2. Generators
   
   The vital part of fielder is all about generators, it does it by generating all the  generic classes and module for you.
   
   To install:
   ```ruby
   rails g fielder:install
   ```
   This will generate all the migrations required for installing fielder, but does run the migration.
   Do not run the migration yet.

   Generate all the active record classes for accessing the fielder's objects:
   ```ruby
   rails g fielder:model
   ```
   
   With Options:
    ```ruby
   rails g fielder:model --read-model
   ```
   Generates the fielder's model along with read model, make sure you have read model enabled inside your fielder's 
   configurations.
   
   ###### Note: I recommend using reads only if you have huge database.
   You can also generate read model separately:
    ```ruby
    rails g fielder:read_model
    ```
   For reads, fielder supports materialized view, leverages the features of a very popular gem call scenic, make sure you add
    ```ruby
    gem 'scenic'
    ```
   to you application Gemfile and bundle up. 

   Final step, run the migration:
   
   ```ruby
    bundle exec rails db:migrate
   ```

3. Read Model Set Up
   
   After the migration, you will need to set up the SQL query for you read models schema, i have left this choice completely for the users,
   as there are multiple ways the read models can be formulated depending the on clients need. Following is  the recommended example:
   
   ```SQL
   SELECT prime_models.id                                  AS prime_model_id,
          prime_models.name                                AS prime_model_name,
          prime_models.code                                AS prime_model_code,
          prime_model.modelable_id                         AS modelable_id,
          prime_model.modelable_type                       AS modelable_type

          field_models.id                                  AS field_model_id,
          field_models.name                                AS field_model_name,
          field_models.code                                AS field_model_code,

          field_settings.id                                AS setting_id,
          field_settings.rank                              AS setting_rank,
          field_settings.display                           AS setting_display


   FROM prime_models
     LEFT JOIN  field_models ON  field_models.prime_model_id = prime_models.id
     LEFT JOIN  field_settings ON field_settings.field_model_id = field_models.id
   ```
 
4. Refresh Read Model  
   Fielder's read model generator will always generate read model which supports concurrent refresh(uniq index enabled for `setting_id`).
   If you want to have this feature disabled:

   ```ruby
   # goto app/models/prime_model_list.rb and make concurrently: false, like following
   

   class PrimeModelList < ActiveRecord::Base
       self.primary_key = :setting_id

       def self.refresh
         Scenic.database.refresh_materialized_view(table_name, concurrently: false, cascade: false)
       end

       def readonly?
         true
       end
   end
   
   # or take it out, as the key argument as default false in scenic
   ```