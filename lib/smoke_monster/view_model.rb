module SmokeMonster
  class ViewModel
    def initialize(subject)
      @subject = subject
    end

    def method_missing(meth, *args, &blk)
      @subject.send(meth, *args, &blk)
    rescue
      SmokeMonster::ViewModel.new nil
    end
  end
end
