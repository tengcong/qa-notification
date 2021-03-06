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

  # user asked questions
  has_many :asked_questions, :class_name => "Question", :inverse_of => :user
  has_and_belongs_to_many :courses

  # for students
  belongs_to :major
  belongs_to :department

  ##
  has_many :answers
  has_many :notices, :inverse_of => :receiver

  validates_uniqueness_of :email

  after_save :set_courses

  ROLE = ["student", "teacher", "admin"]

  mount_uploader :avatar, AvatarUploader

  def set_major major_id
    self.major = Major.find major_id
  end

  def set_department
    self.department = self.major.department
  end

  def set_courses
    self.courses = self.major.courses if self.major
  end

  def set_self_info major_id
    set_major major_id
    set_department
    set_courses
    save
  end

  def get_my_students
    User.where(:major_id => self.major_id, :role => ROLE[0])
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

  def clear_notices
    self.notices.map(&:readed)
  end

  def list_questions_notices
    notices.where(:notice_type => 'question').map(&:find_ref_object)
  end

  # def is_student?
  # def is_admin?
  # def is_teacher?
  ROLE.each do |role|
    define_method "is_#{role}?" do
      self.role == role
    end
  end

  def set_role new_role
    return unless ROLE.include?(new_role)
    if new_role == ROLE[1]
      self.role = "to_be_teacher"
    else
      self.role = new_role
    end
    self.save
  end

  def confirm_teacher
    self.role = ROLE[1]
    save
  end

  def confirm_student
    self.role = ROLE[0]
    save
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

