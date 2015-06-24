def find_next_words(from_word, available_words)
  next_words = []
  available_words.each do |available_word|
    distance = 0
    available_word.length.times { |i| distance += 1 if available_word[i] != from_word[i] }
    next_words << available_word if distance == 1
  end
  next_words
end


start = 'cat'
stop  = 'dog'

# load words from file and remove unnecessary words
available_words = []
File.open('words') { |file| file.each_line { |line| available_words << line.chomp.downcase } }
available_words = available_words.keep_if { |word| word.length == start.length }
available_words = available_words.uniq

# solve using closures (lambdas) to perform a breadth-first search
actions = []
actions << lambda { |available_words| {:used_words => [start], :next_words => find_next_words(start, available_words) } }

while !actions.empty?
  result = actions.shift.call(available_words)

  if result[:next_words].include?(stop)
    puts (result[:used_words] + [stop]).join(', ')
    actions.clear
  else
    result[:next_words].each do |from_word|
      used_words = result[:used_words] + [from_word]
      actions << lambda { |available_words| {:used_words => used_words, :next_words => find_next_words(from_word, available_words) } }
    end
    available_words -= result[:used_words]
    available_words -= result[:next_words]
  end
end

