class Course
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  has_and_belongs_to_many :majors

  has_many :questions

  has_and_belongs_to_many :users

  attr_accessible :name, :major_id, :department_id

  Q_MAP = """
  function(){
    var value = {}
    emit(this.course_id, {
      click_rate: this.click_rate,
      course_id: this.course_id
    });
  }
  """

  Q_REDUCE = """
  function(key, emits){
    var result = {
      click_rate: 0
    }

    emits.forEach(function(emit){
      result.course_id = emit.course_id;
      result.click_rate += emit.click_rate;
    });
    return result;
  }
  """

  def self.hot_course query = {}
    results = Question.collection.map_reduce(Q_MAP, Q_REDUCE, {
      :query => query,
      :out => {:inline => true},
      :raw => true
    })['results'].map do |e|
      {
        'course_id'  => e["value"]['course_id'],
        'click_rate' => e['value']['click_rate']
      }
    end.select{|e| e['click_rate'] != nil}.sort_by{|e| -e['click_rate']}[0..5].map do |e|
      self.find e['course_id']
    end
  end

end
