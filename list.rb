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

    def size
        return @items.size
    end

    def valid_index?(index)
        return index >= 0 && index < self.size
    end
    
    def swap(index_1, index_2)
        return false if !self.valid_index?(index_1) || !self.valid_index?(index_2)
        @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
        return true
    end

    def [](index)
        return nil if !self.valid_index?(index)
        return @items[index]
    end
end