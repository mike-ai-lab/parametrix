# PARAMETRIX Strong Loader P-24
# Entry point with cache clearing and forced reload

module PARAMETRIX
  def self.force_reload
    puts "[PARAMETRIX P-24] Force reloading all modules..."
    
    # Clear module constants to force reload
    if defined?(PARAMETRIX)
      PARAMETRIX.constants.each do |const|
        PARAMETRIX.send(:remove_const, const) if PARAMETRIX.const_defined?(const)
      end
    end
    
    # Remove from loaded features to force fresh load
    base_dir = File.dirname(__FILE__)
    files_to_reload = [
      'core.rb', 'preset_manager.rb', 'multi_face_position.rb', 
      'ui_dialog_newui.rb', 'layout_engine.rb', 'commands.rb', 'toolbar.rb'
    ]
    
    files_to_reload.each do |file|
      full_path = File.join(base_dir, file)
      $LOADED_FEATURES.delete_if { |f| f.include?(file) }
      load full_path if File.exist?(full_path)
    end
    
    puts "[PARAMETRIX P-24] All modules reloaded successfully"
  end
  
  LOADER_VERSION = "P-24"
end

# Force reload and load all components
PARAMETRIX.force_reload

require File.join(__dir__, 'core.rb')
require File.join(__dir__, 'preset_manager.rb')
require File.join(__dir__, 'multi_face_position.rb')
require File.join(__dir__, 'ui_dialog_newui.rb')
require File.join(__dir__, 'layout_engine.rb')
require File.join(__dir__, 'commands.rb')
require File.join(__dir__, 'toolbar.rb')