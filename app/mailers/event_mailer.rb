class EventMailer < ApplicationMailer

  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event

    mail to: event.user.email, subject: "Новая подписка на #{event.title}"
  end

  def comment(event, comment, email)
    @comment = comment
    @event = event

    unless usreml(email, event)
      mail to: email, subject: "Новый комментарий @ #{event.title}"
    end
  end

  def photo(event, photo, mail)
    @photo = photo
    @event = event
    mail to: mail, subject: "Новая фотография в @ #{event.title}"
  end

  def usreml(email, event)
    event.user.email == email
  end
end

