module SmokeMonster
  class Cover
    def initialize(subject)
      @subject = subject
    end

    def method_missing(meth, *args, &blk)
      @subject.send(meth, *args, &blk)
    rescue
      SmokeMonster::Cover.new nil
    end

    def the_original_subject
      @subject
    end
  end
end
