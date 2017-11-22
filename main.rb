class Robot
  def initialize(x,y,f)
    @X, @Y, @F = x,y,f
  end

  def report
    print "#{@X},#{@Y},#{@F}"
  end

  def is_fall?
    @X < 0 || @X > 4 || @Y < 0 || @Y > 4
  end

  class << self
    def init
      print "Tips: q for quit, h for help.\n"
      gets.chomp.upcase
    end

    def start
      print "welcome to ToyRobot!\n"
      input = init
      while input != "Q"  do
        result = ""
        if input.start_with?("PLACE")
          xyf = input.split(" ")[1].split(",")
          result = "wrong axis format, should be integer,integer,string (NORTH, SOUTH, EAST or WEST)"
          if xyf.size == 3
            x = xyf[0].to_i
            y = xyf[1].to_i
            f = xyf[2]
            if x.class == Fixnum && y.class == Fixnum && f.class == String &&
              ["NORTH", "SOUTH", "EAST", "WEST"].include?(f)
              @robot = Robot.new(x,y,f)
              if @robot.is_fall?
                @robot = nil
                result = "Out of table! Pleas try again."
              else
                result = "Robot on the table!"
              end
            end
          end
        else
          case input
          when "REPORT"
            result = @robot.nil? ? "Robot not found!" : @robot.report
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
        print "#{result}\n-------------------------\n"
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