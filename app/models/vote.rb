class Vote
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short

  field :uid, type: String
  field :winner, type: String
  field :loser, type: String

  validates_presence_of :uid
  validates_length_of :uid, is: 6
  validates_presence_of :winner
  validates_length_of :winner, is: 12
  validates_presence_of :loser
  validates_length_of :loser, is: 12

  index({ uid: 1 }, { background: true })
  index({ c_at: -1 }, { background: true })
  index({ u_at: -1 }, { background: true })

  scope :session, ->(term) { gte(c_at: term.begin).lt(c_at: term.end) }

  def log
    self.class.log(uid, winner, loser)
  end

  def to_log
    "#{uid}|#{winner}/#{loser}"
  end

  class <<self
    def apply(uid, winner, loser)
      self.create uid: uid, winner: winner.identifier, loser: loser.identifier
    end

    def log(uid, winner, loser)
      winner_id = winner.respond_to?(:identifier) ? winner.identifier : winner
      loser_id = loser.respond_to?(:identifier) ? loser.identifier : loser
      Rails.wl_logger.info("WL") {
        "#{uid}|#{winner}/#{loser}"
      }
    end

    def counting
      c_time = Time.now
      gengo_all = Gengo.all.cache
      period = Glicko2::RatingPeriod.from_objs(gengo_all)
      self.session(Voting.term(c_time)).each do |vote|
        period.game(
          [
            gengo_all.where(identifier: vote.winner).first,
            gengo_all.where(identifier: vote.loser).first
          ],
          [1, 2]
        )
        vote.log
      end
      next_period = period.generate_next
      next_period.players.each do |player|
        player.update_obj
        gengo = player.obj
        gengo.display_rating = gengo.rating
        gengo.save
      end
    def to_log
      self.each.map(&:to_log).join("\n")
    end

      voting = Voting.create(
        last_counting_at: c_time,
        sums: gengos.sum(&:rating),
        counts: gengos.size
      )
      voting.backup
    end
  end

end
