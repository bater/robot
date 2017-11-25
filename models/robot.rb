class Robot
  TURN_RIGHT = {NORTH: "EAST", SOUTH: "WEST", EAST: "SOUTH", WEST: "NORTH"}
  TURN_LEFT = {NORTH: "WEST", SOUTH: "EAST", EAST: "NORTH", WEST: "SOUTH"}
  ROBOT_FLAG = {NORTH: "^", SOUTH: "v", EAST: ">", WEST: "<"}
  HELP = "PLACE X,Y,F : put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.\n" +
  "MOVE : move the toy robot one unit forward in the direction it is currently facing.\n" +
  "LEFT & RIGHT: rotate the robot 90 degrees in the specified direction without changing the position of the robot.\n" +
  "REPORT : announce the X,Y and F of the robot. This can be in any form, but standard output is sufficient.\n" +
  "MAP : display location of the robot.\n" +
  "READ : Input from file, plase put file inside files folder. Try `read demo.txt`"

  def initialize(x,y,f)
    raise ArgumentError.new("Out of table") if x < 0 || x > 4 || y < 0 || y > 4
    raise ArgumentError.new("Wrong input argumen") unless ["NORTH", "SOUTH", "EAST", "WEST"].include?(f)
    @X, @Y, @F = x,y,f
  end

  def report
    map + "#{@X},#{@Y},#{@F}"
  end

  def turn side
    @F = side == "RIGHT" ? TURN_RIGHT[@F.to_sym] : TURN_LEFT[@F.to_sym]
    report
  end

  def is_fall?
    @X < 0 || @X > 4 || @Y < 0 || @Y > 4
  end

  def move
    temp = [@X, @Y]
    case @F
    when "NORTH"
      @Y += 1
    when "SOUTH"
      @Y -= 1
    when "EAST"
      @X += 1
    when "WEST"
      @X -= 1
    end
    if is_fall?
      @X, @Y = temp
      "Out of table! Pleas try again."
    else
      report
    end
  end

  def map
    column = ""
    5.times do |i|
      column += @X == i ? "-#{ROBOT_FLAG[@F.to_sym]}-" : "---"
      column += "|" if i < 4
    end
    map_string = "N\n"
    5.times do |i|
      map_string += @Y + i == 4 ? column : "---|---|---|---|---"
      map_string += i < 4 ? "\n" : " E\n"
    end
    map_string
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
        print "#{commands(input)}\n" +
        "------------------------\n"
        input = init
      end
      print "GoodBye!\n"
    end

    def commands input
      if input.start_with?("PLACE")
        xyf = input.split(" ")[1]&.split(",")
        result = "Wrong axis format, should be integer,integer,string (NORTH, SOUTH, EAST or WEST)"
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
      elsif input.start_with?("READ")
        file_path = input.split(" ")[1]
        result = "File not found, plase put file inside files folder. Try `read demo.txt`"
        if file_path
          file_path = "files/#{file_path}"
          if File.exists?(file_path)
            result = input_from_file File.read(file_path).split("\n")
          end
        end
        result
      else
        case input
        when "REPORT"
          @robot.report
        when "LEFT","RIGHT"
          @robot.turn input
        when "MOVE"
          @robot.move
        when "H","HELP"
          HELP
        when "MAP"
          @robot.map
        else
          "Command not found, see help if you need help."
        end
      end
    end

    def input_from_file inputs
      result = ""
      inputs.each do |input|
        result += "> #{input}\n"
        result += "#{commands(input.upcase)}\n"
      end
      result
    end

  end
end
