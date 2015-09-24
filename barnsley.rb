#!/usr/bin/env ruby

require 'gosu'

WIDTH = 600
HEIGHT = 900

class GameWindow < Gosu::Window
  def initialize
    super WIDTH, HEIGHT
    self.caption = 'Barnsley fern'
    @image = Gosu::Image.from_text('.', 8)
    @color = Gosu::Color.new(0xff_00ff00)
    @random = Random.new
    @x, @y = 0, 0
    @points = []
    @new_points_num = 400
    @max_points = 360000
  end

  def f1
    @x, @y = 0, 0.16 * @y
  end

  def f2
    @x, @y = 0.85 * @x + 0.04 * @y, -0.04 * @x + 0.85 * @y + 1.6
  end

  def f3
    @x, @y = 0.2 * @x - 0.26 * @y, 0.23 * @x + 0.22 * @y + 1.6
  end

  def f4
    @x, @y = -0.15 * @x + 0.28 * @y, 0.26 * @x + 0.24 * @y + 0.44
  end

  def function(probability)
    return :f2 if probability < 0.85
    return :f3 if probability < 0.92
    return :f4 if probability < 0.99
    :f1 # least probable last :)
  end

  def transpose(rand)
    self.send function(rand)
  end

  def new_points(arr = [])
    arr.size == @new_points_num ? arr : new_points(arr << transpose(rand))
  end

  def update
  end

  def draw
    @points.count < @max_points ? (@points += new_points) : puts('DONE')
    @points.each do |arr|
      @xs = WIDTH/2 + (arr.first * WIDTH/6)
      @ys = HEIGHT - (arr.last * HEIGHT/10)
      @image.draw(@xs, @ys, 1, 1, 1, @color) # x, y, z-order
    end
  end
end

window = GameWindow.new
window.show
