#!/usr/bin/env ruby

require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    super 600, 600
    self.caption = "Gosu Tutorial Game"
    @image = Gosu::Image.from_text('.', 8)
    @color = Gosu::Color.new(0xff_00ff00)
    @random = Random.new
    @points = []
  end

  def fern
    if @points.size < 1000000
      x, y = 0, 0
      200.times do
        rand = @random.rand
        if rand < 0.01
          x = 0
          y = 0.16 * y
        elsif rand < 0.84
          newx = (0.85 * x) + (0.04 * y)
          newy = (-0.04 * x) + (0.85 * y) + 1.6
          x, y = newx, newy
        elsif rand < 0.92
          newx = (0.2 * x) - (0.26 * y)
          newy = (0.23 * x) + (0.22 * y) + 1.6
          x, y = newx, newy
        else
          newx = (-0.15 * x) + (0.28 * y)
          newy = (0.26 * x) + (0.24 * y) + 0.44
          x, y = newx, newy
        end
        @points << [x, y]
      end
    end
    @points
  end

  def update
  end

  def draw
    fern.each do |arr|
      @x = (600/2) + (arr.first * 600/6)
      @y = 600 - (arr.last * 600/11)
      @image.draw(@x, @y, 1, 1, 1, @color) # x, y, z-order
    end
  end
end

window = GameWindow.new
window.show
