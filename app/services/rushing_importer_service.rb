class RushingImporterService

  def import(rushings_data)
    rushings_data.each do |rushing|
      begin
        Rushing.create!(
          map_to_params(rushing)
        )
      rescue ActiveRecord::RecordInvalid => e
        puts "An error occured while importing data: #{e.message}"
      end
    end
  end

  def map_to_params(rushing_data)
    {
      player_name: rushing_data['Player'],
      team: rushing_data['Team'],
      position: rushing_data['Pos'],
      attempts: rushing_data['Att'],
      attempts_per_game_avg: rushing_data['Att/G'],
      yards: clean_yards_data(rushing_data['Yds']),
      yards_per_game_avg: rushing_data['Yds/G'],
      yards_per_attempt_avg: rushing_data['Avg'],
      touchdowns: rushing_data['TD'],
      longuest: rushing_data['Lng'],
      first_downs: rushing_data['1st'],
      first_downs_pct: rushing_data['1st%'],
      twenty_plus: rushing_data['20+'],
      fourty_plus: rushing_data['40+'],
      fumbles: rushing_data['FUM']
    }
  end

  private

  # Yards data is sometimes an integer, sometimes a string.
  # When a string, it's in US format with comma thousands
  # delimiter.
  def clean_yards_data(yards_data)
    yards_data.is_a?(String) ? yards_data.delete(',').to_i : yards_data
  end
end