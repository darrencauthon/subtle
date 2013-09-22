class Proc
  def exception_raised
    self.call
  rescue => e
    e
  end
end

