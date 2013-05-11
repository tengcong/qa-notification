class ResourcesMailer < ActionMailer::Base
  default from: "teacher@notification.com"

  def send_to_students(from, subject, content)
    @content = content
    mail :from => from.email, :subject => subject, :to => from.get_my_students.map(&:email)
  end

end
