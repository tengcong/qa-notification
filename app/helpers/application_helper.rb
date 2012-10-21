module ApplicationHelper
    def get_departments
        @departments=Department.all
    end
end
