class CreateRecommendations < ActiveRecord::Migration[7.0]
  def change
    create_table :recommendations do |t|
      t.text :text
      t.references :consultation_request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
