# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

::Mongoid.purge!

File.open(Rails.root.join('db', 'KanjiCandidates.json')) do |file|
  Kanji.collection.bulk_write(
    JSON.load(file).map{|kanji|
      {
        insert_one: {
          identifier: Identifier.identify(kanji),
          surface: kanji.to_s
        }
      }
    }, bypass_document_validation: true, ordered: false)
end

File.open(Rails.root.join('db', 'GengoCandidates.json')) do |file|
  Gengo.collection.bulk_write(
    JSON.load(file).map{|gengo|
      {
        insert_one: {
          identifier: Identifier.identify(gengo),
          surface: gengo.to_s
        }
      }
    }, bypass_document_validation: true, ordered: false)
end

::Mongoid::Tasks::Database.create_indexes
