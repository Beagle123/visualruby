
class Score

  attr_accessor :ui_date_calendar, :ui_score_ent, :ui_course_name_ent
  attr_accessor :ui_course_rating_ent, :ui_course_slope_ent, :used, :handicap 

  include GladeGUI

  def initialize(course, rating, slope)
    @ui_course_name_ent = course
    @ui_course_rating_ent = rating
    @ui_course_slope_ent = slope
    @ui_date_calendar = DateTime.now
    @ui_score_ent = "90"
    @used = nil
    @handicap = 0
  end

  def ui_save_but__clicked(*a)
    get_glade_variables
    @used = "n" # signals save occured
    @builder[:window1].close
  end  

  def diff()
    ((@ui_score_ent.to_f - @ui_course_rating_ent.to_f) * 113 / @ui_course_slope_ent.to_f).round(1)
  end

  def to_s
    (@used == "y" ? "*" : " ") + diff.round(1).to_s
  end

  def each_cell(col, ren, model, iter)
    ren.weight = @used == "y" ? 700 : 400
  end

end
