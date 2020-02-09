class Team
  include Mongoid::Document
  field :name
  field :sports_radar_id
  field :sports_reference_id
  embeds_many :rankings, class_name: Ranking
  validates :name, presence: true
  validates :sports_radar_id, presence: true
end