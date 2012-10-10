Normatron.setup do |config|
  config.default_filters = :blank, :squish
  config.add_orm Normatron::Extensions::ActiveRecord
end