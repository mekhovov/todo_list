class Project < ActiveRecord::Base
	validates :name, :presence => true,
                    :length => { :minimum => 3 }

	has_and_belongs_to_many :users
	has_many :stories

	belongs_to :owner, :class_name => 'User'

	accepts_nested_attributes_for :users, :reject_if => :all_blank

end
