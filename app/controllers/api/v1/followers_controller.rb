class Api::V1::FollowersController < ApplicationController
  before_action :find_followed_status, only: :follow_and_unfollow
  def follow_and_unfollow
    Follow.create(follower_id: current_user.id, followed_user_id: params[:followed_user_id] )
    render json: {message: "You are following user: #{params[:followed_user_id]}"}
  end

  private

  def find_followed_status
    user = current_user.followings.find_by(id: params[:followed_user_id])
    if user.present?
      Follow.where(follower_id: current_user.id, followed_user_id: user.id).first.destroy if user.present?
      return render json: {message: "You are unfollowing user: #{params[:followed_user_id]}"}
    end
  end

end
