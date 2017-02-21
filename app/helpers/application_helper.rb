module ApplicationHelper
	def proper_class(status)
		if status == 'done'
			{:class => 'checked-task'}
		else
			{:class => ''}
		end
	end

	def proper_checkbox_attr(status)
		if status == 'done'
			true
		else
			false
		end
	end
end
