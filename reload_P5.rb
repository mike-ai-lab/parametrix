# PARAMETRIX P-5 Strong Reload Command
# Use this to force reload the latest version

puts "=" * 60
puts "PARAMETRIX P-5 STRONG RELOAD INITIATED"
puts "=" * 60

# Clear all PARAMETRIX related constants and loaded features
if defined?(PARAMETRIX)
  puts "[P-5] Clearing existing PARAMETRIX module..."
  Object.send(:remove_const, :PARAMETRIX)
end

# Clear loaded features
extension_path = File.dirname(__FILE__)
$LOADED_FEATURES.delete_if { |f| f.include?("PARAMETRIX") || f.include?(extension_path) }

# Force reload main extension
load File.join(extension_path, "PARAMETRIX.rb")

puts "[P-5] PARAMETRIX P-5 loaded successfully!"
puts "Check Extensions menu for 'PARAMETRIX P-5 Layout Generator'"
puts "=" * 60