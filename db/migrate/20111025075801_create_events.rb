class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text        :serialized, :null => false
      t.boolean     :successful, :default => false, :null => false
      t.timestamps
    end
  end
end
