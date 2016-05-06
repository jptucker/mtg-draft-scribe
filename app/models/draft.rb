class Draft < ActiveRecord::Base

  has_many :selections
  belongs_to :user

end
