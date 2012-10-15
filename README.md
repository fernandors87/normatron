# Normatron

Normatron is a Ruby On Rails plugin that perform attribute normalizations for ActiveRecord objects.<br />
With it you can normalize attributes to the desired format before saving them in the database.<br />
This gem inhibits the work of having to override attributes or create a specific method to perform most of the normalizations.

## Installation

Let the bundler install the gem by adding the following into your application gemfile:

```ruby
gem 'normatron'
```

And then bundle it up:

```bash
$ bundle install
```

Or install it by yourself:

```bash
$ gem install normatron
```

Then run the generator:

```bash
$ rails generator normatron:install
```

## The problem

Suppose you have a product model as the following:

```ruby
# ./db/migrate/20120101010000_create_products.rb
class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :name
      t.decimal :price, :precision => 10, :scale => 2
    end
  end
end
```
```ruby
# ./app/models/products.rb
class Product < ActiveRecord::Base
  attr_accessible :name, :price
end
```

If you want the *name* attribute be uppercased before saving it into the database, the most usual approaches includes:

* Override the *name* setter and convert the value to an uppercased string.
* Write a method or block and bind it to an [ActiveRecord callback](http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html) (like *before_validation* or *before_save*).

Both ways are ilenegant, boring to implement, error prone and very expensive.<br />
What led me to make this gem and offer a third way to handle this.

## Usage

