def make_word_lists file_name

  word_lists = []
  
  for len in 1 .. 6 do word_lists[len] = {} end
  
  dict = File.open file_name, 'r'
  dict.each_line do |line|
    word = line.chomp
    len = word.length
    word_lists[len][word] = nil if len <= 6
  end
  dict.close

  word_lists
end
  

def find_combinations word_lists
  combinations = 0
  for word in word_lists[6].keys.sort do
    for first_part_len in 1 .. 5 do
      part_1 = word[0 .. first_part_len - 1]
      part_2 = word[first_part_len .. 5]
      if word_lists[first_part_len].include? part_1 and
         word_lists[6-first_part_len].include? part_2
        puts "#{part_1} + #{part_2} = #{word}"
        combinations += 1
      end
    end
  end
  combinations
end


start_time = Time.now
word_lists = make_word_lists ARGV[0]
combinations = find_combinations word_lists
puts "We found a total of #{combinations} combinations"
puts "Running time: #{Time.now - start_time} seconds"