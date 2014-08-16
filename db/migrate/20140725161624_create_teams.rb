class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string     :name,            null: false
      t.references :owner,           index: true
      t.references :league,          null: false, index: true
      t.integer    :draft_slot,      null: false
      t.string     :color,           null: false, default: '007DBD'

      t.timestamps
    end

    add_index :teams, [:draft_slot, :league_id]
  end
end
