module UserReviewsPosts
  
  extend ActiveSupport::Concern

    def show_reviews
      respond_to do |format|
        format.html 
        format.js { render "reviews/index" }
      end
    end

    def show_posts
      respond_to do |format|
        format.html
        format.js { render "posts/index" }
      end
    end
end