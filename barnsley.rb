#!/usr/bin/env ruby

require 'gosu'

W, H = 600, 900 # window dimensions

class DrawWindow < Gosu::Window

  def initialize(update_interval: 1)
    super W, H
    self.caption = 'Barnsley fern'
    @dot = Gosu::Image.from_text('.', 8)
    @color = Gosu::Color.new(0xff_00ff00)
    @random = Random.new
    @x, @y = 0, 0
    @f1 = lambda {|x,y| x, y = 0, 0.16*y}
    @f2 = lambda {|x,y| x, y = 0.85*x + 0.04*y, -0.04*x + 0.85*y + 1.6}
    @f3 = lambda {|x,y| x, y = 0.2*x - 0.26*y, 0.23*x + 0.22*y + 1.6}
    @f4 = lambda {|x,y| x, y = -0.15*x + 0.28*y, 0.26*x + 0.24*y + 0.44}
    @points = []
    @new_points_num = `ulimit -s`.chomp.to_i # stack level :)
    @max_points = 600000
  end

  def function(probability) # Strategy pattern :)
    return @f2 if probability < 0.85
    return @f3 if probability < 0.92
    return @f4 if probability < 0.99
    @f1 # least probable last :)
  end

  def iterate(rand)
    @x, @y = function(rand).call(@x, @y)
  end

  def new_points(arr = [])
    arr.size == @new_points_num ? arr : new_points(arr << iterate(rand))
  end

  def trans_x(x)
    W/2 + (x * W/6)
  end

  def trans_y(y)
    H - (y * H/10)
  end

  def update
  end

  def draw
    @points.count < @max_points ? (@points += new_points) : self.close
    @points.each { |x, y| @dot.draw(trans_x(x), trans_y(y), 1, 1, 1, @color) }
  end

end

window = DrawWindow.new
window.show
