require 'spec_helper'
require_relative '../robot.rb'

RSpec.describe Robot do
  it "vaild" do
    expect { Robot.new(1,1,"WEST") }.not_to raise_error
  end
  context "invaild robot initialize place" do
    it "out of table" do
      expect { Robot.new(10,10,"WEST") }.to raise_error("Out of table")
    end
    it "Wrong input argumen" do
      expect { Robot.new(0,0,"Wrong") }.to raise_error("Wrong input argumen")
    end
  end
end
