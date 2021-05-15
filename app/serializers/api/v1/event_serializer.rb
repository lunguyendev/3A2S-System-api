# frozen_string_literal: true

class Api::V1::EventSerializer < ActiveModel::Serializer
  attributes \
    :uid,
    :event_name,
    :avatar,
    :type_event,
    :size,
    :organization,
    :description,
    :location,
    :status,
    :start_at,
    :end_at

  belongs_to :user, serializer: Api::V1::UserSerializer
  has_one :template_feedback, serializer: Api::V1::TemplateFeedbackSerializer

  attribute :creator_event
  attribute :join_event
  attribute :count_join_event

  def initialize(object, options = {})
    @current_user = options[:current_user]
    super
  end

  def creator_event
    return unless @current_user

    {
      is_creator: (object.user_uid === @current_user.uid),
      is_qr_code: object.token.present?,
      qr_code_string: object.token&.qr_code_string
    }
  end

  def join_event
    return unless @current_user

    join_event = @current_user.take_part_in_events.find_by(event_uid: object.uid)
    {
      uid: join_event&.uid,
      is_join_event: join_event.present?
    }
  end

  def count_join_event
    TakePartInEvent.where(event_uid: object.uid).count
  end
end
