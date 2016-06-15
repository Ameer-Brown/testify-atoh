class CreateTestimonies < ActiveRecord::Migration
  def change
    create_table :testimonies do |t|
      t.string :title
      t.text :verse
      t.string :picture
      t.string :video

      t.timestamps null: false
    end
  end
end
