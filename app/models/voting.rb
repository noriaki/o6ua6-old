class Voting
  include Mongoid::Document

  field :counting_start_at, type: ActiveSupport::TimeWithZone
  field :counting_end_at, type: ActiveSupport::TimeWithZone
  field :votes_count, type: Integer

  index({ counting_start_at: -1 }, { background: true })
  index({ counting_end_at: -1 }, { background: true })

  default_scope -> { desc(:counting_end_at) }

  def to_h
    a = Hash[*fields.keys.dup.map{|key| [key, self.send(key)] }.flatten]
    a['id'] = a.delete('_id')
    a.with_indifferent_access
  end

  def filename
    "voting_#{counting_end_at.strftime('%Y%m%d-%H%M%S')}_#{id.to_s}"
  end

  def backup
    filename
  end

  class << self
    def term(end_time = Time.zone.now)
      self.first.counting_end_at..end_time
    end
  end
end
