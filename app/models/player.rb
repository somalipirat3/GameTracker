class Player
  include Mongoid::Document
  has_many :members, autosave: true
  has_many :stats, autosave: true

  field :username, type: String
  field :platform, type: String
  field :avatar_url, type: String
  field :identifier, type: String
  
  index({ identifier: 1 }, { unique: true, name: "identifier_index" })
  index username: 'text'


  before_create :generate_identifier

  protected

  def generate_identifier
   self.identifier = "#{self.username}|#{self.platform}"
  end

end
