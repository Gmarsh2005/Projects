class CheckOut

  def initialize rules
    current_sku = ''
    @prices = {}
    rules.each do |line|
      line.chomp!
      if line[0..0] == "\t"
        quantity, total = line[1..-1].split "\t"
        @prices[current_sku] = {} if @prices[current_sku].nil?
        @prices[current_sku][quantity.to_i] = total.to_i
      else current_sku = line
      end
    end
    @items = {}
  end

  def scan sku
    @items[sku] = 0 if @items[sku].nil?
    @items[sku] += 1
  end

  def total
    total = 0
    @items.each_pair do |sku, quantity|
      while quantity > 0 do
        deal_quantity, deal_price = find_best_deal sku, quantity
        num_deals = quantity / deal_quantity
        total += num_deals * deal_price
        quantity -= num_deals * deal_quantity
      end
    end
    total
  end

  private

  def find_best_deal sku, quantity
    deal = nil
    @prices[sku].each_pair do |rule_quantity, rule_total|
      if rule_quantity > quantity then
        break
      else
        deal = [rule_quantity, rule_total]
      end
    end
    puts "ERROR: NO PRICE FOUND for #{quantity} of #{sku}!" if deal.nil?
    deal
  end

end


RULES = [
  "A",
  "\t1\t50",
  "\t3\t130",
  "B",
  "\t1\t30",
  "\t2\t45",
  "C",
  "\t1\t20",
  "D",
  "\t1\t15",
]
