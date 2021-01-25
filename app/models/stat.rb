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
  def data
    return {
      rank: rank,
      percentile: percentile, 
      displayName: displayName, 
      displayCategory: displayCategory, 
      category: category, 
      metadata: metadata, 
      value: value, 
      displayValue: displayValue, 
      displayType: displayType, 
      identifier: identifier
    }
  end


  # displayName| player | legend

  before_create :generate_identifier

  protected

  def generate_identifier
    if self.displayName
      self.identifier = "#{self.displayName}|#{self.player_id.to_s}|#{self.legend_id.to_s}"
    else
      no_display_name = "NO_DISPLAY_NAME#{Time.now}"
      self.identifier = "#{no_display_name}|#{self.player_id.to_s}|#{self.legend_id.to_s}"
    end
  end


end
