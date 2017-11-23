require 'spec_helper'
require_relative '../robot.rb'

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

  it "#report" do
    expect { robot.report }.to output('1,1,WEST').to_stdout
  end

  it "#turn right and left" do
    robot.turn "RIGHT"
    expect { robot.report }.to output('1,1,NORTH').to_stdout
    robot.turn "LEFT"
    robot.turn "LEFT"
    expect { robot.report }.to output('1,1,SOUTH').to_stdout
  end

  it "#is_fall?" do
    expect(robot.is_fall?).to eq(false)
  end
end
