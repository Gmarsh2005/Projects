class Dependencies
 
  def initialize()
    @direct = Hash.new
  end
 
  def add_direct(item, dependants)
    @direct[item] = dependants
  end
 
  def dependencies_for(item)
    dependants = []
    toBeProcessed = @direct[item].clone
    while not toBeProcessed.empty?
      x = toBeProcessed.shift
      if x != item and not dependants.include?(x) 
        dependants << x 
        toBeProcessed.concat(@direct[x]) if @direct.include?(x)
      end
    end
    return dependants.sort!
  end
   
end