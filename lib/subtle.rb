require File.dirname(__FILE__) + '/subtle/cover.rb'
Dir[File.dirname(__FILE__) + '/subtle/*.rb'].each {|file| require file }

module Subtle
end
