module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :rushings, Types::RushingType.connection_type, null: false do
      argument :sort_by, String, required: false
      argument :sort_desc, Boolean, required: false
      argument :name_filter, String, required: false
    end

    def rushings(sort_by: 'yards', sort_desc: 'true', name_filter:)
      rushings = Rushing.all
      rushings = rushings.where("player_name LIKE ?", "%#{name_filter}%") if name_filter
      rushings.order("#{sort_by} #{sort_desc ? 'DESC' : 'ASC'}")
    end
  end
end
