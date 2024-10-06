

class MyTextView < Gtk::TextView

  def self__focus_in_event(*args)
    self.buffer.text = "CALLED:  self__focus_in_event():  Editing Now!"
    return false
  end

  def self__focus_out_event(*args)
    self.buffer.text = "CALLED:  self__focus_out_event:   Waiting..."
    return false
  end
  

end
