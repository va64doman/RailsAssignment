class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
    	t.string :name
    	t.string :info
    	t.string :description
    	t.string :subject
    	t.string :type

    	t.timestamps
    end
  end
end
