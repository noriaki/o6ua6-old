class GengoSerializer < ActiveModel::Serializer
  attributes :identifier, :surface, :yomi, :image_urls
end
