class ListsController < ApplicationController
  # GET /lists
  # GET /lists.json
  def index
    # @lists = List.all
    @board = {}
    List.all.each do |list|
      @board[list.id] = {}
      @board[list.id][:list] = list
      @board[list.id][:toDo], @board[list.id][:in_progress], @board[list.id][:done] = [], [], []
      list.tasks.each do |task|
        case task.status
          when :toDo
            @board[list.id][:toDo] << task 
          when :in_progress
            @board[list.id][:in_progress] << task 
          when :done
            @board[list.id][:done] << task 
        end
      end
      @board[list.id][:max_tasks] = [@board[list.id][:toDo].count, @board[list.id][:in_progress].count, @board[list.id][:done].count].max
      @board[list.id][:max_tasks] = @board[list.id][:max_tasks] == 0 ? 1 : @board[list.id][:max_tasks]
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lists }
    end
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    @list = List.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @list }
    end
  end

  # GET /lists/new
  # GET /lists/new.json
  def new
    @list = List.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @list }
    end
  end

  # GET /lists/1/edit
  def edit
    @list = List.find(params[:id])
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(params[:list])

    respond_to do |format|
      if @list.save
        format.html { redirect_to :lists, notice: 'List was successfully created.' }
        format.json { render json: @list, status: :created, location: @list }
      else
        format.html { render action: "new" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lists/1
  # PUT /lists/1.json
  def update
    @list = List.find(params[:id])

    respond_to do |format|
      if @list.update_attributes(params[:list])
        format.html { redirect_to :lists, notice: 'List was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list = List.find(params[:id])
    @list.destroy

    respond_to do |format|
      format.html { redirect_to lists_url }
      format.json { head :ok }
    end
  end
end
