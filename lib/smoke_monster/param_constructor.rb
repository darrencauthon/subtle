class Object
  def param_constructor
    self.class_eval('
    def initialize(params={})
      params.each do |attr, value|
        self.public_send("#{attr}=", value)
      end if params
    end')
  end
end
