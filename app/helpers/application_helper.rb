module ApplicationHelper
    def get_departments
        @departments=Department.all
    end

    def get_majors
        @majors=Major.all
    end
end
