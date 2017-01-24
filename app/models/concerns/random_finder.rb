module RandomFinder
  extend ActiveSupport::Concern

  class_methods do
    def random(*n)
      n = n.present? ? n.first : (options.delete(:limit) || 1)
      (0..count-1).sort_by{ rand }[0, n].map{|i| skip(i).first }
    end
  end
end
