module SeedsImporter
  @@default_options = { bypass_document_validation: true, ordered: false }

  extend ActiveSupport::Concern

  class_methods do
    def import_from_json(filepath, defaults = {}, options = @@default_options)
      File.open(filepath) do |file|
        operations = JSON.load(file).map{|item|
          {
            identifier: Identifier.identify(item), surface: item.to_s
          }.reverse_merge(defaults)
        }
        self.collection.insert_many(operations, options)
      end
    end
  end
end
