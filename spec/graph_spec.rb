require 'rubygems'
require 'rspec'
require 'pry-debugger'
require_relative '../graph.rb'

describe "Graph" do
  before(:each) do
    @map = Graph.new

    # Adding Texas Cities
    @map.add_node("Dallas")
    @map.add_node("Austin")
    @map.add_node("San Antonio")
    @map.add_node("Houston")
    @map.add_node("El Paso")

    # Connecting Texas Cities
    @map.add_edge("Dallas", "Austin", 220)
    @map.add_edge("Houston", "Austin", 240)
    @map.add_edge("San Antonio", "Austin", 80)
    @map.add_edge("San Antonio", "El Paso", 300)
    @map.add_edge("Dallas", "Houston", 250)

    # Adding California Cities
    @map.add_node("San Francisco")
    @map.add_node("Berkeley")
    @map.add_node("San Jose")
    @map.add_node("Los Angelos")

    # Connecting California Cities
    @map.add_edge("Los Angelos", "San Jose", 500)
    @map.add_edge("Los Angelos", "San Francisco", 600)
    @map.add_edge("San Jose", "San Francisco", 120)
    @map.add_edge("Berkeley", "San Francisco", 30)
    @map.add_edge("Berkeley", "San Jose", 140)
  end

  describe "#path_exists?" do
    it "should return true if the nodes are the same" do
      expect(@map.path_exists?("Dallas", "Dallas")).to eq(true)
    end

    it "should return true if the nodes are directly connected" do
      expect(@map.path_exists?("Dallas", "Houston")).to eq(true)
      expect(@map.path_exists?("Houston", "Dallas")).to eq(true)
    end

    it "should return true if the nodes are connected by 1 city" do
      expect(@map.path_exists?("Houston", "San Antonio")).to eq(true)
      expect(@map.path_exists?("Dallas", "San Antonio")).to eq(true)
      expect(@map.path_exists?("San Antonio", "Dallas")).to eq(true)
    end

    it "should return true if they are conected at all" do
      expect(@map.path_exists?("Dallas", "El Paso")).to eq(true)
      expect(@map.path_exists?("El Paso", "Dallas")).to eq(true)
    end

    it "should return false if they are disconnected" do
      expect(@map.path_exists?("Dallas", "San Jose")).to eq(false)
      expect(@map.path_exists?("San Francisco", "Austin")).to eq(false)
    end
  end
end
