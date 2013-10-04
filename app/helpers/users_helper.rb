module UsersHelper
	def is_himself?(user)
      if current_user
        user == current_user
      end 
    end
end
