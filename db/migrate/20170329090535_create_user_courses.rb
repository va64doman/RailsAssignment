class CreateUserCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :user_courses do |t|
    	t.references :users, index: true, foreign_key: true
    	t.references :courses, index: true, foreign_key: true
    end
  end
end
