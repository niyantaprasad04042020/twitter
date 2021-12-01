class TweetsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update retweet destroy]
  before_action :set_tweet, only: %i[ show edit update retweet destroy ]

  # GET /tweets or /tweets.json
  def index
    @tweets = Tweet.all
  end

  # GET /tweets/1 or /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    create_tweet_params = tweet_params
    create_tweet_params[:created_at] = Date.current.to_time.to_datetime
    @tweet = current_user.tweets.new(create_tweet_params)
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    update_tweet_params = tweet_params
    update_tweet_params[:created_at] = @tweet.created_at
    update_tweet_params[:updated_at] = Date.current.to_time.to_datetime
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    @tweets = Tweet.any_of({description: /#{params[:search_term]}/}).entries
  end

  def retweet
    retweet_params = {description: @tweet.description, created_at: @tweet.created_at, updated_at: @tweet.updated_at}
    @tweet         = current_user.tweets.new(retweet_params)
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:description, :created_at, :updated_at, :user_id, :search_term)
    end
end
