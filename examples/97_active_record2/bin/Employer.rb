
class Employer < ActiveRecord::Base
  has_many :employees

  include GladeGUI

  def to_s # this is what shows in the VR::ListView
    name
  end

end
