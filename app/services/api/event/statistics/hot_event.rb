# frozen_string_literal: true

class Api::Event::Statistics::HotEvent
  def total_score(event)
    Question.question_answers_is_rating(event.template_feedback.uid).average(:scope).to_f
  end

  def total_feedback(event)
    question_uids = Question.where(template_feedback_uid: event.template_feedback.uid).pluck(:uid)
    Answer.count_feedback(question_uids)
  end

  def all_event
    data = []
    Event.accept.organized.each do |event|
      rating = total_score(event)
      total_feedback = total_feedback(event)
      data << {
        uid: event.uid,
        event: event.event_name,
        avatar: event.avatar,
        rating: rating.round(2),
        total_feedback: total_feedback,
        score: (rating * coefficient(total_feedback)).round(2)
      }
    end
    data.sort_by! { |h| h[:score] }.reverse
  end

  def coefficient(total_feedback)
    case total_feedback
    when 0..10
      1
    when 10..20
      1.2
    when 20..30
      1.3
    when 30..40
      1.4
    when 40..50
      1.5
    when 50..60
      1.6
    when 70..80
      1.7
    when 80..90
      1.8
    when 90..100
      1.9
    else
      2
    end
  end
end
