class Handicap

  include GladeGUI

  def initialize()
    @scores = []
  end

  def before_show()
    @ui_rounds_listview = VR::ListView.new(rnd: String, date: VR::Col::CalendarCol, 
      course: String, rating_slope: String, score: String, diff: Score,
      hcp: String)
    @ui_rounds_listview.col_xalign(diff: 1, hcp: 1, score: 1)
    @ui_rounds_listview.col_sortable(date: true, course: true)
    @ui_rounds_listview.show
    golfer_file = File.basename(@vr_yaml_file, ".*")
    golfer = golfer_file.split("_").map(&:capitalize).join(' ')
    @builder[:ui_name_lbl].label = "<big><big><big><big><big>#{golfer}</big></big></big></big></big>"
    if File.exist?(golfer_file + ".jpg")
      @builder[:ui_image].file = golfer_file + ".jpg"  
      @builder[:ui_image].visible = true
    end
    refresh()
  end

  def refresh()
    update_handicaps
    @ui_rounds_listview.model.clear
    i = 1
    @scores.each do |s|
      row = @ui_rounds_listview.add_row()
      row[:rnd] = "#{i}."
      i += 1
      row[:date] = VR::Col::CalendarCol.new(s.ui_date_calendar, :format => "%d %b %Y ", :hide_time=>true, :hide_date => false)
      row[:course] = s.ui_course_name_ent
      row[:score] = s.ui_score_ent
      row[:rating_slope] = "#{s.ui_course_rating_ent.to_s}/#{s.ui_course_slope_ent.to_s}"
      row[:diff] = s  # store whole object
      row[:hcp] = s.handicap 
    end
  end

  def ui_add_but__clicked(*a)
    if row = @ui_rounds_listview.selected_rows.first
      course = row[:course]
      rating, slope = row[:rating_slope].split("/")
    else
      course = "Agusta National"
      rating = "70"
      slope = "134"
    end 
    score = Score.new(course, rating, slope)
    score.show_glade(self)
    if !score.used.nil? and score.ui_score_ent.to_i > 50  #score.used = "n" when save butoon pressed
      @scores << score
      @scores.sort! { |x,y| y.ui_date_calendar <=> x.ui_date_calendar }
      refresh()
    end
  end

  def update_handicaps
    @scores.each_index do |i| 
      fill_handicap(@scores[@scores.size-i-1..@scores.size-1]) 
    end
    @scores.each {|s| s.used = ""}
    fill_handicap(@scores)
    @builder[:ui_handicap_lbl].label = "<big><big><big><big><big><big><big><big>#{@scores[0].handicap}</big></big></big></big></big></big></big></big>" if @scores[0]
  end

  def fill_handicap(score_array)
    score_ar = score_array.size > 20 ? score_array[0..19] : score_array
    count = use_count(score_ar) # number of scores to use for handicap
    best_scores = score_ar.sort { |x,y| x.diff <=> y.diff } 
    best_scores = count > 0 ? best_scores[0..count-1] : []
    best_scores.each {|s| s.used = "y"}
    tot = best_scores.inject(0) { |sum, s| sum + s.diff }
    x = (0.96*tot/count).to_s  
    score_array[0].handicap = count > 0 ? x[0..x.index(".")+1] : "n/a"  if score_array[0]
  end

  def ui_change_but__clicked(*a)
    @ui_rounds_listview = nil  # so it doesn't save contents
    VR::save_yaml(self)
    @builder[:window1].close
    load_new_golfer
  end


  def window1__delete_event(*)
    @ui_rounds_listview = nil
    VR::save_yaml(self)
    return false #ok to close
  end

  def use_count(score_ar)
    if score_ar.size > 20 
      return 10
    else
      return [0,0,0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,8,9,10][score_ar.size-1]
    end
  end  

  def ui_delete_but__clicked(*a)
    return unless row = @ui_rounds_listview.selected_rows.first
    if alert("Are you sure you want to delete this score?", button_yes: "Delete", button_no: "Cancel")
      @scores.delete(row[:diff])
      refresh
    end   
  end

  def ui_edit_but__clicked(*a)
    return unless row = @ui_rounds_listview.selected_rows.first
    row[:diff].show_glade 
    @scores.sort! { |x,y| y.ui_date_calendar <=> x.ui_date_calendar }
    refresh     
  end
end
