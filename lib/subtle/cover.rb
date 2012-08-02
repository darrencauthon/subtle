require 'blankslate'

module Subtle
  module CoverMethods
    def initialize(subject)
      @subject = subject
    end

    def method_missing(meth, *args, &blk)
      @subject.send(meth, *args, &blk)
    rescue
      Subtle::Cover.new Object.new
    end

    def the_original_subject
      @subject
    end
  end

  module StrictCoverMethods
    def method_missing(meth, *args, &blk)
      @subject.send(meth, *args, &blk)
    end
  end

  class Cover < ::BlankSlate
    include Subtle::CoverMethods
  end
end
