class Proc
  def exception_raised
    self.call
    nil
  rescue => e
    e
  end
end

