
class TestimoniesController < ApplicationController
    include HTTParty
    format :json

    before_action :setCurrentTestimony
    before_action :setCurrentUser

    def index
        @testimonies = Testimony.order('created_at DESC')
        @user = User.find_by_id(params[:id])
        render :index
    end

    def show
        @comment = Comment.find_by_id(params[:id])
          @testimony = Testimony.find_by_id(params[:id])
        render :show
    end

    def new
        if !params[:search].nil?
            @search = params[:search]
            # Use interpulation on refactor
            @testimonies = HTTParty.get('https://api.biblia.com/v1/bible/search/LEB.js?query=' + @search + '&mode=verse&start=0&limit=50&key=5f2273dfa89f32a2232474c83fac3921')
        else
            @testimonies = HTTParty.get('https://api.biblia.com/v1/bible/search/LEB.js?query=jesus&mode=verse&start=0&limit=50&key=5f2273dfa89f32a2232474c83fac3921')
        end
        @testimony = Testimony.new
    end

    def create
        @testimony = Testimony.new(testimony_params)
        @testimony.title = params[:testimony][:title]
        @testimony.verse = params[:testimony][:verse]
        @testimony.user_id = params[:testimony][:user_id]
        if @testimony.save
        redirect_to testimony_path(@testimony.id)
        else
            flash.now[:error] = @testimony.errors.full_messages.join(' , ')
            render :new
        end
    end

    def edit
      logged_in?(@testimony.user_id)
      @testimony = Testimony.find_by_id(params[:id])
    end

    def update
      if allowed?(@testimony.user_id)
      if @testimony.update(testimony_params)
        redirect_to testimony_path
      else
        flash[:error] = @testimony.errors.full_messages.join(" , ")
        render :edit
      end
    else
      redirect_to testimony_path
      end
    end

    def destroy
        @testimony = Testimony.find_by_id(params[:id])
        user_id = @testimony.user_id
        if allowed?(user_id)
            @testimony.destroy
            flash[:notice] = 'Testimony successfully deleted'
            redirect_to user_path(user_id)
        else
            flash[:error] = 'You dont have the proper cridentials to delete this post'
            redirect_to index_testimony_path
        end
    end

    private

    def testimony_params
    params.require(:testimony).permit(:title, :verse, :user_id, :picture, :video, :message)
    end

    def setCurrentTestimony
      @testimony = Testimony.find_by_id(params[:id])
    end

    def setCurrentUser
      @user = current_user
    end

end
