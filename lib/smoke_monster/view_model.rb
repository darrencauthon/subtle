module SmokeMonster
  class ViewModel
    def initialize(subject)
    end

    def method_missing(meth, *args, &blk)
      SmokeMonster::ViewModel.new nil
    end
  end
end
