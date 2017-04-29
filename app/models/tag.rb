class Tag < ApplicationRecord
	has_many :story_tags
	has_many :stories, :through => :story_tags
	validates_presence_of :name
end
