class Array
  def to_objects(&blk)
    data = blk.call
    return [] if data.empty?
    
    result = Object.new
    property_name = self[0]
    result.instance_variable_set("@#{property_name}", data[0])
    result.instance_eval("
    class << self
      attr_accessor :#{property_name}
    end")
    [result]
  end
end
