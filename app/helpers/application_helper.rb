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

	def add_remove_link(show)
		if show.is_a?(Serial)
			if current_user && current_user.serials.include?(show)
				link_to "Remove from My Series", remove_serial_path, class: "remove-show-button"
			else
				link_to "Add to My Series", add_serial_path, class: "add-show-button"
			end
		elsif show.is_a?(Movie)
			if current_user && current_user.movies.include?(show)
				link_to "Remove from My Movies", remove_movie_path, class: "remove-show-button"
			else
				link_to "Add to My Movies", add_movie_path, class: "add-show-button"
			end
		end
	end

	def tag_ul_list(tags_list)
		tags = tags_list.split(",")
		content_tag :ul do
			tags.collect{|tag| concat(content_tag(:li, tag))}
		end	
	end


	def watch_noWatch_link(show)
		if show.is_a?(Serial)
			if current_user && current_user.watchlist.serials.include?(show)
				link_to "Remove from My watchlist", no_watch_serial_path, class: "no_watch-show-button"
			else
				link_to "Add to My Watchlist", watch_serial_path, class: "watch-show-button"
			end
		elsif show.is_a?(Movie)
			if current_user && current_user.watchlist.movies.include?(show)
				link_to "Remove from My Watchlist", no_watch_movie_path, class: "no_watch-show-button"
			else
				link_to "Add to My Watchlist", watch_movie_path, class: "watch-show-button"
			end
		end
	end




end
