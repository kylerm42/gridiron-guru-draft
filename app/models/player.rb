# == Schema Information
#
# Table name: players
#
#  id            :integer          not null, primary key
#  first_name    :string(255)      not null
#  last_name     :string(255)      not null
#  position      :string(255)      not null
#  team          :string(255)      default("FA"), not null
#  birthdate     :date
#  college       :string(255)
#  height        :string(255)
#  weight        :integer
#  years_pro     :integer
#  profile_id    :integer
#  gsis_id       :string(255)
#  rank          :integer
#  pass_yards    :integer          default(0)
#  pass_tds      :integer          default(0)
#  pass_ints     :integer          default(0)
#  rush_att      :integer          default(0)
#  rush_yards    :integer          default(0)
#  rush_tds      :integer          default(0)
#  receptions    :integer          default(0)
#  rec_yards     :integer          default(0)
#  rec_tds       :integer          default(0)
#  fumbles       :integer          default(0)
#  pass_2_pt     :integer          default(0)
#  rush_2_pt     :integer          default(0)
#  rec_2_pt      :integer          default(0)
#  fg_made_yards :integer          default(0)
#  fg_miss_yards :integer          default(0)
#  made_pat      :integer          default(0)
#  miss_pat      :integer          default(0)
#  made_0_19     :integer          default(0)
#  miss_0_19     :integer          default(0)
#  made_20_29    :integer          default(0)
#  miss_20_29    :integer          default(0)
#  made_30_39    :integer          default(0)
#  miss_30_39    :integer          default(0)
#  made_40_49    :integer          default(0)
#  miss_40_49    :integer          default(0)
#  made_50_plus  :integer          default(0)
#  miss_50_plus  :integer          default(0)
#  sacks         :integer          default(0)
#  interceptions :integer          default(0)
#  fum_rec       :integer          default(0)
#  safeties      :integer          default(0)
#  def_tds       :integer          default(0)
#  return_tds    :integer          default(0)
#  pts_allowed   :integer          default(0)
#  created_at    :datetime
#  updated_at    :datetime
#

class Player < ActiveRecord::Base

  # Constants
  POSITIONS = ["QB", "RB", "WR", "TE", "K", "DEF"]

  TEAMS = {
    "FA"  => ["Free",          "Agent"],
    "DAL" => ["Dallas",        "Cowboys"],
    "PHI" => ["Philadelphia",  "Eagles"],
    "NYG" => ["New York",      "Giants"],
    "WAS" => ["Washington",    "Redskins"],
    "TB"  => ["Tampa Bay",     "Buccaneers"],
    "ATL" => ["Atlanta",       "Falcons"],
    "CAR" => ["Carolina",      "Panthers"],
    "NO"  => ["New Orleans",   "Saints"],
    "CHI" => ["Chicago",       "Bears"],
    "DET" => ["Detroit",       "Lions"],
    "GB"  => ["Green Bay",     "Packers"],
    "MIN" => ["Minnesota",     "Vikings"],
    "SF"  => ["San Francisco", "49ers"],
    "ARI" => ["Arizona",       "Cardinals"],
    "STL" => ["St. Louis",     "Rams"],
    "SEA" => ["Seattle",       "Seahawks"],
    "BUF" => ["Buffalo",       "Bills"],
    "MIA" => ["Miami",         "Dolphins"],
    "NYJ" => ["New York",      "Jets"],
    "NE"  => ["New England",   "Patriots"],
    "IND" => ["Indianapolis",  "Colts"],
    "JAX" => ["Jacksonville",  "Jaguars"],
    "HOU" => ["Houston",       "Texans"],
    "TEN" => ["Tennessee",     "Titans"],
    "CIN" => ["Cincinnati",    "Bengals"],
    "CLE" => ["Cleveland",     "Browns"],
    "BAL" => ["Baltimore",     "Ravens"],
    "PIT" => ["Pittsburgh",    "Steelers"],
    "DEN" => ["Denver",        "Broncos"],
    "SD"  => ["San Diego",     "Chargers"],
    "KC"  => ["Kansas City",   "Chiefs"],
    "OAK" => ["Oakland",       "Raiders"]
  }

  # Validations
  validates :first_name, :last_name, :position, :team, presence: true
  validates :position, inclusion: { in: POSITIONS }
  validates :team, inclusion: { in: TEAMS.keys }

  # Associations
  has_many :draft_picks
  has_many :teams,
           through: :draft_picks,
           source:  :team
  has_many :leagues,
           through: :teams,
           source:  :league
end
