#encoding: utf-8
module InitHelper
  extend self
  def run
    Course.destroy_all
    Major.destroy_all
    Department.destroy_all

    gaoshu = Course.create :name => "高数"
    yingyu = Course.create :name => "英语"
    dianlu = Course.create :name => "电路"

    wulihuaxue = Course.create :name => "物理化学"
    yingyonghuaxue = Course.create :name => "应用化学"
    fenxihuaxue = Course.create :name => "分析化学"

    yingyong = Major.create :name => "计算机科学与技术应用"
    waibao = Major.create :name => "计算机科学与技术软件外包"

    yaoxue = Major.create :name => "药学"

    yingyong.courses = [gaoshu, yingyu, dianlu]
    waibao.courses = [gaoshu, yingyu]
    yaoxue.courses = [wulihuaxue, yingyonghuaxue, fenxihuaxue]

    info = Department.create :name => "信息工程学院"
    yaoxueyuan = Department.create :name => "药学院"

    info.majors = [yingyong, waibao]
    yaoxueyuan.majors = [yaoxue]

    yingyong.save
    waibao.save
    yaoxue.save
    info.save
    yaoxueyuan.save
  end
end
