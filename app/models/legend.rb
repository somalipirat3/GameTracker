class Legend
  include Mongoid::Document
  belongs_to :game
  has_many :stats

  field :name, type: String
  
  index({ name: 1 }, { unique: true, name: "name_index" })
end
