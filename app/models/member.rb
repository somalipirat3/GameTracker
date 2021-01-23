class Member
  include Mongoid::Document
  belongs_to :game
  belongs_to :player

  field :identifier, type: String

  index({ identifier: 1 }, { unique: true, name: "identifier_index" })

  before_create :set_member


  def set_member
    identifier =  "#{self.player_id.to_s}|#{self.game_id.to_s}"
  end

end
