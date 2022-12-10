class CreateTechnicalReports < ActiveRecord::Migration[7.0]
  def change
    create_table :technical_reports do |t|
      t.string :name
      t.string :device
      t.string :defect
      t.string :description

      t.timestamps
    end
  end
end
