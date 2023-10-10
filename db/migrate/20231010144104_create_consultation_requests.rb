class CreateConsultationRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :consultation_requests do |t|
      t.text :text
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
