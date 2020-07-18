require 'rails_helper.rb'

RSpec.describe RushingImporterService do

  it "build the right params" do
    json_data = {
        "Player" => "LeGarrette Blount",
        "Team" => "NE",
        "Pos" => "RB",
        "Att" => 299,
        "Att/G" => 18.7,
        "Yds" => "1,161",
        "Avg" => 3.9,
        "Yds/G" => 72.6,
        "TD" => 18,
        "Lng" => "44",
        "1st" => 67,
        "1st%" => 22.4,
        "20+" => 7,
        "40+" => 3,
        "FUM" => 2
      }

    expected_param = {
      "player_name": "LeGarrette Blount",
      "team": "NE",
      "position": "RB",
      "attempts": 299,
      "attempts_per_game_avg": 0.187e2,
      "yards": 1161,
      "yards_per_game_avg": 0.726e2,
      "yards_per_attempt_avg": 0.39e1,
      "touchdowns": 18,
      "longuest": "44",
      "first_downs": 67,
      "first_downs_pct": 0.224e2,
      "twenty_plus": 7,
      "fourty_plus": 3,
      "fumbles": 2
    }
    expect(subject.map_to_params(json_data)).to eq(expected_param)
  end

  it "create the record" do
    json_string = <<-JSON
    [
      {
        "Player":"Joe Banyard",
        "Team":"JAX",
        "Pos":"RB",
        "Att":2,
        "Att/G":2,
        "Yds":7,
        "Avg":3.5,
        "Yds/G":7,
        "TD":0,
        "Lng":"7",
        "1st":0,
        "1st%":0,
        "20+":0,
        "40+":0,
        "FUM":0
      },
      {
        "Player":"Shaun Hill",
        "Team":"MIN",
        "Pos":"QB",
        "Att":5,
        "Att/G":1.7,
        "Yds":5,
        "Avg":1,
        "Yds/G":1.7,
        "TD":0,
        "Lng":"9",
        "1st":0,
        "1st%":0,
        "20+":0,
        "40+":0,
        "FUM":0
      }
    ]
    JSON
    expect { subject.import(JSON.parse(json_string)) }.to change { Rushing.count }.by(2)
  end
end