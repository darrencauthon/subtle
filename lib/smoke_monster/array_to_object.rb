class Array
  def to_objects(&blk)
    data = blk.call
    return [] if data.empty?

    results = []
    data.each do |value|
      result = Object.new
      self.each_with_index do |property_name, index|
        this_value = get_the_value(value, index)
        add_reader_for(result, property_name, this_value)
      end
      results << result
    end
    results
  end

  private

  def get_the_value(value, index)
    return value unless value.kind_of?(Array)
    value[index]
  end

  def add_reader_for(result, property_name, this_value)
    result.instance_variable_set("@#{property_name}", this_value)
    result.instance_eval("
    class << self
      attr_accessor :#{property_name}
    end")
  end
end
