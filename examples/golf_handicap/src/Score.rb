
class Score

  attr_accessor :date, :score, :course_name, :course_rating, :course_slope, :used, :handicap 

  include GladeGUI

  def initialize(course, rating, slope)
    @course_name = course
    @course_rating = rating
    @course_slope = slope
    @date = DateTime.now
    @score = "0"
    @used = nil
    @handicap = "0"
  end

  def buttonSave__clicked(*a)
    get_glade_variables
    @used = "n" # signals save occured
    @builder[:window1].destroy
  end  

  def diff()
    (@score.to_f - @course_rating.to_f) * 113 / @course_slope.to_f
  end

  def to_s
    (@used == "y" ? "*" : " ") + diff.round(1).to_s
  end

  def visual_attributes
#    return @used == "y" ? {background: "#ABB" , weight: 600} : {background: "white", weight: 300 }
    return @used == "y" ? { weight: 1200} : {weight: 400 }
  end

end
