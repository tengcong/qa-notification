class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,       :type => String
  field :content,     :type => String
  field :click_rate, :type => Integer, :default => 0

  has_many :answers
  belongs_to :course
  belongs_to :user

  scope :sorted, desc(:updated_at)

  def self.hot_question
    self.desc("click_rate").limit(5).to_a
  end

  def self.search_questions query
    query.strip!
    unless query.empty?
      terms =  query.split.join('|')
      Question.where('$or' => [{:title => /#{terms}/i}, {:content => /#{terms}/i}])
    else
      []
    end
  end

  def incr_visitation
    self.click_rate += 1
    save
  end

  def teachers
    course.majors.inject([]){ |result, m| result |= m.users.select{ |u| u.is_teacher? }; result }
  end

  def notice_to_course_major_teacher
    notices = create_question_notice(self.user, teachers)
  end

  def create_question_notice sender, receivers
    notice_attr = { :notice_type => "question",
      :content => self.content,
      :ref_id => self.id
    }

    receivers.each do |recevier|
      notice = Notice.generate_notice notice_attr, sender, recevier
      notice.save
      recevier.add_new_notice(notice)
    end
  end

end
