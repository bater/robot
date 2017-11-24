require 'spec_helper'

RSpec.describe Robot do
  let(:robot) {Robot.new(1,1,"WEST")}

  it "vaild initialize" do
    expect { robot }.not_to raise_error
  end
  context "invaild robot initialize place" do
    it "out of table" do
      expect { Robot.new(10,10,"WEST") }.to raise_error("Out of table")
    end
    it "wrong input argumen" do
      expect { Robot.new(0,0,"Wrong") }.to raise_error("Wrong input argumen")
    end
  end

  it "discard all commands in the sequence until a valid PLACE" do
    expect(nil.move).to eq('Robot not found!')
    expect(nil.turn("LEFT")).to eq('Robot not found!')
    expect(nil.turn("RIGHT")).to eq('Robot not found!')
    expect(nil.report).to eq('Robot not found!')
  end

  it "#report" do
    expect( robot.report ).to eq("#{robot.map}1,1,WEST")
  end

  it "#turn right and left" do
    robot.turn "RIGHT"
    expect(robot.report).to eq("#{robot.map}1,1,NORTH")
    robot.turn "LEFT"
    robot.turn "LEFT"
    expect(robot.report).to eq("#{robot.map}1,1,SOUTH")
  end

  it "#is_fall?" do
    expect(robot.is_fall?).to eq(false)
  end

  context "#move" do
    it "vaild move" do
      expect(robot.move).to eq("#{robot.map}0,1,WEST")
    end
    it "invaild move" do
      expect( Robot.new(4,4,"EAST").move ).to eq "Out of table! Pleas try again."
    end
  end

  context "Pass Example" do
    it "example a" do
      robot = Robot.new(0,0,"NORTH")
      expect(robot.move ).to eq("#{robot.map}0,1,NORTH")
    end
    it "example b" do
      robot = Robot.new(0,0,"NORTH")
      robot.turn "LEFT"
      expect(robot.report ).to eq("#{robot.map}0,0,WEST")
    end
    it "example c" do
      robot = Robot.new(1,2,"EAST")
      robot.move
      robot.move
      robot.turn "LEFT"
      robot.move
      expect(robot.report ).to eq("#{robot.map}3,3,NORTH")
    end
  end
end
