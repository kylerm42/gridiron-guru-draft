class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string     :name,              null: false
      t.references :manager,           null: false, index: true
      t.integer    :number_of_teams,   null: false, default: 10
      t.string     :password_digest,   null: false

      t.timestamps
    end

    add_index :leagues, :name
  end
end
