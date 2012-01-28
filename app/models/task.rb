class Task < ActiveRecord::Base
  belongs_to :story

  validates :title, :presence => true,
                    :length => { :minimum => 3 }

  enum_attr :status, %w(^toDo in_progress done closed)
  enum_attr :priority, %w(high ^normal low)
  
end
