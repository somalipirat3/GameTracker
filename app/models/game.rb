class Game
  include Mongoid::Document
  field :title, type: String
  field :release_date, type: String
  field :summary, type: String

  has_many :members, autosave: true
  has_many :legends, autosave: true

  index({ title: 1 }, { unique: true, name: "title_index" })
end
