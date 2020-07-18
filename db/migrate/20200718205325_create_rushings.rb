class CreateRushings < ActiveRecord::Migration[6.0]
  def change
    create_table :rushings do |t|
      t.string :player_name
      t.string :team
      t.string :position
      t.integer :attempts
      t.decimal :attempts_per_game_avg
      t.integer :yards
      t.decimal :yards_per_game_avg
      t.decimal :yards_per_attempt_avg
      t.integer :touchdowns
      t.string :longuest
      t.integer :first_downs
      t.decimal :first_downs_pct
      t.integer :twenty_plus
      t.integer :fourty_plus
      t.integer :fumbles
    end
  end
end
