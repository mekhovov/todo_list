class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.own_projects | current_user.projects

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @stories = @project.stories

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new
    @project.owner_id = current_user.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    redirect_to(@project, alert: "Only owner '#{@project.owner.email}' can edit this project") if @project.owner != current_user
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    redirect_to(@project, alert: "Only owner '#{@project.owner.email}' can delete this project") and return if @project.owner != current_user
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :ok }
    end
  end

  def invite
    @project = Project.find(params[:project_id])
    user_attrs = params[:project][:users_attributes]

    flash[:info], flash[:error] = [], []
    user_attrs.each_value.map{|u| u[:email].strip }.each do |email|
      next if email.empty?
      if current_user.email == email
        flash[:info] << "You don't need to invite yourself"
      else 
        user = User.find_by_email email
        new_user = false
        unless user
          user = User.new
          user.password = User.reset_password_token #won't actually be used...  
          user.reset_password_token = User.reset_password_token 
          user.reset_password_sent_at = Time.now
          user.email = email
          if user.valid?
            user.save
            new_user = true
          else
            flash[:error] << "Invalid email '#{email}'"
            user = nil
          end
        end

        if user
          if (@project.owner == user || @project.users.include?(user) )
            flash[:info] << "User #{email} already invited"
            next
          end
          @project.users << user 
          NotifyMailer.invite_user(user, @project, request.host_with_port, new_user).deliver
          flash[:info] << "User #{email} invited #{new_user ? 'and created. Invitation sent to e-mail' : ''}"
        end
      end
    end
    @project.save
    redirect_to @project
  end
end
