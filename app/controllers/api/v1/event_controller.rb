# frozen_string_literal: true

class Api::V1::EventController < ApplicationController
  def index
    event = Api::Event::FilterEvent.new(
      {
        type: params[:type],
        user: @current_user
      }
    ).execute

    @collection_event = Kaminari.paginate_array(event).page(params[:page]).per(params[:size_page] || 10)

    event_serializable = ActiveModelSerializers::SerializableResource.new(
      @collection_event,
      each_serializer: Api::V1::EventSerializer,
      current_user: @current_user
    )

    response_hash = {
      data: event_serializable,
      total_page: @collection_event.total_pages,
      current_page: @collection_event.current_page,
      total_count: event.count
    }

    render json: response_hash
  end

  def list
    event = Event.accept.organizing.created_at_desc
    @collection_event = Kaminari.paginate_array(event).page(params[:page]).per(params[:size_page] || 10)

    event_serializable = ActiveModelSerializers::SerializableResource.new(
      @collection_event,
      each_serializer: Api::V1::EventSerializer,
      current_user: @current_user
    )

    response_hash = {
      data: event_serializable,
      total_page: @collection_event.total_pages,
      current_page: @collection_event.current_page,
      total_count: event.count
    }

    render json: response_hash
  end

  def show
    event = Event.find(params[:uid])

    render json: event, serializer: Api::V1::EventSerializer, current_user: @current_user
  end

  def joined_event
    events = Event.joined_event(events_join).order("end_at DESC")

    @collection_event = Kaminari.paginate_array(events).page(params[:page]).per(params[:size_page] || 10)

    event_serializable = ActiveModelSerializers::SerializableResource.new(
      @collection_event,
      each_serializer: Api::V1::EventSerializer,
      current_user: @current_user
    )

    response_hash = {
      data: event_serializable,
      total_page: @collection_event.total_pages,
      current_page: @collection_event.current_page,
      total_count: events.count
    }

    render json: response_hash
  end

  def get_type_event
    type = TypeEvent.all
    render json: { type_event: type }
  end

  def update
    if target_event.pending? && @current_user.uid == target_event.user_uid ||
      @current_user.admin? || @current_user.approval?
      target_event.update!(params_event_update)
      return head :accepted
    end

    raise Errors::ExceptionHandler::PermissionDenied, I18n.t("errors.permission_denied")
  end

  def destroy
    if target_event.pending? && @current_user.uid == target_event.user_uid ||
      @current_user.admin? || @current_user.approval?
      target_event.destroy!
      return head :accepted
    end

    raise Errors::ExceptionHandler::PermissionDenied, I18n.t("errors.permission_denied")
  end

  def search_name_basic
    events = Event.accept.where("event_name LIKE ?", "%#{ params[:search] }%").created_at_desc

    @collection_event = Kaminari.paginate_array(events).page(params[:page]).per(10)

    event_serializable = ActiveModelSerializers::SerializableResource.new(
      @collection_event,
      each_serializer: Api::V1::EventSerializer,
      current_user: @current_user
    )

    response_hash = {
      data: event_serializable,
      total_page: @collection_event.total_pages,
      current_page: @collection_event.current_page,
      total_count: events.count
    }

    render json: response_hash
  end

  def search_name
    if @current_user.admin? || @current_user.approval?
      events = Event.where("event_name LIKE ? AND status = ?", "%#{ params[:search] }%", params[:status]).created_at_desc
    else
      events = @current_user.events.where("event_name LIKE ? AND status = ?", "%#{ params[:search] }%", params[:status]).created_at_desc
    end

    @collection_event = Kaminari.paginate_array(events).page(params[:page]).per(10)

    event_serializable = ActiveModelSerializers::SerializableResource.new(
      @collection_event,
      each_serializer: Api::V1::EventSerializer,
      current_user: @current_user
    )

    response_hash = {
      data: event_serializable,
      total_page: @collection_event.total_pages,
      current_page: @collection_event.current_page,
      total_count: events.count
    }

    render json: response_hash
  end

  def event_comming
    events = Event.events_by_day(date_param[:start_at], date_param[:end_at])

    render json: events, each_serializer: Api::V1::EventSerializer
  end

  def quality_event
    data = Api::Event::Statistics::HotEvent.new.all_event

    render json: data
  end

  private
    def events_join
      @current_user.take_part_in_events.pluck(:event_uid)
    end

    def target_event
      @event ||= Event.find(params[:uid])
    end

    def params_event_update
      params.require(:event).permit(
        :event_name,
        :avatar,
        :is_online,
        :size,
        :organization,
        :description,
        :location,
        :start_at,
        :scope,
        :end_at,
        type_event_uids: []
      )
    end

    def date_param
      params.require(:date)
            .permit(:start_at, :end_at)
    end
end
