require './item.rb'

# print styles
LINE_WIDTH = 49
INDEX_COL_WIDTH = 5
ITEM_COL_WIDTH = 20
DEADLINE_COL_WIDTH = 10
CHECKMARK = "\u2713".force_encoding('utf-8') # pretty checkmark

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
        puts "-" * LINE_WIDTH
        puts " " * 16 + self.label.upcase
        puts "-" * LINE_WIDTH
        puts "#{"Index".ljust(INDEX_COL_WIDTH)}| #{"Item".ljust(ITEM_COL_WIDTH)}| #{"Deadline".ljust(DEADLINE_COL_WIDTH)}| Done"
        puts "-" * LINE_WIDTH
        @items.each_with_index do |item, i|
            status = item.done ? CHECKMARK : ' '
            puts "#{i.to_s.ljust(INDEX_COL_WIDTH)}| #{item.title.ljust(ITEM_COL_WIDTH)}| #{item.deadline.ljust(DEADLINE_COL_WIDTH)}| [#{status}]"
        end
        puts "-" * LINE_WIDTH
    end
    
    def print_full_item(index)
        item = self[index]
        return if item.nil?
        status = item.done ? CHECKMARK : ' '
        puts "-" * LINE_WIDTH
        puts "#{item.title.ljust(LINE_WIDTH/2)} #{item.deadline} [#{status}]".rjust(LINE_WIDTH/2)
        puts item.description
        puts "-" * LINE_WIDTH
    end

    def print_priority
        print_full_item(0)
    end

    def up(index, amount=1)
        return false if !self.valid_index?(index)
        tmp_ind = index
        amount.times do ||
            break if tmp_ind == 0
            self.swap(tmp_ind, tmp_ind - 1)
            tmp_ind -= 1
        end
        return true
    end

    def down(index, amount=1)
        return false if !self.valid_index?(index)
        tmp_ind = index
        amount.times do ||
            break if tmp_ind == self.size - 1
            self.swap(tmp_ind, tmp_ind + 1)
            tmp_ind += 1
        end
        return true
    end

    def sort_by_date!
        @items.sort_by!  { |item| item.deadline }
    end

    def toggle_item(index)
        @items[index].toggle
    end

    def remove_item(index)
        return false if !valid_index?(index)
        @items.delete_at(index)
        return true
    end

    def purge
        @items.delete_if(&:done)
    end
end