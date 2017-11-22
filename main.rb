class Robot
  class << self
    def init
      print "Tips: q for quit, h for help.\n"
      gets.chomp.upcase
    end

    def start
      print "welcome to ToyRobot!\n"
      input = init
      while input != "Q"  do
        if input.start_with?("PLACE")
          print "place !"
        else
          case input
          when "REPORT"
            print input
          when "LEFT","RIGHT"
            print input
          when "MOVE"
            print "move!"
          when ""
            print "Q for quit."
          when "H","HELP"
            help_text
          else
            print  "Command not found, see help if you need help."
          end
        end
        print "\n-------------------------\n"
        input = init
      end
      print "GoodBye!"
    end

    def help_text
      print "PLACE X,Y,F : put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.\n" +
       "MOVE : move the toy robot one unit forward in the direction it is currently facing.\n" +
       "LEFT & RIGHT: rotate the robot 90 degrees in the specified direction without changing the position of the robot.\n" +
       "REPORT : announce the X,Y and F of the robot. This can be in any form, but standard output is sufficient."
    end
  end
end

Robot.start