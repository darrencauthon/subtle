class Array

  def to_object(subject = nil)
    subject = Object.new if subject.nil?
    self.each { |item| add_attr_accessor_for(subject, item) }
    subject
  end

  def to_objects(type = Object, &blk)
    records = blk.call
    return [] if records.empty?
    records.map { |record| create_object_for_this_record(type, record) }
  end

  private

  def create_object_for_this_record(type, record)
    result = create_the_object(type)
    fill_the_object_with_the_values(result, record)
    result
  end

  def fill_the_object_with_the_values(result, record)
    self.each_with_index do |property_name, index|
      value = get_the_value(record, index)
      result.send("#{property_name}=".to_sym, value)
    end
  end

  def create_the_object(type)
    result = type.new
    return result if type != Object
    self.each_with_index do |property_name, index|
      add_attr_accessor_for(result, property_name)
    end
    result
  end

  def get_the_value(value, index)
    return value unless value.kind_of?(Array)
    value[index]
  end

  def add_attr_accessor_for(result, property_name)
    result.instance_eval("
    class << self
      attr_accessor :#{property_name}
    end")
  end
end
