class Pin < ApplicationRecord
  belongs_to :user
  
  def lat_lng
    "#{latitude}, #{longitude}"
  end
end
