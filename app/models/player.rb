class Player
  include Mongoid::Document
  has_many :members, autosave: true
  has_many :stats, autosave: true


  field :username, type: String
  field :platform, type: String
  field :avatar_url, type: String
  
  index({ username: 1 }, { unique: true, name: "username_index" })
  index username: 'text'

end
