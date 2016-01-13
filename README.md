# Wayward

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wayward' github: 'waywardcombr/wayward-rb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ git clone https://github.com/waywardcombr/wayward-rb.git
    $ cd wayward-rb && gem build wayward.gemspec
    $ gem install wayward-0.0.1.gem

## Usage

To configure:

```ruby
  Wayward.configure do |config|
    config.email = 'email@domain.com'
    config.secret = 'carry-on-my-wayward-secret'
  end
```

To pick a project:

```ruby
  Wayward.configure do |config|
    config.project = 'Project Name'
  end
```

To create a project:

```ruby
  project = Wayward.new
  project.name = "Project name"
  project.template = "Project to use as template name"
  project.save # => true/false
  project.errors # => array of errors if creation fails
```

To create a record:

```ruby
  thing = Wayward::Thing.new
  thing.some_attr = 'some value'
  thing.other_attr = 'some value'
  thing.save # => true/false
```

To fetch records:

```ruby
  Wayward::Thing.where(some_attr: 'some value', other_attr: 'some value') # => [#<Wayward::Thing>]
```

To update a record:

```ruby
  thing = Wayward::Thing.where(id: 3769).first
  thing.some_attr = 'new value'
  thing.save # => true/false
```

## Contributing

1. Fork it ( https://github.com/waywardcombr/wayward-rb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
