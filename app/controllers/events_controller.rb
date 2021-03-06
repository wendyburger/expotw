class EventsController < ApplicationController
	before_action :authorize_user, except:[:index]

	def index
		@events = Event.all
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			redirect_to events_path
		else
			render :new
		end 
	end

	def edit
		@event = Event.find(params[:id])
	end

	def update
		@event = Event.find(params[:id])
		if @event.update(event_params)
			redirect_to events_path
		else
			render :edit
		end
	end

	def destroy
		@event = Event.find(params[:id])
		@event.destroy
		redirect_to events_path
	end

	private

	def authorize_user
		current_user ? true : (redirect_to events_path)
	end

	def event_params
		params.require(:event).permit(:happened_at, :content, :timeline_pic)
	end
end
