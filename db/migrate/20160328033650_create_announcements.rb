class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :title
      t.string :content
      t.timestamps null: false
      t.string :committee_type
    end
  end
end
