# frozen_string_literal: true

class Suggestion < ApplicationRecord
  belongs_to :user, foreign_key: :user_uid, primary_key: :uid
  belongs_to :type_event, foreign_key: :type_event_uid, primary_key: :uid

  scope :type_event_hot, -> (uid) {  Suggestion.where(user_uid: uid).group(:type_event_uid).order("count_uid desc").count(:uid).keys[0..2] }
end
