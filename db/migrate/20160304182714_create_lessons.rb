class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|

      t.string :title
      t.string :subtitle

      t.integer :section_id
      t.timestamps

      t.timestamps
    end
  end
end
