require 'blankslate'

module SmokeMonster

  module CoverMethods
    def initialize(subject)
      @subject = subject
    end

    def method_missing(meth, *args, &blk)
      @subject.send(meth, *args, &blk)
    rescue
      SmokeMonster::Cover.new Object.new
    end

    def the_original_subject
      @subject
    end
  end

  class Cover < ::BlankSlate
    include SmokeMonster::CoverMethods
  end
end
