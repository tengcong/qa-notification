def major_with_courses_generator
  major = Major.new :name => "IT"
  courses_with_questions_generator major
  major
end

def generate_courses_with_questions_for user
  math = Course.create :name => "math"
  english = Course.create :name => "english"

  someone = User.create :name => "someone", :role => "student"
  user.asked_questions = questions_generator someone, [math, english]
  user.courses = [english, math]
end

def courses_with_questions_generator major
  math = Course.new :name => "math"
  english = Course.new :name => "english"

  questions_generator User.new, [math, english]
  major.courses = [math, english]
end

def questions_generator who, courses
  mq1 = who.asked_questions.build :title => "mq1", :content => "cccc"
  mq2 = who.asked_questions.build :title => "mq2", :content => "bbb"
  eq1 = who.asked_questions.build :title => "eq1", :content => "xxx"


  courses.select{|course| course.name == "math"}.first.questions = [mq1, mq2]
  courses.select{|course| course.name == "english"}.first.questions = [eq1]

  answers_generator mq1
  answers_generator eq1

  [mq1, mq2, eq1].map &:save

  [mq1, mq2, eq1]
end

def answers_generator question
  tom = User.create :name => 'tom', :role =>'teacher'
  a1 = tom.answers.build :content => "#{question.title} answer 1 content"
  a2 = tom.answers.build :content => "#{question.title} answer 2 content"

  a1.save; a2.save
  question.answers << a1
  question.answers << a2

  notice_generator a1, tom, question.user
  notice_generator a2, tom, question.user
end

def notice_generator answer, sender, receiver
  answer.create_related_notice
end
