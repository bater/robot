class Robot
  TABLE_SIZE = 5
  MAX_INDEX = TABLE_SIZE - 1
  TURN_RIGHT = {NORTH: "EAST", SOUTH: "WEST", EAST: "SOUTH", WEST: "NORTH"}
  TURN_LEFT = {NORTH: "WEST", SOUTH: "EAST", EAST: "NORTH", WEST: "SOUTH"}
  ROBOT_FLAG = {NORTH: " ^ ", SOUTH: " v ", EAST: " > ", WEST: " < "}
  MOVE = {NORTH: "@Y += 1", SOUTH: "@Y -= 1", EAST: "@X += 1", WEST: "@X -= 1"}
  HELP = "PLACE X,Y,F : put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.\n" +
  "MOVE : move the toy robot one unit forward in the direction it is currently facing.\n" +
  "LEFT & RIGHT: rotate the robot 90 degrees in the specified direction without changing the position of the robot.\n" +
  "REPORT : announce the X,Y and F of the robot. This can be in any form, but standard output is sufficient.\n" +
  "MAP : display location of the robot.\n" +
  "READ : Input from file, plase put file inside files folder. Try `read demo.txt`"

  def initialize(x,y,f)
    raise ArgumentError.new("Out of table") if x < 0 || x > MAX_INDEX || y < 0 || y > MAX_INDEX
    raise ArgumentError.new("Wrong input argumen") unless ["NORTH", "SOUTH", "EAST", "WEST"].include?(f)
    @X, @Y, @F = x,y,f
  end

  def report
    "#{map}#{@X},#{@Y},#{@F}"
  end

  def turn side
    @F = side == "RIGHT" ? TURN_RIGHT[@F.to_sym] : TURN_LEFT[@F.to_sym]
    report
  end

  def is_fall?
    @X < 0 || @X > MAX_INDEX || @Y < 0 || @Y > MAX_INDEX
  end

  def move
    temp = [@X, @Y]
    eval MOVE[@F.to_sym]
    if is_fall?
      @X, @Y = temp
      "Out of table! Pleas try again."
    else
      report
    end
  end

  def map
    columns = ""
    TABLE_SIZE.times do |column|
      columns += @X == column ? ROBOT_FLAG[@F.to_sym] : "---"
      columns += "|" if column < MAX_INDEX
    end
    map_string = "N\n"
    TABLE_SIZE.times do |row|
      map_string += @Y + row == MAX_INDEX ? columns : "---|---|---|---|---"
      map_string += row < MAX_INDEX ? "\n" : " E\n"
    end
    map_string
  end

  class << self
    def init
      print "Tips: q for quit, h for help.\n"
      gets.chomp.upcase
    end

    def start
      print "Welcome to ToyRobot!\n"
      input = init
      while input != "Q"  do
        print "#{commands(input)}\n" +
        "------------------------\n"
        input = init
      end
      print "GoodBye!\n"
    end

    def commands input
      case input
      when /PLACE/
        xyf = input.split(" ")[1]&.split(",")
        result = "Wrong axis format, should be `place integer,integer,string` (NORTH, SOUTH, EAST or WEST)."
        if xyf&.size == 3
          x = xyf[0].to_i
          y = xyf[1].to_i
          f = xyf[2]
          if x.class == Fixnum && y.class == Fixnum && ["NORTH", "SOUTH", "EAST", "WEST"].include?(f)
            @robot = Robot.new(x,y,f) rescue nil
            result = @robot ? "#{@robot.map}Robot on the table!" : "Out of table! Pleas try again."
          end
        end
        result
      when /READ/
        file_path = input.split(" ")[1]
        file_path && File.exists?("files/#{file_path}") ?
          input_from_file(File.read("files/#{file_path}").split("\n")) :
          "File not found, plase put file inside files folder. Try `read demo.txt`"
      when "REPORT", "MOVE", "MAP"
        @robot.send input.downcase
      when "LEFT", "RIGHT"
        @robot.turn input
      when "H", "HELP"
        HELP
      else
        "Command not found, see help if you need help."
      end
    end

    def input_from_file inputs
      result = ""
      inputs.each {|input| result += "> #{input}\n#{commands(input.upcase)}\n" }
      result
    end

  end
end
