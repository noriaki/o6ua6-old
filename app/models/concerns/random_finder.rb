module RandomFinder
  extend ActiveSupport::Concern

  included do
    scope :random, -> { skip rand(self.count) }
  end
=begin
  included do
    scope :random, -> {
      queryable.options[:random] = true
      c = queryable.options.delete(:limit) || 1
      map = <<~"EOMS"
      function() {
        emit(1, {
               surface: this.surface,
               identifier: this.identifier,
               rdm: Math.random()
             });
      }
      EOMS
      reduce = <<~"EORS"
      function(key, values) {
        values.sort(function(a, b) { return a.rdm - b.rdm; });
        return values.slice(
                 0, #{c}
               );
      }
      EORS
      queryable.map_reduce(map, reduce).out(inline: 1).to_criteria
      #skip(rand(self.count))
    }
    scope :randomx, Proc.new {|n|
      c = self.count
      if n
        queryable.documents =
          (0..c-1).sort_by{ rand }[0, n].map{|i| self.skip(i) }
        queryable
      else
        skip(rand(c))
      end
    }
  end

  class_methods do
    def random
      c = (:limit) || 1
      map = <<~"EOMS"
      function() {
        emit(1, {
               surface: this.surface,
               identifier: this.identifier,
               rdm: Math.random()
             });
      }
      EOMS
      reduce = <<~"EORS"
      function(key, values) {
        values.sort(function(a, b) { return a.rdm - b.rdm; });
        return values.slice(
                 0, #{c}
               );
      }
      EORS
      map_reduce(map, reduce)
    end
  end
=end
end
