class Team
  include Mongoid::Document
  field :name
  embeds_many :rankings, class_name: Ranking
  embeds_many :players, class_name: Player
  validates :name, presence: true

  def rankings_for(game)
    rankings.where(game_id: game.id).first
  end
end