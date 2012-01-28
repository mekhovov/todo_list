class Story < ActiveRecord::Base
  has_many :tasks, :dependent => :destroy
  belongs_to :story

  validates :title, :presence => true,
                    :length => { :minimum => 3 }
	
end
