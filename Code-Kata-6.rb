class Anagram
  attr_reader :letters

  def initialize(word)
    @word = word
    # letters is a letter count of the word.
    @letters = {}
    @word.each_char do |l|
      @letters[l] ||= 0
      @letters[l] += 1
    end
  end

  def each(&block)
    each_anagram("", @letters.clone, &block)
  end

  private

  def each_anagram(word, letters, &block)
    if letters.empty?
      # If no more letters, we have the final anagram
      yield(word)
    else
      # If still letters, go through each and build anagram
      letters.keys.each do |letter|
        # Add letter to word.
        w = word.clone
        w += letter.to_s
        # Prepare next set by removing used up letter.
        ls = letters.clone
        ls[letter] -= 1
        ls.delete(letter) if ls[letter] == 0
        # Go to next letter.
        each_anagram(w, ls, &block)
      end
    end
  end
end
