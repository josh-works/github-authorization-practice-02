class Pin < ApplicationRecord
  
  def lat_lng
    "#{latitude}, #{longitude}"
  end
end
