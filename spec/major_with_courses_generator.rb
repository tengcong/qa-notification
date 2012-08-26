def major_with_courses_generator
  major = Major.new :name => "IT"
  courses_with_questions_generator major
  major
end

def generate_courses_with_questions_for user
  math = Course.new :name => "math"
  english = Course.new :name => "english"

  questions_generator math, english
  user.courses = [english, math]
end

def courses_with_questions_generator major
  math = Course.new :name => "math"
  english = Course.new :name => "english"

  questions_generator math, english
  major.courses = [math, english]
end

def questions_generator *courses
  mq1 = Question.new :title => "mq1", :content => "cccc"
  mq2 = Question.new :title => "mq2", :content => "bbb"
  eq1 = Question.new :title => "eq1", :content => "xxx"


  courses.select{|course| course.name == "math"}.first.questions = [mq1, mq2]
  courses.select{|course| course.name == "english"}.first.questions = [eq1]

  answers_generator mq1
  answers_generator eq1
end

def answers_generator question
  a1 = Answer.new :content => "#{question.title} answer 1 content"
  a2 = Answer.new :content => "#{question.title} answer 2 content"
  question.answers << a1
  question.answers << a2
end
