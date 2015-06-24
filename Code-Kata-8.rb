def make_word_lists file_name

  word_lists = []

  for len in 1 .. 6 do
    word_lists[len] = []
  end

  puts "Reading #{file_name}..."
  dict = File.new file_name, 'r'
  for line in dict do
    word = line.chomp
    if    word.length == 1 then word_lists[1] << word
    elsif word.length == 2 then word_lists[2] << word
    elsif word.length == 3 then word_lists[3] << word
    elsif word.length == 4 then word_lists[4] << word
    elsif word.length == 5 then word_lists[5] << word
    elsif word.length == 6 then word_lists[6] << word
    end
  end
  dict.close

  return word_lists

end



def find_combinations word_lists

  puts 'Finding combinations....'
  
  combinations = 0
  
  for word in word_lists[6] do
  
    part_1 = word[0 .. 0]
    part_2 = word[1 .. 5]
    if word_lists[1].include? part_1 and word_lists[5].include? part_2
      puts "#{part_1} + #{part_2} = #{word}"
      combinations = combinations + 1
    end
  
    part_1 = word[0 .. 1]
    part_2 = word[2 .. 5]
    if word_lists[2].include? part_1 and word_lists[4].include? part_2
      puts "#{part_1} + #{part_2} = #{word}"
      combinations = combinations + 1
    end
  
    part_1 = word[0 .. 2]
    part_2 = word[3 .. 5]
    if word_lists[3].include? part_1 and word_lists[3].include? part_2
      puts "#{part_1} + #{part_2} = #{word}"
      combinations = combinations + 1
    end
  
    part_1 = word[0 .. 3]
    part_2 = word[4 .. 5]
    if word_lists[4].include? part_1 and word_lists[2].include? part_2
      puts "#{part_1} + #{part_2} = #{word}"
      combinations = combinations + 1
    end
  
    part_1 = word[0 .. 4]
    part_2 = word[5 .. 5]
    if word_lists[5].include? part_1 and word_lists[1].include? part_2
      puts "#{part_1} + #{part_2} = #{word}"
      combinations = combinations + 1
    end
  
  end
  
  return combinations

end


start_time = Time.now
word_lists = make_word_lists ARGV[0]
combinations = find_combinations word_lists
puts "We found a total of #{combinations} combinations"

end_time = Time.now
run_time = end_time - start_time

puts "Running time: #{run_time} seconds"