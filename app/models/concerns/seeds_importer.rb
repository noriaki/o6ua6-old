module SeedsImporter
  DEFAULT_BULK_INSERT_OPTIONS = {
    bypass_document_validation: true, ordered: false
  }.freeze

  extend ActiveSupport::Concern

  class_methods do
    def import_from_json(filepath, defaults = {}, options = DEFAULT_BULK_INSERT_OPTIONS)
      File.open(filepath) do |file|
        operations = JSON.parse(file.read).map do |item|
          {
            identifier: Identifier.identify(item), surface: item.to_s
          }.reverse_merge(defaults)
        end
        pp options
        collection.insert_many(operations, options)
      end
    end
  end
end
