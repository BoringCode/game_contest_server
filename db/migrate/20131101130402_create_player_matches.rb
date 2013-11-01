class CreatePlayerMatches < ActiveRecord::Migration
  def change
    create_table :player_matches do |t|
      t.float :score
      t.string :result
      t.references :player
      t.references :match
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
