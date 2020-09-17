require './list.rb'

class TodoBoard
    def initialize(label)
        @list = List.new(label)
    end

    def get_command
        print "\nEnter a command: "
        cmd, *args = gets.chomp.split(' ')

        case cmd
        when 'mktodo'
            if args.size > 3 || args.size < 2
                puts "mktodo command, should be like this `mktodo <title> <deadline> <optional description>`"
            else
                @list.add_item(*args)
            end
        when 'up'
            if args.size > 2 || args.size < 1
                puts "up command, should be like this `up <index> <optional amount>`"
            else
                args.map!(&:to_i)
                @list.up(*args)
            end
        when 'down'
            if args.size > 2 || args.size < 1
                puts "down command, should be like this `down <index> <optional amount>`"
            else
                args.map!(&:to_i)
                @list.down(*args)
            end
        when 'swap'
            if args.size != 2
                puts "swap command, should be like this `swap <index_1> <index_2>`"
            else
                args.map!(&:to_i)
                @list.swap(*args)
            end
        when 'sort'
            if args.size != 0
                puts "sort command, should be like this `sort`"
            else
                @list.sort_by_date!
            end
        when 'priority'
            if args.size != 0
                puts "priority command, should be like this `priority`"
            else
                @list.print_priority
            end
        when 'print'
            if args.size > 1
                puts "print command, should be like this `print <optional index>`"
            elsif args.size == 0
                @list.print
            else
                args.map!(&:to_i)
                @list.print_full_item(*args)
            end
        when 'toggle'
            if args.size != 1
                puts "toggle command, should be like this `toggle <index>`"
            else
                args.map!(&:to_i)
                @list.toggle_item(*args)
            end
        when 'quit'
            return false
        else
            print "Sorry, that command is not recognized."
        end
        true
    end

    def run
        while get_command
            next
        end
    end
end