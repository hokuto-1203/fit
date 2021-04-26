class CreateCalendarItems < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_items do |t|
      t.references :calendar, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
