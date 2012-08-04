class Array
  def to_object
    object = Object.new
    self.each { |item| add_reader_for(object, item, nil) }
    object
  end
end
