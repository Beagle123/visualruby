class Handicap

  include GladeGUI

  def initialize()
    @scores = []
  end

  def before_show()
    @view = VR::ListView.new(rnd: String, date: VR::Col::CalendarCol, 
      course: String, rating_slope: String, score: String, diff: Score,
      hcp: String)
    @view.col_xalign(diff: 1, hcp: 1, score: 1)
    @view.col_sortable(date: true, course: true)
    @view.show
    golfer_file = File.basename(@vr_yaml_file, ".*")
    golfer = golfer_file.split("_").map(&:capitalize).join(' ')
    @builder[:name].label = "<big><big><big><big><big>#{golfer}</big></big></big></big></big>"
    if File.exists?(golfer_file + ".jpg")
      @builder[:image].file = golfer_file + ".jpg"  
      @builder[:image].visible = true
    end
    refresh()
  end

  def refresh()
    update_handicaps
    @view.model.clear
    i = 1
    @scores.each do |s|
      row = @view.add_row()
      row[:rnd] = "#{i}."
      i += 1
      row[:date] = VR::Col::CalendarCol.new(s.date, :format => "%d %b %Y ", :hide_time=>true, :hide_date => false)
      row[:course] = s.course_name
      row[:score] = s.score
      row[:rating_slope] = "#{s.course_rating.to_s}/#{s.course_slope.to_s}"
      row[:diff] = s
      row[:hcp] = s.handicap 
    end
  end

  def buttonAdd__clicked(*a)
    if row = @view.selected_rows.first
      course = row[:course]
      rating, slope = row[:rating_slope].split("/")
    else
      course = rating = slope = ""
    end 
    score = Score.new(course, rating, slope)
    score.show_glade
    if !score.used.nil? and score.score.to_i > 50
      @scores << score
      @scores.sort! { |x,y| y.date <=> x.date }
      refresh()
    end
  end

  def update_handicaps
    @scores.each_index do |i| 
      fill_handicap(@scores[@scores.size-i-1..@scores.size-1]) 
    end
    @scores.each {|s| s.used = ""}
    fill_handicap(@scores)
    @builder[:handicap].label = "<big><big><big><big><big><big><big><big>#{@scores[0].handicap}</big></big></big></big></big></big></big></big>" if @scores[0]
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

  def buttonChangeGolfer__clicked(*a)
    @view = nil  # so it doesn't save contents
    VR::save_yaml(self)
    @builder[:window1].destroy
    load_new_golfer
  end


  def window1__delete_event(*)
    @view = nil
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

  def buttonDelete__clicked(*a)
    return unless row = @view.selected_rows.first
    if alert("Are you sure you want to delete this score?", button_yes: "Delete", button_no: "Cancel")
      @scores.delete(row[:diff])
      refresh
    end   
  end

  def buttonEditScore__clicked(*a)
    return unless row = @view.selected_rows.first
    row[:diff].show_glade 
    @scores.sort! { |x,y| y.date <=> x.date }
    refresh     
  end
end
