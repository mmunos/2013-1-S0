module ApplicationHelper

	def nav_link(link_text,link_path)
		if (params[:controller] == "seasons" || params[:controller] == "episodes" || params[:controller] == "serials" ) 
			class_name = link_path == serials_path ? 'active' : ''
		elsif (params[:controller] == "movies" ) 
			class_name = link_path == movies_path ? 'active' : ''
		else 
			class_name = current_page?(link_path) ? 'active' : ''
		end
	    link_to link_text, link_path, class: class_name
	end
end
