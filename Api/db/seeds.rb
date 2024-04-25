# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
['NVIDIA Corp', 'Alphabet Inc', 'Microsoft Corp', 'Tesla Inc', 'Google Inc'].each do |stock|
    Stock.find_or_create_by!(name: stock)
end

User.create!(name: 'Test User', email: 'test@example.com', password: 'test123')