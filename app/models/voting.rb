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

  def backup(votes)
    if Rails.env.development?
      File.open(Rails.root.join('tmp', filename), 'w') do |file|
        file.puts votes.to_log
      end
    else
      s3.object("votes/log/#{filename}").put(
        acl: 'bucket-owner-full-control',
        body: votes.to_log,
        metadata: Hash[*to_h.map{|k,v| [k,v.to_s] }.flatten]
      )
    end
  end

  class << self
    def term(end_time = Time.zone.now)
      self.first.counting_end_at..end_time
    end
  end

  private
  def s3
    Aws::S3::Bucket.new(Aws::S3.bucket_name)
  end
end
