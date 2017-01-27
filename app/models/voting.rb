class Voting
  include Mongoid::Document

  field :last_counting_at, type: Time
  field :sums, type: Integer
  field :counts, type: Integer

  index({ last_counting_at: -1 }, { background: true })

  default_scope -> { desc(:last_counting_at) }

  def filename
    'voting_' + last_counting_at.strftime('%Y%m%d-%H%M%S')
  end

  def backup
    filename
  end

  class << self
    def term(end_time = Time.now)
      self.first.last_counting_at..end_time
    end
  end
end
