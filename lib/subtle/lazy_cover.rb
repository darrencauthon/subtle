module Subtle
  class LazyCover < Cover
    include Subtle::StrictCoverMethods

    def initialize(block)
      @block = block
    end

    alias :the_original_subject_from_the_base_class :the_original_subject
    def the_original_subject
      setup_the_subject
      the_original_subject_from_the_base_class
    end

    private

    alias :old_method_missing :method_missing
    def method_missing(meth, *args, &blk)
      setup_the_subject
      old_method_missing meth, *args, &blk
    end

    def setup_the_subject
      @subject = @block.call if @subject.nil?
    end
  end
end
