class AddUserReferenceToTestimonies < ActiveRecord::Migration
  def change
    add_reference :testimonies, :user, index: true, foreign_key: true
  end
end
