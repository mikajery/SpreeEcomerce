# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)

default_path = File.join(File.dirname(__FILE__), 'seeds')

Spree::Config[:default_country_id] = Spree::Country.find_by(name: "Malaysia").id

["zones", "states"].each do |file|
  path = File.join(default_path, file+".rb")
  puts "loading ruby #{path}"
  load(path)
end

