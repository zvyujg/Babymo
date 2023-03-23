# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(
   email: 'admin@admin',
   password: 'testtest'
)

Tag.create([
  { name: '子育て' },
  { name: '遊び場所' },
  { name: '離乳食' },
  { name: '育児日記' },
  { name: '育休' }
])