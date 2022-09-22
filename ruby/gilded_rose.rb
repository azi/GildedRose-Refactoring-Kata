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
  item.quality += 1 if item.quality < 50
  item.quality += 1 if item.sell_in < 0 && item.quality < 50
end

def calc_concer(item)
  if item.quality < 50
    item.quality += 1
    item.quality += 1 if item.sell_in < 11 && item.quality < 50
    item.quality += 1 if item.sell_in < 6 && item.quality < 50
  end
  item.sell_in -= 1
  item.quality = 0 if item.sell_in < 0
end

def calc_default(item)
  item.sell_in -= 1
  item.quality -= 1 if item.quality > 0
  item.quality -= 1 if item.sell_in < 0 && item.quality > 0
end
