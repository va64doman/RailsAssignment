class CreateCourseContents < ActiveRecord::Migration[5.0]
  def change
    create_table :course_contents do |t|
      t.string :name
      t.string :description
      t.references :courses, index: true, foreign_key: true

      t.timestamps
    end
  end
end
