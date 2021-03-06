class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find_by(id: params[:id])
    @venues = @group.passport.venues
    @users = @group.users
    @up = UserPassport.where(passport_id: @group.passport_id)
    @visits = YelpVenue.up_visits_group(@up)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      UserPassport.group_created(group_params)
      flash[:success] = "#{@group.name} Group Created!"
      redirect_to user_dashboard_path
    else
      flash[:danger] = @group.errors.full_messages.join(" ")
      redirect_to :back
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, :passport_id, :user_id)
  end
end
