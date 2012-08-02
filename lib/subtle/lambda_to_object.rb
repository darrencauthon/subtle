class Proc
  def to_object
    Subtle::LazyCover.new self
  end
end
