class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :google_id

      t.timestamps null: false
    end
  end
end
