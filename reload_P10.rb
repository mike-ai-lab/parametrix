# PARAMETRIX P-10 Strong Reload Command

puts "=" * 60
puts "PARAMETRIX P-10 STRONG RELOAD INITIATED"
puts "=" * 60

if defined?(PARAMETRIX)
  puts "[P-10] Clearing existing PARAMETRIX module..."
  Object.send(:remove_const, :PARAMETRIX)
end

extension_path = File.dirname(__FILE__)
$LOADED_FEATURES.delete_if { |f| f.include?("PARAMETRIX") || f.include?(extension_path) }

load File.join(extension_path, "PARAMETRIX.rb")

puts "[P-10] PARAMETRIX P-10 loaded successfully!"
puts "Check Extensions menu for 'PARAMETRIX P-10 Layout Generator'"
puts "=" * 60