# PARAMETRIX Toolbar Creation

begin
  if defined?(PARAMETRIX)
    toolbar = UI::Toolbar.new "PARAMETRIX"
    
    cmd = UI::Command.new("PARAMETRIX P-11 Layout Generator") {
      begin
        puts "[PARAMETRIX P-11] Toolbar command executed"
        PARAMETRIX.start_layout_process
      rescue => e
        UI.messagebox("Error: #{e.message}")
      end
    }
  else
    puts "PARAMETRIX module not loaded, skipping toolbar creation"
    return
  end
rescue => e
  puts "Error creating toolbar: #{e.message}"
  return
end

cmd.menu_text = "PARAMETRIX Layout Generator"
cmd.tooltip = "Generate parametric cladding layouts with advanced trimming"
cmd.status_bar_text = "Generate PARAMETRIX cladding layout"
if defined?(cmd)
  small_icon_path = "C:/Users/mshke/BACKUP_LAYOUTS/V121_LAYOUT_DISTRIBUTION/PARAMETRIX_EXTENSION/TB_V005_UNIFIED_16.png"
  large_icon_path = "C:/Users/mshke/BACKUP_LAYOUTS/V121_LAYOUT_DISTRIBUTION/PARAMETRIX_EXTENSION/TB_V005_UNIFIED_24.png"
  
  cmd.small_icon = small_icon_path if File.exist?(small_icon_path)
  cmd.large_icon = large_icon_path if File.exist?(large_icon_path)
  cmd.menu_text = "PARAMETRIX P-11 Layout Generator"
  cmd.tooltip = "Generate parametric cladding layouts with advanced trimming P-11"
  cmd.status_bar_text = "Generate PARAMETRIX P-11 cladding layout"
  
  toolbar.add_item cmd
  toolbar.show
  
  begin
    menu = UI.menu("Extensions")
    menu.add_item(cmd)
    menu.add_separator
    
    help_cmd = UI::Command.new("PARAMETRIX Help & Documentation") {
      extension_dir = File.dirname(File.dirname(__FILE__))
      doc_path = File.join(extension_dir, "PARAMETRIX_Documentation.html")
      if File.exist?(doc_path)
        UI.openURL("file:///#{doc_path.gsub('\\', '/')}")
      else
        UI.messagebox("Documentation file not found")
      end
    }
    help_cmd.menu_text = "PARAMETRIX Help & Documentation"
    help_cmd.tooltip = "Open PARAMETRIX documentation in browser"
    menu.add_item(help_cmd)
  rescue
  end
end