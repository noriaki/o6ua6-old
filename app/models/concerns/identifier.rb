module Identifier
  extend ActiveSupport::Concern

  class_methods do
    def identify(value)
      CGI.escape(value).gsub('%', '').downcase.reverse.to_s
    end
  end
end
