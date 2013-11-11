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
				link_to "Remove from My Series", remove_serial_path, class: "remove-show-button", remote: true, data: {disable_with: "Removing…"}
			else
				link_to "Add to My Series", add_serial_path, class: "add-show-button", remote: true, data: {disable_with: "Adding…"}
			end
		elsif show.is_a?(Movie)
			if current_user && current_user.movies.include?(show)
				link_to "Remove from My Movies", remove_movie_path, class: "remove-show-button", remote: true, data: {disable_with: "Removing…"}
			else
				link_to "Add to My Movies", add_movie_path, class: "add-show-button", remote: true, data: {disable_with: "Adding…"}
			end
		end
	end

	def tag_ul_list(tags_list)
		tags = tags_list.split(",")
		content_tag :ul do
			tags.collect{|tag| concat(content_tag(:li, tag))}
		end	
	end


	def watch_unwatch_link(show)
		if show.is_a?(Serial)
			if current_user && current_user.watchlist.serials.include?(show)
				link_to "Remove from My watchlist", unwatch_serial_path, class: "unwatch-show-button", remote: true, data: {disable_with: "Removing…"}
			else
				link_to "Add to My Watchlist", watch_serial_path, class: "watch-show-button", remote: true, data: {disable_with: "Adding…"}
			end
		elsif show.is_a?(Movie)
			if current_user && current_user.watchlist.movies.include?(show)
				link_to "Remove from My Watchlist", unwatch_movie_path, class: "unwatch-show-button", remote: true, data: {disable_with: "Removing…"}
			else
				link_to "Add to My Watchlist", watch_movie_path, class: "watch-show-button", remote: true, data: {disable_with: "Adding…"}
			end
		end
	end


	def seen_unseen_episode_link(episode)
		if current_user && current_user.watched.episodes.include?(episode)
			link_to "Mark as unseen", unseen_episode_path, class: "unseen-episode-button"
		else
			link_to "Mark as seen", seen_episode_path, class: "seen-episode-button"
		end

	end

	def seen_unseen_movie_link(episode)
		if current_user && current_user.watched.movies.include?(episode)
			link_to "Mark as unseen", unseen_movie_path, class: "unseen-episode-button", remote: true, data: {disable_with: "Marking…"}
		else
			link_to "Mark as seen", seen_movie_path, class: "seen-episode-button", remote: true, data: {disable_with: "Marking…"}
		end

	end
	
	def user_gravatar(user, size = 80, clase = nil)
		options = Hash.new
		options[:src] = user.gravatar_url(size)
		options[:class] = clase if clase
		tag(:img, options)
	end

	def contains_user(collection,user)
		collection.exists?(user_id: user.id)
	end

	def find_parent_models(current_model = nil)
	    parents = Array.new
	    params.each do |name, value|
	      if name =~ /(.+)_id$/
	        parents.push $1.classify.constantize.find(value)
	      end
	    end
	    parents.push current_model if current_model
	    parents
	end

end
