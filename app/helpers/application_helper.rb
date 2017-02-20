module ApplicationHelper
	def proper_class(status)
		if status = 'done'
			'checked-task'
		else
			''
		end
	end

	def proper_checkbox_attr(status)
		if status = 'done'
			'checked'
		else

		end
	end
end
