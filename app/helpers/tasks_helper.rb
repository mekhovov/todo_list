module TasksHelper
  
  def get_todo
  	tasks = []
    Project.find_all_by_owner_id(current_user.id).each do |proj| 
	    proj.stories.each do |story| 
	      story.tasks.each do |task| 
		    tasks << task if task.status == :toDo
		  end
		end
	end
	tasks
  end

end
