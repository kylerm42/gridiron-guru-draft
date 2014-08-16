class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string   :first_name,    null: false
      t.string   :last_name,     null: false
      t.string   :position,      null: false
      t.string   :team,          null: false, default: 'FA'
      t.date     :birthdate
      t.string   :college
      t.string   :height
      t.integer  :weight
      t.integer  :years_pro
      t.integer  :profile_id
      t.string   :gsis_id
      t.integer  :rank

      t.integer  :pass_yards,    default: 0
      t.integer  :pass_tds,      default: 0
      t.integer  :pass_ints,     default: 0
      t.integer  :rush_att,      default: 0
      t.integer  :rush_yards,    default: 0
      t.integer  :rush_tds,      default: 0
      t.integer  :receptions,    default: 0
      t.integer  :rec_yards,     default: 0
      t.integer  :rec_tds,       default: 0
      t.integer  :fumbles,       default: 0
      t.integer  :pass_2_pt,     default: 0
      t.integer  :rush_2_pt,     default: 0
      t.integer  :rec_2_pt,      default: 0

      t.integer  :fg_made_yards, default: 0
      t.integer  :fg_miss_yards, default: 0
      t.integer  :made_pat,      default: 0
      t.integer  :miss_pat,      default: 0
      t.integer  :made_0_19,     default: 0
      t.integer  :miss_0_19,     default: 0
      t.integer  :made_20_29,    default: 0
      t.integer  :miss_20_29,    default: 0
      t.integer  :made_30_39,    default: 0
      t.integer  :miss_30_39,    default: 0
      t.integer  :made_40_49,    default: 0
      t.integer  :miss_40_49,    default: 0
      t.integer  :made_50_plus,  default: 0
      t.integer  :miss_50_plus,  default: 0

      t.integer  :sacks,         default: 0
      t.integer  :interceptions, default: 0
      t.integer  :fum_rec,       default: 0
      t.integer  :safeties,      default: 0
      t.integer  :def_tds,       default: 0
      t.integer  :return_tds,    default: 0
      t.integer  :sacks,         default: 0
      t.integer  :pts_allowed,   default: 0

      t.timestamps
    end

    add_index :players, :position
    add_index :players, [:last_name, :first_name]
    add_index :players, :team
  end
end
