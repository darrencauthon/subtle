class Array
  def to_objects(&blk)
    data = blk.call
    return [] if data.empty?
    
    result = Object.new
    def result.name
      @name
    end
    def result.name=(value)
      @name = value
    end
    result.name = data[0]
    [result]
  end
end
