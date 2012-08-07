class Object
  def param_constructor(&block_for_each)
    self.class_eval('
    def initialize(params={}, &block)
      params.each do |attr, value|
        self.public_send("#{attr}=", value)
      end if params
      constructor_method(self) if respond_to?(:constructor_method)
      block.call(self) if block
    end')
    unless block_for_each.nil?
      self.send(:define_method, :constructor_method, &block_for_each)
    end
  end
end
