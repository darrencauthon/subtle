class Proc
  def to_object
    SmokeMonster::LazyCover.new self
  end
end
