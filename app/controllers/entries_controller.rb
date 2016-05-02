class EntriesController < ApplicationController
  before_action :set_user
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :ensure_author, except: [:index, :show]

  # GET /users/:user_name/entries
  def index
    @entries = Entry.all
  end

  # GET /users/:user_name/entries/1
  def show
  end

  # GET /users/:user_name/entries/new
  def new
    @entry = @user.entries.new
  end

  # GET /users/:user_name/entries/1/edit
  def edit
  end

  # POST /users/:user_name/entries
  def create
    @entry = @user.entries.new(entry_params)

    if @entry.save
      redirect_to [@user, @entry], notice: 'Entry was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/:user_name/entries/1
  def update
    if @entry.update(entry_params)
      redirect_to [@user, @entry], notice: 'Entry was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/:user_name/entries/1
  def destroy
    @entry.destroy
    redirect_to user_entries_url(@user), notice: 'Entry was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find_by!(name: params[:user_name])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_entry
    @entry = Entry.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def entry_params
    params.fetch(:entry, {}).permit(
      :title,
      :body
    )
  end

  def ensure_author
    raise '許可されていない操作です' if @user != current_user
  end
end