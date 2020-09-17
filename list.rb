require './item.rb'

class List
    attr_accessor :label
    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description)
        return false if !Item.valid_date?(deadline)
        return true if @items << Item.new(title, deadline, description)
    end
end