module StoriesHelper
  
  def fill_board stories
  	board = {}
    stories.each do |story|
      board[story.id] = {}
      board[story.id][:story] = story
      board[story.id][:toDo], board[story.id][:in_progress], board[story.id][:done] = [], [], []
      story.tasks.each do |task|
        case task.status
          when :toDo
            board[story.id][:toDo] << task 
          when :in_progress
            board[story.id][:in_progress] << task 
          when :done
            board[story.id][:done] << task 
        end
      end
      board[story.id][:max_tasks] = [board[story.id][:toDo].count, board[story.id][:in_progress].count, board[story.id][:done].count].max
      board[story.id][:max_tasks] = board[story.id][:max_tasks] == 0 ? 1 : board[story.id][:max_tasks]
    end

    board
  end

  def counts stories
    counts = {story: 0, toDo: 0, in_progress: 0, done: 0, closed: 0}

    stories.each do |story|
      counts[:story] += 1
      story.tasks.each {|task|  counts[task.status.to_sym] += 1}
    end

    counts
  end


end
