class Follow < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :followee, class_name: User.name 
end
