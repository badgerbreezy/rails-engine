# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d rails-engine_development db/data/rails-engine-development.pgdump"
puts "Loading PostgreSQL Data dump into local database with command:"
puts cmd
system(cmd)

csv_text = File.read(Rails.root.join("db", "data", "items.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
csv.each do |row|
  t = Item.new
  t.id = row['id'].to_i
  t.name = row['name']
  t.description = row['description']
  t.unit_price = row['unit_price'].to_f / 100
  t.merchant_id = row['merchant_id']
  t.created_at = row['created_at']
  t.updated_at = row['updated_at']
  t.save
end
puts "There are now #{Item.count} rows in the items table"
