
module VR

	class Alert #nodoc

		attr_accessor :answer		

		include GladeGUI
		
		def initialize(msg, answer, flags = {})
			@answer = answer
			@msg = msg
			@headline = flags[:headline]
			@input_text = flags[:input_text] 
			@title = flags[:title] ? flags[:title] : "Visual Ruby"
			@width = flags[:width]
			@button_yes = flags[:button_yes] 
			@button_no = flags[:button_no] # ? flags[:button_no] : "Cancel"
		end

		def before_show
			@builder[:labelMessage].label = @msg
			@builder[:window1].title = @title if @title
			@builder[:window1].resize(@width,70)  if @width
			if @headline
				@builder[:labelHeadline].label = @headline 
			else
				@builder[:labelHeadline].hide
			end
			if @input_text
				@button_yes ||= "Save"
				@button_no ||= "Cancel"
				@builder[:entryText].text = @input_text 
			else
				@button_yes ||= "Ok"
				@builder[:entryText].hide
			end 

			@builder[:buttonYes].label = @button_yes

			#what to do with cancel button?
			if @button_no
				@builder[:buttonNo].label = @button_no
			else #just message so eliminate Cancel button
				 @builder[:buttonNo].hide
			end	
	
		end

		def buttonYes__clicked(but)
			@answer.answer = :ok # @input_text ? @builder[:entryText].text : :ok
			@builder[:window1].destroy
		end

		def buttonNo__clicked(but)		
			@builder[:window1].destroy
		end

	end

	#so it can be passed by reference
  class DialogAnswer
  	attr_accessor :answer
  end

end  


def alert(msg = "Ok", flags = {})
	@answer = VR::DialogAnswer.new()
	VR::Alert.new(msg, @answer, flags).show
	return @answer.answer 
end


#ans = alert("This is a message from the programmer.  Enter Text:  This is a longer message to test wrapping etc.  I'm going to just keep typing until I get a really long message."  ,
#			:headline => "Important Message",
#			:title => "Come On Man...",
#			:input_text => "Hello",
#			:button_yes => "Stash It.",
#			:button_no => "Ditch It.",
#			:width => 500)
#

