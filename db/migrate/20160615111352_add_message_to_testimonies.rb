class AddMessageToTestimonies < ActiveRecord::Migration
  def change
    add_column :testimonies, :message, :text
  end
end
