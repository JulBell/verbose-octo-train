module Types
  class RushingType < Types::BaseObject
    field :id, ID, null: false
    field :player_name, String, null: false
    field :team, String, null: false
    field :position, String, null: false
    field :attempts, String, null: false
    field :attempts_per_game_avg, String, null: false
    field :yards, String, null: false
    field :yards_per_game_avg, String, null: false
    field :yards_per_attempt_avg, String, null: false
    field :touchdowns, String, null: false
    field :longuest, String, null: false
    field :first_downs, String, null: false
    field :first_downs_pct, String, null: false
    field :twenty_plus, String, null: false
    field :fourty_plus, String, null: false
    field :fumbles, String, null: false
  end
end