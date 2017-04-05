class ChangeCourseTypeColumn < ActiveRecord::Migration[5.0]
  def change
  	rename_column :courses, :course_type, :study
  end
end
