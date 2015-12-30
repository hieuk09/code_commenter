class Repository < ActiveRecord::Base
  validates :path, :name, :link, presence: true
  validates :name, uniqueness: true
end
