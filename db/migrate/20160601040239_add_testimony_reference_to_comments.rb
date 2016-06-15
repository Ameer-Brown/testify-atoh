class AddTestimonyReferenceToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :testimony, index: true, foreign_key: true
  end
end
