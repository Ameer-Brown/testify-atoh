class Comment < ActiveRecord::Base
   belongs_to :testimony
   belongs_to :user
end
