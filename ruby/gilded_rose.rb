require "active_support/core_ext/string"

module Handler
  def update_quality
    @sell_in -= 1
    offset   = (@sell_in < 0 ) ? 2 : 1
    @quality -= offset if @quality > 0
  end

  module Brie
    def update_quality
      @sell_in -= 1
      offset  = (@sell_in < 0) ? 2 : 1
      @quality += offset if @quality < 50
    end
  end

  module Concert
    def update_quality
      @sell_in -= 1
      offset = case
               when @sell_in >= 10 then 1
               when @sell_in >=  5 then 2
               when @sell_in >=  0 then 3
               when @sell_in <   0 then -1 * @quality
               end

      @quality += offset if @quality < 50
      @quality = 50      if @quality >= 50
    end
  end

  module Ragnaros
    def update_quality ;end
  end
end

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      item.update_quality
    end
  end
end

class Item
  include Handler
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name    = name
    @sell_in = sell_in
    @quality = quality
    handler  = "Handler::#{@name.split(' ').last.camelize}".safe_constantize
    extend handler if handler
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
