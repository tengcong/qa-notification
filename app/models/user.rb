class User
  include Mongoid::Document

  # we should comment the validatable module
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  field :email,              :type => String, :null => false, :default => ""
  field :encrypted_password, :type => String, :null => false, :default => ""

  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  field :remember_created_at, :type => Time

  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  field :name, type: String
  field :role, type: String, :default => "student"

  has_many :asked_questions, :class_name => "Question", :inverse_of => :user
  has_and_belongs_to_many :courses

  # for students
  belongs_to :major
  belongs_to :department
  ##
  has_many :answers
  has_many :notices, :inverse_of => :receiver

  validates_uniqueness_of :email

  mount_uploader :avatar, AvatarUploader

  def set_major major_id
    self.major = Major.find major_id
  end

  def set_department
    self.department = self.major.department
  end

  def set_courses
    self.courses = self.major.courses
  end

  def set_self_info major_id
    set_major major_id
    set_department
    set_courses
    save
  end

  def lastest_question_of_my_courses
    desc_list_by_updated_at courses.map(&:questions).flatten
  end

  def add_asked_questions question
    self.asked_questions << question
    save
  end

  def add_new_notice notice
    self.notices << notice
    save
  end

  def list_questions_notices
    notices.where(:notice_type => 'question').map(&:find_ref_object)
  end

  def is_student?
    role == "student"
  end

  def get_major
    if is_student?
      major
    else
      nil
    end
  end

  def get_department
    if is_student?
      department
    else
      nil
    end
  end

end

