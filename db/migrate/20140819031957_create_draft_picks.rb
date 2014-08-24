class CreateDraftPicks < ActiveRecord::Migration
  def change
    create_table :draft_picks do |t|
      t.references :team,   null: false, index: true
      t.references :player, index: true
      t.integer    :round,  null: false

      t.timestamps
    end
  end
end
