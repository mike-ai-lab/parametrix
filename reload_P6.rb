# PARAMETRIX P-6 Strong Reload Command

puts "=" * 60
puts "PARAMETRIX P-6 STRONG RELOAD INITIATED"
puts "=" * 60

if defined?(PARAMETRIX)
  puts "[P-6] Clearing existing PARAMETRIX module..."
  Object.send(:remove_const, :PARAMETRIX)
end

extension_path = File.dirname(__FILE__)
$LOADED_FEATURES.delete_if { |f| f.include?("PARAMETRIX") || f.include?(extension_path) }

load File.join(extension_path, "PARAMETRIX.rb")

puts "[P-6] PARAMETRIX P-6 loaded successfully!"
puts "Check Extensions menu for 'PARAMETRIX P-6 Layout Generator'"
puts "=" * 60