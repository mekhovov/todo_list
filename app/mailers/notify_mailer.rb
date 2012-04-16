class NotifyMailer < ActionMailer::Base
  default :from => "todo@list.com"

  def invite_user user, project, domain, new_user
  	@user, @project, @domain, @new_user = user, project, domain, new_user
  	# TODO: use user.email instead of 'alex.mehovov@gmail.com'
    mail(:to => user.email, :subject => "[ToDoList] User #{project.owner.email} invited you '#{project.name}'")
  end

end
