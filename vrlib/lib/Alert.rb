
module VR

	class Alert 

		attr_accessor :answer		

		include GladeGUI
		
		def initialize(message, answer, flags = {})
			@flags = flags
			@answer = answer
			@message = message
		end

		def before_show
			@builder[:window1].title = @flags[:title] if @flags[:title]
			@builder[:window1].resize(@flags[:width],100) if @flags[:width].to_i > 100
			@builder[:headline].show if @flags[:headline]
		
			if text = @flags[:input_text]
				@flags[:button_yes] ||= "Save"
				@flags[:button_no] ||= "Cancel"
				@builder[:input_text].show 
			end 

			@builder[:button_no].show if @flags[:button_no]
			@builder[:button_cancel].show if @flags[:button_cancel]
			set_glade_hash(@flags)
		end

		def button_yes__clicked(but)
			@answer.answer = @flags[:input_text] ? @builder[:input_text].text : true
			@builder[:window1].destroy
		end

		def button_no__clicked(but)
			@answer.answer = false		
			@builder[:window1].destroy
		end

		def button_cancel__clicked(but) #answer stays nil	
			@builder[:window1].destroy
		end


	end

	#so it can be passed by reference
  class DialogAnswer
  	attr_accessor :answer
  end

end  


def alert(msg, flags = {})
	@answer = VR::DialogAnswer.new()
	VR::Alert.new(msg, @answer, flags).show
	return @answer.answer 
end



