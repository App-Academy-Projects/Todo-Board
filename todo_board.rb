require './list.rb'

class TodoBoard
    def initialize(label)
        @list = List.new(label)
    end
end