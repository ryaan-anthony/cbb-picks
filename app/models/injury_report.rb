class InjuryReport
  include Mongoid::Document
  embedded_in :team, class_name: Team
  field :player
  field :injury
  field :status
end