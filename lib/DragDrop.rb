# The main namespace for visualruby.
module VR

  module Draggable
     def add_target_widget(widget)
       @target_widgets ||= []
       @target_widgets << widget
       ar = [[ self.object_id.to_s, :same_app, 12_345]]
      drag_source_set(Gdk::ModifierType::BUTTON1_MASK |
                    Gdk::ModifierType::BUTTON2_MASK,
                    ar,
                    Gdk::DragAction::COPY |
                    Gdk::DragAction::MOVE)  
        widget.extend(VR::Droppable) unless widget.is_a?(VR::Droppable)
        widget.add_source_widget(self)
#        if not self.respond_to?(:drag_begin)
          self.signal_connect("drag_begin") do |widget, context|
            @target_widgets.each { |widg| widg.dragged_widget = self } 
          end        
#        end
      end
  end

  module Droppable

    attr_accessor :dragged_widget, :source_widgets


    @dragged_widget = nil

    def add_source_widget(widget)
      @source_widgets ||= []
      @source_widgets << [widget.object_id.to_s, :same_app, 12_345]
     drag_dest_set(Gtk::DestDefaults::MOTION |
                  Gtk::DestDefaults::HIGHLIGHT,
                  @source_widgets,
                  Gdk::DragAction::COPY |
                  Gdk::DragAction::MOVE)
    end

  end
end

#  module DragDrop
#  
#    attr_accessor :dragged_widget, :drag_array
#  
#    def drag_array(element = nil)
#      @dnd ||= [] 
#      @dnd.push(element) if not element.nil?
#      return @dnd
#    end
#  
#
#    def drag_to(target_widget) #Gdk::Window::BUTTON1_MASK)
#
#      @target_widgets ||= []
#      @target_widgets << target_widget
#
##      @drag_array ||= []
##      @drag_array <<
#
#      ar = [[ self.object_id.to_s, :same_app, 12_345]]
#     drag_source_set(Gdk::ModifierType::BUTTON1_MASK |
#                    Gdk::ModifierType::BUTTON2_MASK,
#                    ar,
#                    Gdk::DragAction::COPY |
#                    Gdk::DragAction::MOVE)  
#
#      ar = target_widget.drag_array([ self.object_id.to_s, :same_app, 12_345]) 
#     target_widget.drag_dest_set(Gtk::DestDefaults::MOTION |
#                  Gtk::DestDefaults::HIGHLIGHT,
#                  ar,
#                  Gdk::DragAction::COPY |
#                  Gdk::DragAction::MOVE)
#
#      if not @done
#        @done = true
#        self.signal_connect("drag_begin") do |widget, context|
#          @target_widgets.each { |widg| widg.dragged_widget = self } 
#        end        
#      end
#  
#    end
#  
#  end
#
#end

