class Stat
  include Mongoid::Document
  belongs_to :player
  belongs_to :legend

  field :rank, type: String
  field :percentile, type: String
  field :displayName, type: String
  field :displayCategory, type: String
  field :category, type: String
  field :metadata
  field :value, type: String
  field :displayValue, type: String
  field :displayType, type: String
  field :identifier, type: String

  index({ identifier: 1 }, { unique: true, name: "identifier_index" })

end
