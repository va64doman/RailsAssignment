class ChangeCourseColumn < ActiveRecord::Migration[5.0]
	def self.up
  		rename_column :courses, :type, :course_type
	end

	def self.down
		rename_column :courses, :course_type, :study
	end
end
