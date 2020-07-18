# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_18_205325) do

  create_table "rushings", force: :cascade do |t|
    t.string "player_name"
    t.string "team"
    t.string "position"
    t.integer "attempts"
    t.decimal "attempts_per_game_avg"
    t.integer "yards"
    t.decimal "yards_per_game_avg"
    t.decimal "yards_per_attempt_avg"
    t.integer "touchdowns"
    t.string "longuest"
    t.integer "first_downs"
    t.decimal "first_downs_pct"
    t.integer "twenty_plus"
    t.integer "fourty_plus"
    t.integer "fumbles"
  end

end
