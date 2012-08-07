class Object
  def param_constructor
    self.class_eval('
    def initialize(params={}, &block)
      params.each do |attr, value|
        self.public_send("#{attr}=", value)
      end if params
      block.call(self) if block
    end')
  end
end
