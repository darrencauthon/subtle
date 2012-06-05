guard 'minitest' do
  watch(%r|^test/test_(.*)\.rb|)
  watch(%r|^lib/(.*)([^/]+)\.rb|)     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r|^test/test_helper\.rb|)    { "test" }
  watch(%r|^lib/(.*)\.rb|)            { |m| "test/test_#{m[1]}.rb" }

  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})         { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^lib/smoke_monster/(.+)\.rb$})         { |m| "spec/smoke_monster/#{m[1]}_spec.rb" }
  watch(%r{^spec/models/.+\.rb$})   { ["spec/models", "spec/acceptance"] }
  watch('spec/spec_helper.rb')      { "spec" }
end
