# PARAMETRIX Simple Preset Manager
# All presets stored as individual JSON files in extension directory

require 'json'

module PARAMETRIX
  module PresetManager
    
    PRESETS_DIR = File.join(__dir__, '..', '..', 'presets')
    
    def self.ensure_presets_directory
      Dir.mkdir(PRESETS_DIR) unless Dir.exist?(PRESETS_DIR)
      create_default_presets if Dir.empty?(PRESETS_DIR)
    end
    
    def self.create_default_presets
      defaults = {
        "Brick Standard" => {
          length: "800;900;1000",
          height: "100;200",
          thickness: 20.0,
          joint_length: 3.0,
          joint_width: 3.0,
          pattern_type: "running_bond",
          layout_start_direction: "bottom_left",
          start_row_height_index: 1,
          randomize_lengths: true,
          randomize_heights: false,
          cavity_distance: 75.0,
          color_name: "PARAMETRIX-BRICK"
        },
        "Stone Ashlar" => {
          length: "600;800;1000;1200",
          height: "150;200;250",
          thickness: 25.0,
          joint_length: 5.0,
          joint_width: 5.0,
          pattern_type: "running_bond",
          layout_start_direction: "center",
          start_row_height_index: 2,
          randomize_lengths: true,
          randomize_heights: true,
          cavity_distance: 75.0,
          color_name: "PARAMETRIX-STONE",
          enable_top_rail: true,
          enable_bottom_rail: true
        },
        "Panel Stack" => {
          length: "1200;1500",
          height: "300;400;500",
          thickness: 15.0,
          joint_length: 2.0,
          joint_width: 2.0,
          pattern_type: "stack_bond",
          layout_start_direction: "bottom",
          start_row_height_index: 1,
          randomize_lengths: false,
          randomize_heights: false,
          cavity_distance: 75.0,
          color_name: "PARAMETRIX-PANEL"
        }
      }
      
      defaults.each do |name, data|
        File.write(File.join(PRESETS_DIR, "#{name}.json"), JSON.pretty_generate(data))
      end

    end
    
    def self.save_preset(name, settings)
      ensure_presets_directory
      
      preset_data = {
        length: settings["length"].to_s,
        height: settings["height"].to_s,
        thickness: settings["thickness"].to_f,
        joint_length: settings["joint_length"].to_f,
        joint_width: settings["joint_width"].to_f,
        cavity_distance: settings["cavity_distance"].to_f,
        pattern_type: settings["pattern_type"].to_s,
        layout_start_direction: settings["layout_start"].to_s,
        start_row_height_index: settings["height_index"].to_i,
        color_name: settings["material_name"].to_s,
        randomize_lengths: !!settings["randomize_lengths"],
        randomize_heights: !!settings["randomize_heights"],
        enable_top_rail: !!settings["enable_top_rail"],
        top_rail_thickness: settings["top_rail_thickness"].to_f,
        top_rail_depth: settings["top_rail_depth"].to_f,
        enable_bottom_rail: !!settings["enable_bottom_rail"],
        bottom_rail_thickness: settings["bottom_rail_thickness"].to_f,
        bottom_rail_depth: settings["bottom_rail_depth"].to_f,
        rail_color_name: settings["rail_material_name"].to_s,
        split_rails: !!settings["split_rails"],
        synchronize_patterns: !!settings["synchronize_patterns"],
        force_horizontal_layout: !!settings["force_horizontal"],
        preserve_corners: !!settings["preserve_corners"],
        single_row_mode: !!settings["single_row_mode"],
        min_piece_length: settings["min_piece_length"].to_f
      }
      
      file_path = File.join(PRESETS_DIR, "#{name}.json")
      File.write(file_path, JSON.pretty_generate(preset_data))
      true
    rescue => e
      false
    end
    
    def self.load_preset(name)
      file_path = File.join(PRESETS_DIR, "#{name}.json")
      return nil unless File.exist?(file_path)
      
      JSON.parse(File.read(file_path), symbolize_names: true)
    rescue => e
      nil
    end
    
    def self.delete_preset(name)
      file_path = File.join(PRESETS_DIR, "#{name}.json")
      return false unless File.exist?(file_path)
      
      File.delete(file_path)
      true
    rescue => e
      false
    end
    
    def self.list_presets
      ensure_presets_directory
      
      presets = []
      Dir.glob(File.join(PRESETS_DIR, "*.json")).each do |file|
        presets << File.basename(file, ".json")
      end
      
      presets.sort
    end
    
    def self.apply_preset_to_globals(preset_data)
      return false unless preset_data
      
      PARAMETRIX.class_variable_set(:@@length, preset_data[:length]) if preset_data[:length]
      PARAMETRIX.class_variable_set(:@@height, preset_data[:height]) if preset_data[:height]
      PARAMETRIX.class_variable_set(:@@thickness, preset_data[:thickness]) if preset_data[:thickness]
      PARAMETRIX.class_variable_set(:@@joint_length, preset_data[:joint_length]) if preset_data[:joint_length]
      PARAMETRIX.class_variable_set(:@@joint_width, preset_data[:joint_width]) if preset_data[:joint_width]
      PARAMETRIX.class_variable_set(:@@cavity_distance, preset_data[:cavity_distance]) if preset_data[:cavity_distance]
      PARAMETRIX.class_variable_set(:@@pattern_type, preset_data[:pattern_type]) if preset_data[:pattern_type]
      PARAMETRIX.class_variable_set(:@@layout_start_direction, preset_data[:layout_start_direction]) if preset_data[:layout_start_direction]
      PARAMETRIX.class_variable_set(:@@start_row_height_index, preset_data[:start_row_height_index]) if preset_data[:start_row_height_index]
      PARAMETRIX.class_variable_set(:@@color_name, preset_data[:color_name]) if preset_data[:color_name]
      PARAMETRIX.class_variable_set(:@@randomize_lengths, preset_data[:randomize_lengths]) if preset_data.key?(:randomize_lengths)
      PARAMETRIX.class_variable_set(:@@randomize_heights, preset_data[:randomize_heights]) if preset_data.key?(:randomize_heights)
      PARAMETRIX.class_variable_set(:@@enable_top_rail, preset_data[:enable_top_rail]) if preset_data.key?(:enable_top_rail)
      PARAMETRIX.class_variable_set(:@@top_rail_thickness, preset_data[:top_rail_thickness]) if preset_data[:top_rail_thickness]
      PARAMETRIX.class_variable_set(:@@top_rail_depth, preset_data[:top_rail_depth]) if preset_data[:top_rail_depth]
      PARAMETRIX.class_variable_set(:@@enable_bottom_rail, preset_data[:enable_bottom_rail]) if preset_data.key?(:enable_bottom_rail)
      PARAMETRIX.class_variable_set(:@@bottom_rail_thickness, preset_data[:bottom_rail_thickness]) if preset_data[:bottom_rail_thickness]
      PARAMETRIX.class_variable_set(:@@bottom_rail_depth, preset_data[:bottom_rail_depth]) if preset_data[:bottom_rail_depth]
      PARAMETRIX.class_variable_set(:@@rail_color_name, preset_data[:rail_color_name]) if preset_data[:rail_color_name]
      PARAMETRIX.class_variable_set(:@@split_rails, preset_data[:split_rails]) if preset_data.key?(:split_rails)
      PARAMETRIX.class_variable_set(:@@synchronize_patterns, preset_data[:synchronize_patterns]) if preset_data.key?(:synchronize_patterns)
      PARAMETRIX.class_variable_set(:@@force_horizontal_layout, preset_data[:force_horizontal_layout]) if preset_data.key?(:force_horizontal_layout)
      PARAMETRIX.class_variable_set(:@@preserve_corners, preset_data[:preserve_corners]) if preset_data.key?(:preserve_corners)
      PARAMETRIX.class_variable_set(:@@single_row_mode, preset_data[:single_row_mode]) if preset_data.key?(:single_row_mode)
      
      true
    end
    
  end
end