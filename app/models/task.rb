class Task < ActiveRecord::Base
  belongs_to :list

  validates :title, :presence => true,
                    :length => { :minimum => 3 }

  enum_attr :status, %w(^new in_progress done)

  
end
