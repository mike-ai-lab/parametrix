# PARAMETRIX P-5 v1.0.0_20250105 Strong Reload Command

unique_id = "v1.0.0_20250105"

puts "=" * 60
puts "PARAMETRIX P-5 #{unique_id} STRONG RELOAD INITIATED"
puts "=" * 60

if defined?(PARAMETRIX)
  puts "[P-5 #{unique_id}] Clearing existing PARAMETRIX module..."
  Object.send(:remove_const, :PARAMETRIX)
end

extension_path = File.dirname(__FILE__)
$LOADED_FEATURES.delete_if { |f| f.include?("PARAMETRIX") || f.include?(extension_path) }

load File.join(extension_path, "PARAMETRIX.rb")

puts "[PARAMETRIX P-5 #{unique_id}] Module loaded successfully."
puts "=" * 60