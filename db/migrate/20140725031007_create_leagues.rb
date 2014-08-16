class CreateLeagues < ActiveRecord::Migration
  def change
    enable_extension 'hstore'
    
    create_table :leagues do |t|
      t.string     :name,              null: false
      t.string     :tagline
      t.references :manager,           null: false, index: true
      t.integer    :number_of_teams,   null: false, default: 10
      t.string     :password_digest,   null: false
      t.string     :activation_key,    null: false
      t.hstore     :positions,         null: false

      t.timestamps
    end

    add_index :leagues, :name
  end
end
