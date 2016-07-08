class EntriesController < ApplicationController
  before_action :set_user
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :doruby, :doruby_file]
  before_action :ensure_author, except: [:index, :show, :doruby, :doruby_file]

  # GET /users/:user_name/entries
  def index
    @entries = @user.entries.published.recent.page(params[:page]).per(per_page).all
  end

  # GET /users/:user_name/entries/1
  def show
    impressionist(@entry, nil, unique: [:session_hash])
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
      @entry.create_activity :create, params: { title: @entry.title }, owner: @user
      redirect_to [@user, @entry], notice: 'Entry was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/:user_name/entries/1
  def update
    if @entry.update(entry_params)
      @entry.create_activity :update, params: { title: @entry.title }, owner: @user
      redirect_to [@user, @entry], notice: 'Entry was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/:user_name/entries/1
  def destroy
    @entry.create_activity :destroy, params: { title: @entry.title }, owner: @user
    @entry.destroy
    redirect_to user_entries_url(@user), notice: 'Entry was successfully destroyed.'
  end

  def doruby
    @entry = Entry.find_by_permalink!(@user, params[:date], params[:slug])
    redirect_to [@user, @entry], status: :moved_permanently
  end

  def doruby_file
    @asset = Asset.find_by!(user: @user, original_filename: params[:filename])
    redirect_to @asset.file_url
  end

  private

  def set_user
    @user = User.friendly.find(params[:user_name])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_entry
    entries = @user.entries.friendly
    entries = entries.published unless current_user
    @entry = entries.find(params[:slug])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def entry_params
    params.fetch(:entry, {}).permit(
      :draft,
      :category_id,
      :tag_list,
      :title,
      :headline,
      :body,
      :image,
      :remove_image
    )
  end

  def ensure_author
    raise '許可されていない操作です' if @user != current_user
  end
end
