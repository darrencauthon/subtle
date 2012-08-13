class Array

  def to_object(subject = nil)
    subject = Object.new if subject.nil?
    self.each { |item| add_reader_for(subject, item, nil) }
    subject
  end

  def to_objects(type = Object, &blk)
    records = blk.call
    return [] if records.empty?
    records.map { |record| create_object_for_this_record(type, record) }
  end

  private

  def create_object_for_this_record(type, record)
    result = type.new
    self.each_with_index do |property_name, index|
      value = get_the_value(record, index)
      if type == Object
        add_reader_for(result, property_name, value)
      else
        result.send("#{property_name}=".to_sym, value)
      end
    end
    result
  end

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
