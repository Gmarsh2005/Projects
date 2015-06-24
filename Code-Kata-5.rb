class BloomFilter
   
  def initialize(dictionary, num_bits, num_hashes)
    @bitmap = Bitmap.new(num_bits)
    @hashes = Array.new(num_hashes) { |i| BloomHash.new(i, num_bits-1) }
     
    # compute the hash values for each word in the dictionary
    # and set the appropriate bits in the bitmap
    File.new(dictionary, 'r').each_line do |word|
      @hashes.each { |h| @bitmap[h.compute(word.chomp)] = 1 }
    end   
  end
   
  def search(word)
    @hashes.each { |h| return false if @bitmap[h.compute(word)] == 0 }
    return true
  end
 
end
 
 
class BloomHash
 
  def initialize(seed, max_value)
    @offset = seed
    @num_digits = 0
    @max_value = max_value
    while(max_value > 0) do
      @num_digits += 1
      max_value >>= 4
    end
  end
   
  def compute(word)
    digest = Digest::MD5.hexdigest(word)
    return digest[@offset, @num_digits].to_i(16) % @max_value
  end
   
end
 
 
class Bitmap < Array
   
  def initialize(size)
    super(size)
    self.fill(0)
  end
   
end
