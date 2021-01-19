class Player
  include Mongoid::Document
  has_many :members, autosave: true

  field :username, type: String
  index({ username: 1 }, { unique: true, name: "username_index" })
end
