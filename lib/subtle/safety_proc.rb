class Proc
  def call_safely
    self.call
  rescue
    yield if block_given?
  end
end
