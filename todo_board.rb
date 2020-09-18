require './list.rb'

class TodoBoard
    def initialize
        @lists = {}
    end

    def labels
        @lists.keys
    end

    def lists
        @lists.values
    end

    def get_command
        print "\nEnter a command: "
        cmd, *args = gets.chomp.split(' ')

        case cmd
        when 'mklist'
            if args.size != 1
                puts "mklist command, should be like this `mklist <new_list_label>`"
            else
                @lists[*args] = List.new(*args)
            end
        when 'ls'
            if args.size != 0
                puts "ls command, should be like this `ls`"
            else
                self.labels.each { |label| puts label }
            end
        when 'showall'
            if args.size != 0
                puts "showall command, should be like this `showall`"
            else
                self.lists.each { |list| list.print }
            end
        when 'mktodo'
            if args.size > 4 || args.size < 3
                puts "mktodo command, should be like this `mktodo <list_label> <item_title> <item_deadline> <optional_item_description>`"
            elsif !labels.include?(args[0])
                puts "`#{args[0]}` label is not in the board!"
            else
                label = args[0]
                title = args[1]
                deadline = args[2]
                description = ''
                description = args[3] if args.size == 4
                @lists[label].add_item(title, deadline, description)
            end
        when 'up'
            if args.size > 3 || args.size < 2
                puts "up command, should be like this `up <list_label> <item_index> <optional_amount>`"
            elsif !labels.include?(args[0])
                puts "`#{args[0]}` label is not in the board!"
            else
                label = args[0]
                index = args[1].to_i
                amount = 1
                amount = args[2].to_i if args.size == 3
                @lists[label].up(index, amount)
            end
        when 'down'
            if args.size > 3 || args.size < 2
                puts "down command, should be like this `down <list_label> <index> <optional amount>`"
            elsif !labels.include?(args[0])
                puts "`#{args[0]}` label is not in the board!"
            else
                label = args[0]
                index = args[1].to_i
                amount = 1
                amount = args[2].to_i if args.size == 3
                @lists[label].down(index, amount)
            end
        when 'swap'
            if args.size != 3
                puts "swap command, should be like this `swap <list_label> <item_index_1> <item_index_2>`"
            elsif !labels.include?(args[0])
                puts "`#{args[0]}` label is not in the board!"
            else
                label = args[0]
                index1 = args[1].to_i
                index2 = args[2].to_i
                @lists[label].swap(index1, index2)
            end
        when 'sort'
            if args.size != 1
                puts "sort command, should be like this `sort <list_label>`"
            elsif !labels.include?(args[0])
                puts "`#{args[0]}` label is not in the board!"
            else
                label = args[0]
                @lists[label].sort_by_date!
            end
        when 'priority'
            if args.size != 1
                puts "priority command, should be like this `priority <list_label>`"
            elsif !labels.include?(args[0])
                puts "`#{args[0]}` label is not in the board!"
            else
                label = args[0]
                @lists[label].print_priority
            end
        when 'print'
            if args.size > 2
                puts "print command, should be like this `print <list_label> <optional_index>`"
            elsif !labels.include?(args[0])
                puts "`#{args[0]}` label is not in the board!"
            elsif args.size == 1
                label = args[0]
                @lists[label].print
            else
                label = args[0]
                index = args[1].to_i
                @lists[label].print_full_item(index)
            end
        when 'toggle'
            if args.size != 2
                puts "toggle command, should be like this `toggle <list_label> <index>`"
            elsif !labels.include?(args[0])
                puts "`#{args[0]}` label is not in the board!"
            else
                label = args[0]
                index = args[1].to_i
                @lists[label].toggle_item(index)
            end
        when 'rm'
            if args.size != 2
                puts "rm command, should be like this `rm <list_label> <index>`"
            elsif !labels.include?(args[0])
                puts "`#{args[0]}` label is not in the board!"
            else
                label = args[0]
                index = args[1].to_i
                @lists[label].remove_item(index)
            end
        when 'purge'
            if args.size != 1
                puts "purge command, should be like this `purge <list_label>`"
            elsif !labels.include?(args[0])
                puts "`#{args[0]}` label is not in the board!"
            else
                label = args[0]
                @lists[label].purge
            end
        when 'purgeall'
            if args.size != 0
                puts "purgeall command, should be like this `purgeall <list_label>`"
            else
                lists.each { |list| list.purge }
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

### Run the program
TodoBoard.new.run