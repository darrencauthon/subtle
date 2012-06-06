class Array
  def to_objects(&blk)
    data = blk.call
    return [] if data.empty?

    results = []
    data.each do |value|
      result = Object.new
      self.each_with_index do |property_name, index|
        this_value = value
        this_value = value[index] if value.kind_of?(Array)
        result.instance_variable_set("@#{property_name}", this_value)
        result.instance_eval("
        class << self
          attr_accessor :#{property_name}
        end")
      end
      results << result
    end
    results
  end
end
