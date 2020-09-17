require './item.rb'

class List
    attr_accessor :label
    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, deadline, description="")
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

    def priority
        @items.first
    end

    def print
        puts "------------------------------------------"
        puts "                 GROCERIES"
        puts "------------------------------------------"
        puts "#{"Index".ljust(6)}| #{"Item".ljust(20)}| Deadline"
        puts "------------------------------------------"
        (0...self.size).each { |i| puts "#{i.to_s.ljust(6)}| #{self[i].title.ljust(20)}| #{self[i].deadline}"}
        puts "------------------------------------------"
    end
    
    def print_full_item(index)
        puts "------------------------------------------"
        item = self[index]
        puts "#{item.title.ljust(20)} #{item.deadline}"
        puts "#{item.description}"
        puts "------------------------------------------"
    end

    def print_priority
        print_full_item(0)
    end
end