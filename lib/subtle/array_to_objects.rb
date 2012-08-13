class Array

  def to_object(subject = Object.new)
    self.each { |field| add_attr_accessor_for(subject, field) }
    subject
  end

  def to_objects(type = Object, &block_that_returns_the_records)
    records = block_that_returns_the_records.call
    return [] if records.empty?
    records.map { |record| turn_this_data_into_a_filled_object(type, record) }
  end

  private

  def turn_this_data_into_a_filled_object(type, record)
    result = create_the_object(type)
    fill_the_object_with_the_values(result, record)
    result
  end

  def fill_the_object_with_the_values(result, record)
    self.each_with_index do |field, index|
      value = get_the_value(record, index)
      result.send("#{field}=".to_sym, value)
    end
  end

  def create_the_object(type)
    result = type.new
    return result if type != Object
    self.each_with_index do |field, index|
      add_attr_accessor_for(result, field)
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
