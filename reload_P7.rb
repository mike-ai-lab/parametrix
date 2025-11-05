# PARAMETRIX P-7 Strong Reload Command

puts "=" * 60
puts "PARAMETRIX P-7 STRONG RELOAD INITIATED"
puts "=" * 60

if defined?(PARAMETRIX)
  puts "[P-7] Clearing existing PARAMETRIX module..."
  Object.send(:remove_const, :PARAMETRIX)
end

extension_path = File.dirname(__FILE__)
$LOADED_FEATURES.delete_if { |f| f.include?("PARAMETRIX") || f.include?(extension_path) }

load File.join(extension_path, "PARAMETRIX.rb")

puts "[P-7] PARAMETRIX P-7 loaded successfully!"
puts "Check Extensions menu for 'PARAMETRIX P-7 Layout Generator'"
puts "=" * 60