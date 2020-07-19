module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :rushings, Types::RushingType.connection_type, null: false do
      argument :order_by, String, required: false
      argument :order, String, required: false
    end

    def rushings(order_by: 'yards', order: 'desc')
      Rushing.all.order("#{order_by} #{order.upcase}")
    end
  end
end
