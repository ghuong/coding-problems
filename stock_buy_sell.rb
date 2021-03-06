# Stock Buy-Sell
# https://practice.geeksforgeeks.org/problems/stock-buy-and-sell/0

# Accepts input file formatted according to problem specification in link
def stock_buy_sell(input_file_name)
  file = File.new(input_file_name, "r")
  
  num_test_cases = file.gets.to_i

  num_test_cases.times do
    num_days = file.gets.to_i
    prices = file.gets.split.map { |element| element.to_i }

    stock_buy_sell_helper(num_days, prices)
  end

  file.close
end

# Print buy and sell days to maximize profit
def stock_buy_sell_helper(num_days, prices)
  num_buy_sell_dates = 0

  day = 0
  loop do
    # Find local minimum
    while day < num_days - 1 && prices[day] >= prices[day + 1]
      day += 1
    end
    buy_day = day

   break if day >= num_days - 1 # last day, can't sell afterwards

    # Find local maximum
    while day < num_days - 1 && prices[day] <= prices[day + 1]
      day += 1
    end
    sell_day = day

    print "(#{buy_day} #{sell_day}) "
    num_buy_sell_dates += 1
  end

  if num_buy_sell_dates == 0
    print "No Profit"
  end
  print "\n"
end