Call the [normalize](http://www.rubydoc.info/github/fernandors87/normatron/Normatron/Extensions/ActiveRecord/ClassMethods:normalize) class method inside your model to set the normalization rules:

```ruby
# ./app/models/products.rb
class Product < ActiveRecord::Base
  attr_accessible :name, :price
  normalize :name
end
```

And it will behave like this:

```bash
 $ rails console
 > memory = Product.create name: "  memory   card    "
=> #<Product id: nil, name: "memory card", price: nil>
 > unknown = Product.create name: "    "
=> #<Product id: nil, name: nil, price: nil>
```

In this case the `:with` option was ommited, then the [:blank](http://rubydoc.info/gems/normatron/Normatron/Filters/BlankFilter) and [:squish](http://rubydoc.info/gems/normatron/Normatron/Filters/SquishFilter) filters was called to the *name* attribute.<br />
These are the default filters and can be easily changed in the initializer file.

To specify which kind of filters will be binded to each attribute, pass the filter name to the `:with` option:

```ruby
class MyModel < ActiveRecord::Base
  # Single filter to a single attribute
  normalize :attr_a, :with => :upcase

  # Multiple filters to multiple attributes
  normalize :attr_b, :attr_c, :attr_d, :with => [:upcase, :squish]

  # The :keep filter is an example of filter that uses arguments.
  # In this case, the filter is passed as a Hash, where the key is the filter name,
  # and the value is an Array of arguments.
  normalize :attr_e, :with => {:keep => [:Latin, :Z]}

  # The same as above can be obtained using an Array instead of a Hash.
  # But when filter uses arguments, set him inside another Array is mandatory.
  normalize :attr_f, :with => [[:keep, :Latin, :Z]]

  # Mix simple filters with filters carrying arguments this way:
  normalize :attr_g, :with => [:blank, {:keep => [:Latin, :Z]}, :squish]

  # Or this way:
  normalize :attr_h, :with => [:blank, [:keep, :Latin, :Z], :squish]
end
```

### Filter Stackings

The normalize method stack the filters when called multiple times to the same attribute.

```ruby
# 1st Way: Without stacking filters
class MyModel < ActiveRecord::Base
  normalize :attr_a, :with => :blank
  normalize :attr_b, :with => [:blank, :squish]
  normalize :attr_c, :with => [:blank, :squish, :upcase]
end

# 2nd Way: Stacking filters
# This piece of code produces the exactly the same results as 1st way.
class MyModel < ActiveRecord::Base
  normalize :attr_a, :attr_b, :attr_c, :with => :blank
  normalize :attr_b, :attr_c, :with => :squish
  normalize :attr_c, :with => :upcase
end
```

### Typing Less

In some cases is possible to write much less by passing multiple attributes to normalize method:

```ruby
# 1st Way: Setting rules to single attributes
class MyModel < ActiveRecord::Base
  normalize :attr_a, :with => :blank
  normalize :attr_b, :with => :squish
  normalize :attr_c, :with => :upcase
  normalize :attr_d, :with => [:blank, :squish]
  normalize :attr_e, :with => [:blank, :upcase]
  normalize :attr_f, :with => [:squish, :upcase]
  normalize :attr_g, :with => [:blank, :squish, :upcase]
end

# 2nd Way: Setting rules to multiple attributes
class MyModel < ActiveRecord::Base
  normalize :attr_a, :attr_d, :attr_e, :attr_g, :with => :blank
  normalize :attr_b, :attr_d, :attr_f, :attr_g, :with => :squish
  normalize :attr_c, :attr_e, :attr_f, :attr_g, :with => :upcase
end
```

### Filters

Normatron have a bunch of built-in filters.<br />
The list of all filters and instructions of how to use them can be found in the [Normatron::Filters](http://rubydoc.info/gems/normatron/Normatron/Filters) documentation.

### Getting Normalization Rules

You can know what kind of rules was set to a model as following:

```
 $ rails console
 > User.normalize_rules
=> {:login => {:blank => nil, :remove => [:Zs]},
    :email => {:blank => nil, :squish => nil, :downcase => nil},
    :name  => {:blank => nil, :squish => nil, :upcase => nil}}
```

### Applying Normalizations

All attributes are automatically normalized by [before_validation](http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html) callback, what means any method that evoke the *before_validation* callback will perform the normalizations.<br />
Some of these methods includes:

* [ActiveRecord::Validations#valid?](http://api.rubyonrails.org/classes/ActiveRecord/Validations.html#method-i-valid-3F)
* [ActiveRecord::Persistence#save](http://api.rubyonrails.org/classes/ActiveRecord/Persistence.html#method-i-save)
* [ActiveRecord::Persistence::ClassMethods#create](http://api.rubyonrails.org/classes/ActiveRecord/Persistence/ClassMethods.html#method-i-create)

To apply the normalizations without doing validations or persistence, just call the [apply_normalizations](http://rubydoc.info/gems/normatron/Normatron/Extensions/ActiveRecord/InstanceMethods#apply_normalizations-instance_method) method as following:

```
 $ rails console
 > user = User.new
 > user.name = "   anon   "
 > user.email = "ANON@GMAIL.COM"
 > user.login = "my name \n is anon"
 > user.attributes
=> {:id    => nil,
    :name  => "   anon   ",
    :email => "ANON@GMAIL.COM",
    :login => "my name \n is anon"}
 > user.apply_normalizations
 > user.attributes
=> {:id    => nil,
    :name  => "ANON",
    :email => "anon@gmail.com",
    :login => "mynameisanon"}
```

### Building Your Own Filters

#### 1st way: Defining a filter as a module

Create a new module with the following characteristics:

* Having a module method called evaluate
* The evaluate method must receive at least one argument
* The first argument must be the value to be filtered

Here is an example:

```ruby
# ./lib/my_filters/emoticon_filter.rb
module MyFilters
  module EmoticonFilter
    def self.evaluate(value, type)
      emot = (type == :sad) ? ":(" : ":D"
      value + emot
    end
  end
end
```

Then add him to your Normatron initializer file:

```ruby
require 'lib/my_filters/emoticon_filter'
Normatron.setup do |config|
  #...
  config.filters[:emoticon] = MyFilter::EmoticonFilter
  #...
end
```

Usage:

```ruby
class Message < ActiveRecord::Base
  belongs_to :person
  normalize :content, :with => {:emoticon => :happy} # Always happy
end
```

1. Pros
  * Allow create specific documentation for your filter
  * More easy to make them portable for multiple applications and purposes
2. Cons
  * Verbose

#### 2nd way: Defining a filter as a lambda

Create a new lambda object with the following characteristics:

* Must receive at least one argument
* The first argument must be the value to be filtered

The lambda will be defined inside Normatron initializer:

```ruby
Normatron.setup do |config|
  #...

  config.filters[:emoticon] = lambda do |value, type|
    emot = (type == :sad) ? ":(" : ":D"
    value + emot
  end

  #...
end
```

Usage:

```ruby
class Message < ActiveRecord::Base
  belongs_to :person
  normalize :content, :with => {:emoticon => :sad} # Always sad
end
```

1. Pros
  * Less verbose than 1st method
2. Cons
  * Hard to share filter functionalities between other applications
  * Hard to use filter functionalities for other purposes

#### 3th way: Defining a filter as model instance method

Create a new instance method within your model with the following characteristics:

* Must receive at least one argument
* The first argument must be the value to be filtered

The method will be defined inside your model class:

```ruby
class Message < ActiveRecord::Base
  belongs_to :person
  normalize :content, :with => :emoticon # Happy or sad according person's mood

  def emoticon(value)
    emot = (person.mood == :happy) ? ":D" : ":("
    value + emot
  end
end
```

1. Pros
  * Can use instance variables
2. Cons
  * Cannot be shared between objects

# Contributing

There are several ways to make this gem even better:

* Forking this project
* Adding new features or bug fixes
* Making tests
* Commiting your changes
* Reporting any bug or unexpected behavior
* Suggesting any improvement
* Sharing with your friends, forums, communities, job, etc...
* Helping users with difficulty using this gem
* Paying me a beer =]

# Credits

This gem was initially inspired on:

* [normalize_attributes](https://github.com/fnando/normalize_attributes) - I liked the cleaner code and simplicity of this gem.
* [attribute_normalizer](https://github.com/mdeering/attribute_normalizer) - Very powerful.

The idea is to mix the good things of both gems, adding some features and changing something to fit my taste.

# License

See file attached to source code or [click here](https://github.com/fernandors87/normatron/blob/master/MIT-LICENSE).