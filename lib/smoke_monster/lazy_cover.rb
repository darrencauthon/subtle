module SmokeMonster
  class LazyCover < Cover
    def initialize(block)
      @block = block
    end

    alias :old_the_original_subject :the_original_subject
    def the_original_subject
      @subject = @block.call
      old_the_original_subject
    end

    private

    alias :old_method_missing :method_missing
    def method_missing(meth, *args, &blk)
      @subject = @block.call if @subject.nil?
      old_method_missing meth, *args, &blk
    end

  end
end
