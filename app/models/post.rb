class Post < ActiveRecord::Base
  attr_accessible :body, :user_id, :created_at
  validates :body, :presence => true, :length => { minimum: 1, maximum: 140 }

  belongs_to :user
end