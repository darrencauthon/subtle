module SmokeMonster
  class LazyCover < Cover
    def initialize(block)
      @block = block
    end

    alias :the_original_subject_from_the_base_class :the_original_subject
    def the_original_subject
      @subject = @block.call
      the_original_subject_from_the_base_class
    end

    private

    alias :old_method_missing :method_missing
    def method_missing(meth, *args, &blk)
      @subject = @block.call if @subject.nil?
      old_method_missing meth, *args, &blk
    end

  end
end
