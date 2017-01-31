class Vote
  WIN = 1
  LOSE = 2

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

    def dispose(players)
      period = Glicko2::RatingPeriod.from_objs(players)
      players_map = players.group_by(&:identifier)
      self.each do |vote|
        period.game(
          [
            players_map[vote.winner].first,
            players_map[vote.loser].first
          ], [WIN, LOSE])
      end
      period.generate_next.players.map do |player|
        player.update_obj; player.obj
      end
    end

    def to_log
      self.each.map(&:to_log).join("\n")
    end

    def counting
      count_target_range = Voting.term
      gengo_all = Gengo.all.cache
      votes = self.session(count_target_range).cache
      calculated_gengos = votes.dispose(gengo_all)
      before_calculated_gengos = calculated_gengos.map{|g|
        [ { _id: g._id }, g.changed_attributes ]
      }.dup.reject{|g| g[1].blank? }
      Gengo.bulk_update(calculated_gengos)
      voting = Voting.create(
        counting_start_at: count_target_range.first,
        counting_end_at: count_target_range.end,
        votes_count: votes.size
      )
      voting.backup(votes)
    rescue => error
      voting.destroy unless voting.nil?
      unless before_calculated_gengos.nil?
        Gengo.bulk_update(before_calculated_gengos)
      end
    else # when no errors
      votes.destroy_all
    end
  end

end
