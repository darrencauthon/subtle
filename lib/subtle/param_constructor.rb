class Object
  def param_constructor(&block_for_each)
    self.class_eval('
    def initialize(params={}, &block)
      params.each do |attr, value|
        self.send("#{attr}=", value)
      end if params
      unless block.nil?
        block.call(self)
      end
      constructor_method if respond_to?(:constructor_method)
      block.call(self) if block
    end')
    unless block_for_each.nil?
      self.send(:define_method, :constructor_method, &block_for_each)
    end
  end
  alias :params_constructor :param_constructor
end
