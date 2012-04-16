ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => 'baci.lindsaar.net',
    :user_name            => 'todo.organize',
    :password             => 'todo-qwe123',
    :authentication       => 'plain',
    :enable_starttls_auto => true  
}