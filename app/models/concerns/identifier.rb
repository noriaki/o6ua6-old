module Identifier
  extend ActiveSupport::Concern

  def self.identify(value)
    CGI.escape(value).gsub('%', '').downcase.reverse.to_s
  end

  class_methods do
    def identify(value)
      Identifier.identify(value)
    end
  end
end
