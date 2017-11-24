class AddReviewsToProduct < ActiveRecord::Migration[5.1]
  def change
    add_reference :products, :review, index: true
    add_foreign_key :products, :reviews
  end
end
