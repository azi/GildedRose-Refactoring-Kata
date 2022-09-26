class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case item.name
      when "Aged Brie"                                 then calc_brie(item)
      when "Backstage passes to a TAFKAL80ETC concert" then calc_concer(item)
      when "Sulfuras, Hand of Ragnaros"
      else                                                  calc_default(item)
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

def calc_brie(item)
  item.sell_in -= 1
  offset       = (item.sell_in < 0) ? 2 : 1
  item.quality += offset if item.quality < 50
end

def calc_concer(item)
  item.sell_in -= 1
  offset = case
           when item.sell_in >= 10 then 1
           when item.sell_in >=  5 then 2
           when item.sell_in >=  0 then 3
           when item.sell_in <   0 then -1 * item.quality
           end

  item.quality += offset if item.quality < 50
  item.quality = 50      if item.quality >= 50
end

def calc_default(item)
  item.sell_in -= 1
  offset       = (item.sell_in < 0 ) ? 2 : 1
  item.quality -= offset if item.quality > 0
end
