class Array

  def to_hashes(test = nil, &block_that_returns_the_records)
    records = block_that_returns_the_records.call
    return [] if records.empty?
    records.map { |record| turn_this_data_into_a_filled_hash(record) }
  end

  private

  def turn_this_data_into_a_filled_hash(record)
    result = {}
    fill_the_hash_with_the_values(result, record)
    result
  end

  def fill_the_hash_with_the_values(result, record)
    self.each_with_index do |field, index|
      value = get_the_value(record, index)
      result[field] = value
    end
  end
end
