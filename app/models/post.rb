class Post < ActiveRecord::Base
  validates :text, :presence => true
end
