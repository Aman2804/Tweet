class Api::V1::TweetController < ApplicationController
  before_action :find_tweet, only: [:destroy, :show, :update]
  def index
    tweets = current_user.tweets
    render json: {status: :success, tweets: "There is tweet found for you"} if tweets.empty?
    render json: { status: :success, tweets: tweets }
  end

  def create
    tweet = current_user.tweets.build(tweet_params)
    render json: {error: "Tweet is not created"} unless tweet.save
    render json: {tweet: return_formate(tweet) }
  end

  def show
    render json: {status: :success, tweet: return_formate(@tweet) }
  end

  def update
    render json: { error: "Something went wrong, tweet is updated yet" } unless @tweet.update(tweet_params)
    render json: { status: :success, tweet: return_formate(@tweet) }
  end

  def destroy
    @tweet.destroy
    render json: { status: :success, message: "Tweet is deleted" }
  end

  def All_tweet_of_followed_user
    user_and_tweets = Array.new
    current_user.followings.each{|user| user_and_tweets << {user: user.id, tweets: user.tweets} }
    render json: {status: :success, tweets: user_and_tweets}
  end

  def tweet_of_user
    user = User.find_by_id(params[:id])
    return render json: { status: :success, tweets: user.tweets } if user.present?
    render json: { error: "Invalid ID"}
  end

  private

  def tweet_params
    params.require(:tweet).permit(:text)
  end

  def return_formate tweet
    { id: tweet.id, tweet: tweet.text }
  end

  def find_tweet
    @tweet = Tweet.find_by_id(params[:id])
    return render json: { error: "Id is invalid" } unless @tweet.present?
  end

end
