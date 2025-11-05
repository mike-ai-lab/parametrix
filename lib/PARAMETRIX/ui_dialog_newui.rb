# PARAMETRIX UI Dialog Management - NEW UI
# Handles HTML dialog display and parameter management with improved interface

module PARAMETRIX

  def self.show_html_dialog(multi_face_position)
    @@current_multi_face_position = multi_face_position
    
    unit_name = get_effective_unit
    
    html = <<-HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PARAMETRIX Layout Generator</title>
    <style>
        /* Embedded Tailwind-like CSS for offline functionality */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        .flex { display: flex; }
        .flex-col { flex-direction: column; }
        .grid { display: grid; }
        .grid-cols-1 { grid-template-columns: repeat(1, minmax(0, 1fr)); }
        .grid-cols-2 { grid-template-columns: repeat(2, minmax(0, 1fr)); }
        .gap-2 { gap: 0.5rem; }
        .gap-3 { gap: 0.75rem; }
        .gap-4 { gap: 1rem; }
        .mb-1 { margin-bottom: 0.25rem; }
        .mb-2 { margin-bottom: 0.5rem; }
        .mb-3 { margin-bottom: 0.75rem; }
        .mr-2 { margin-right: 0.5rem; }
        .mt-1 { margin-top: 0.25rem; }
        .p-2 { padding: 0.5rem; }
        .px-3 { padding-left: 0.75rem; padding-right: 0.75rem; }
        .px-4 { padding-left: 1rem; padding-right: 1rem; }
        .py-1 { padding-top: 0.25rem; padding-bottom: 0.25rem; }
        .py-2 { padding-top: 0.5rem; padding-bottom: 0.5rem; }
        .text-xs { font-size: 0.75rem; }
        .text-sm { font-size: 0.875rem; }
        .font-medium { font-weight: 500; }
        .font-semibold { font-weight: 600; }
        .text-white { color: #ffffff; }
        .text-gray-600 { color: #6b7280; }
        .text-gray-700 { color: #374151; }
        .text-charcoal { color: #1f2937; }
        .bg-charcoal { background-color: #1f2937; }
        .bg-charcoal-light { background-color: #374151; }
        .bg-cobalt { background-color: #1e40af; }
        .bg-cobalt-light { background-color: #3b82f6; }
        .hover\\:bg-charcoal:hover { background-color: #1f2937; }
        .hover\\:bg-cobalt:hover { background-color: #1e40af; }
        .tab-active { 
            background: #1f2937;
            color: white;
            border: 1px solid #1f2937;
        }
        .tab-inactive { 
            background: #f9fafb;
            color: #6b7280;
            border: 1px solid #d1d5db;
        }
        .tab-inactive:hover { 
            background: #f3f4f6;
            color: #374151;
            border: 1px solid #9ca3af;
        }
        .disabled { opacity: 0.5; pointer-events: none; }
        .success-toast { position: fixed; top: 20px; right: 20px; background: #10b981; color: white; padding: 12px 20px; border-radius: 8px; z-index: 1000; animation: slideIn 0.3s ease; }
        @keyframes slideIn { from { transform: translateX(100%); } to { transform: translateX(0); } }
        .bg-gray-600 { background-color: #4b5563; }
        .bg-gray-700 { background-color: #374151; }
        .border { border-width: 1px; }
        .border-gray-300 { border-color: #d1d5db; }
        .rounded { border-radius: 0.25rem; }
        .rounded-lg { border-radius: 0.5rem; }
        .shadow-lg { box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); }
        .hover\\:bg-blue-700:hover { background-color: #1d4ed8; }
        .hover\\:bg-green-700:hover { background-color: #15803d; }
        .hover\\:bg-gray-700:hover { background-color: #374151; }
        .cursor-pointer { cursor: pointer; }
        .w-full { width: 100%; }
        .h-4 { height: 1rem; }
        .w-4 { width: 1rem; }
        .justify-center { justify-content: center; }
        .items-center { align-items: center; }
        .col-span-2 { grid-column: span 2 / span 2; }
        .block { display: block; }
        .transition { transition-property: all; transition-duration: 150ms; }
    </style>
    <style>
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        .dialog-container {
            width: 100%;
            max-width: 500px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            max-height: 90vh; 
        }

        .content-area {
            overflow-y: auto;
            padding: 15px;
            flex-grow: 1;
        }
        .setting-group {
            margin-bottom: 15px;
            padding: 12px;
            border: 1px solid #e5e7eb;
            border-radius: 6px;
            background: #fafafa;
        }
        .setting-group-title {
            font-size: 14px;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 10px;
            padding-bottom: 6px;
            border-bottom: 1px solid #e5e7eb;
            letter-spacing: 0.025em;
        }
        .dialog-title {
            font-size: 18px;
            font-weight: 700;
            color: #1f2937;
            text-align: center;
            margin-bottom: 20px;
            letter-spacing: 0.05em;
        }
        .tooltip {
            position: relative;
            display: inline-block;
        }
        .tooltip .tooltiptext {
            visibility: hidden;
            width: 200px;
            background-color: #333;
            color: #fff;
            text-align: center;
            border-radius: 4px;
            padding: 5px;
            position: absolute;
            z-index: 1;
            bottom: 125%;
            left: 50%;
            margin-left: -100px;
            opacity: 0;
            transition: opacity 0.3s;
            font-size: 11px;
        }
        .tooltip:hover .tooltiptext {
            visibility: visible;
            opacity: 1;
        }
        .help-icon {
            display: inline-block;
            width: 14px;
            height: 14px;
            background: #6b7280;
            color: white;
            border-radius: 50%;
            text-align: center;
            font-size: 10px;
            line-height: 14px;
            margin-left: 4px;
            cursor: help;
        }
        .form-field input[type="text"], .form-field select {
            padding: 8px 12px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 13px;
            width: 100%;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-field input[type="text"]:focus, .form-field select:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2);
            outline: none;
        }

        .dialog-footer a {
            color: #94a3b8;
            text-decoration: none;
            margin: 0 5px;
        }

    </style>
</head>
<body>

<div class="dialog-container">
    <div class="content-area">
        <!-- Preset Manager at Top -->
        <div class="setting-group">
            <div class="setting-group-title">Quick Presets</div>
            <div class="grid grid-cols-2 gap-2 mb-3">
                <select id="preset_dropdown" class="form-field rounded-lg" style="padding: 8px 12px; font-size: 13px;">
                    <option value="">Select a preset...</option>
                </select>
                <button id="load_preset_btn" class="px-3 py-2 bg-charcoal text-white rounded text-xs hover:bg-charcoal-light w-full">Load Preset</button>
            </div>
            <div class="grid grid-cols-2 gap-2">
                <input type="text" id="preset_name" placeholder="Preset Name" class="form-field rounded-lg" style="padding: 8px 12px; font-size: 13px; opacity: 0.7;" />
                <button id="save_preset_btn" class="px-3 py-2 bg-charcoal text-white rounded text-xs hover:bg-charcoal-light">Save Preset</button>
            </div>
        </div>

        <div class="dialog-title">PARAMETRIX P-11</div>
        <div style="text-align: center; font-size: 10px; color: #9ca3af; opacity: 0.6; margin-top: -10px; margin-bottom: 15px;">P-11 | Developed by: Int. Arch. M.Shkeir</div>
        
        <!-- Layout Tabs -->
        <div class="setting-group">
            <div class="setting-group-title">Layout Mode</div>
            <div class="flex gap-3 justify-center">
                <button id="multi_row_tab" class="px-8 py-3 text-sm font-medium tab-active transition" style="min-width: 140px;">Multi-Row Layout</button>
                <button id="single_row_tab" class="px-8 py-3 text-sm font-medium tab-inactive transition" style="min-width: 140px;">Single-Row Layout</button>
            </div>
        </div>
        <!-- Panel Dimensions & Joints -->
        <div class="setting-group">
            <div class="setting-group-title">Panel Dimensions & Joints (Units in #{unit_name})</div>
                <div class="grid grid-cols-2 gap-x-4 gap-y-3">
                    <div class="form-field col-span-2">
                        <label for="length" class="text-xs font-medium text-gray-600 mb-1 block">Panel Lengths (Semicolon-Separated List: e.g., 800;1000)</label>
                        <input type="text" id="length" value="#{@@length}" class="rounded-lg" />
                    </div>
                    <div class="form-field col-span-2">
                        <label for="height" class="text-xs font-medium text-gray-600 mb-1 block">Panel Heights (Semicolon-Separated List: e.g., 100;200)</label>
                        <input type="text" id="height" value="#{@@height}" class="rounded-lg" />
                    </div>
                    <div class="form-field">
                        <label for="thickness" class="text-xs font-medium text-gray-600 mb-1 block">Panel Thickness (#{unit_name})</label>
                        <input type="text" id="thickness" value="#{@@thickness}" class="rounded-lg" />
                    </div>
                    <div class="form-field">
                        <label for="joint_length" class="text-xs font-medium text-gray-600 mb-1 block">Horizontal Joints (mm)</label>
                        <input type="text" id="joint_length" value="#{@@joint_length}" class="rounded-lg" />
                    </div>
                    <div class="form-field">
                        <label for="joint_width" class="text-xs font-medium text-gray-600 mb-1 block">Vertical Joints (mm)</label>
                        <input type="text" id="joint_width" value="#{@@joint_width}" class="rounded-lg" />
                    </div>
                    <div class="form-field">
                        <label for="cavity_distance" class="text-xs font-medium text-gray-600 mb-1 block">Cavity Distance</label>
                        <input type="text" id="cavity_distance" value="75" />
                    </div>
                    <div class="form-field">
                        <label for="min_piece_length" class="text-xs font-medium text-gray-600 mb-1 block">Min Piece Length (#{unit_name})</label>
                        <input type="text" id="min_piece_length" value="#{@@enable_min_piece_length ? @@min_piece_length : 0}" />
                    </div>
                    <div class="form-field col-span-2">
                        <label for="color_name" class="text-xs font-medium text-gray-600 mb-1 block">Material Name</label>
                        <input type="text" id="color_name" value="#{@@color_name}" />
                    </div>
                </div>
            </div>

            <div class="setting-group">
                <div class="setting-group-title">Pattern, Placement & Randomization</div>
                <div class="grid grid-cols-2 gap-x-4 gap-y-3">
                    <div class="form-field">
                        <label for="pattern_type" class="text-xs font-medium text-gray-600 mb-1 block">Pattern Type</label>
                        <select id="pattern_type">
                            <option value="running_bond" #{@@pattern_type == 'running_bond' ? 'selected' : ''}>Running Bond</option>
                            <option value="stack_bond" #{@@pattern_type == 'stack_bond' ? 'selected' : ''}>Stack Bond</option>
                        </select>
                    </div>
                    <div class="form-field col-span-2">
                        <label for="layout_start_direction" class="text-xs font-medium text-gray-600 mb-1 block">
                            Layout Start Direction
                            <span class="tooltip">
                                <span class="help-icon">?</span>
                                <span class="tooltiptext">Controls where the layout pattern starts. Layout always builds upward and rightward from the start position.</span>
                            </span>
                        </label>
                        <select id="layout_start_direction">
                            <option value="center" #{@@layout_start_direction == 'center' ? 'selected' : ''}>Center</option>
                            <option value="top_left" #{@@layout_start_direction == 'top_left' ? 'selected' : ''}>Top Left</option>
                            <option value="top" #{@@layout_start_direction == 'top' ? 'selected' : ''}>Top</option>
                            <option value="top_right" #{@@layout_start_direction == 'top_right' ? 'selected' : ''}>Top Right</option>
                            <option value="left" #{@@layout_start_direction == 'left' ? 'selected' : ''}>Left</option>
                            <option value="right" #{@@layout_start_direction == 'right' ? 'selected' : ''}>Right</option>
                            <option value="bottom_left" #{@@layout_start_direction == 'bottom_left' ? 'selected' : ''}>Bottom Left</option>
                            <option value="bottom" #{@@layout_start_direction == 'bottom' ? 'selected' : ''}>Bottom</option>
                            <option value="bottom_right" #{@@layout_start_direction == 'bottom_right' ? 'selected' : ''}>Bottom Right</option>
                        </select>
                    </div>
                    <div class="form-field col-span-2" id="height_index_field">
                        <label for="height_index" class="text-xs font-medium text-gray-600 mb-1 block">
                            First Row Height Index
                            <span class="tooltip">
                                <span class="help-icon">?</span>
                                <span class="tooltiptext">Which height from your list to use for the bottom row (1-based). Example: if heights are [100,200,300] and index is 2, bottom row uses 200.</span>
                            </span>
                        </label>
                        <input type="text" id="height_index" value="#{@@start_row_height_index}" placeholder="1" />
                    </div>
                    <div class="col-span-2 flex items-center mt-1">
                        <input type="checkbox" id="randomize_lengths" class="mr-2 h-4 w-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" #{@@randomize_lengths ? 'checked' : ''} />
                        <label for="randomize_lengths" class="text-sm text-gray-700">Randomize Panel Lengths</label>
                    </div>
                    <div class="col-span-2 flex items-center" id="randomize_heights_field">
                        <input type="checkbox" id="randomize_heights" class="mr-2 h-4 w-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" #{@@randomize_heights ? 'checked' : ''} />
                        <label for="randomize_heights" class="text-sm text-gray-700">Randomize Panel Heights</label>
                    </div>
                </div>
            </div>



            <div class="setting-group">
                <div class="setting-group-title">Multi-Face & Corner Options</div>
                <div class="flex flex-col gap-2">
                    <div class="flex items-center">
                        <input type="checkbox" id="synchronize_patterns" class="mr-2 h-4 w-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" #{@@synchronize_patterns ? 'checked' : ''} />
                        <label for="synchronize_patterns" class="text-sm text-gray-700">
                            Synchronize Patterns
                            <span class="tooltip">
                                <span class="help-icon">?</span>
                                <span class="tooltiptext">Creates seamless layout across all selected faces</span>
                            </span>
                        </label>
                    </div>
                    <div class="flex items-center">
                        <input type="checkbox" id="force_horizontal" class="mr-2 h-4 w-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" #{@@force_horizontal_layout ? 'checked' : ''} />
                        <label for="force_horizontal" class="text-sm text-gray-700">
                            Force Horizontal Layout
                            <span class="tooltip">
                                <span class="help-icon">?</span>
                                <span class="tooltiptext">Ignores face tilt and forces horizontal orientation</span>
                            </span>
                        </label>
                    </div>
                    <div class="flex items-center">
                        <input type="checkbox" id="preserve_corners" class="mr-2 h-4 w-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" #{@@preserve_corners ? 'checked' : ''} />
                        <label for="preserve_corners" class="text-sm text-gray-700">
                            Preserve Corners
                            <span class="tooltip">
                                <span class="help-icon">?</span>
                                <span class="tooltiptext">Generates unique corner pieces for better fit</span>
                            </span>
                        </label>
                    </div>
                    <div class="flex items-center">
                        <input type="checkbox" id="use_flat_grouping" class="mr-2 h-4 w-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" #{@@use_flat_grouping ? 'checked' : ''} />
                        <label for="use_flat_grouping" class="text-sm text-gray-700">
                            Flat Grouping (Solid Groups)
                            <span class="tooltip">
                                <span class="help-icon">?</span>
                                <span class="tooltiptext">Creates separate solid groups for layout and rails</span>
                            </span>
                        </label>
                    </div>
                </div>
            </div>

            <div class="setting-group">
                <div class="setting-group-title">Rail Settings</div>
                <div class="grid grid-cols-2 gap-x-4 gap-y-3">
                    <div class="flex flex-col">
                        <div class="flex items-center mb-2">
                            <input type="checkbox" id="enable_top_rail_multi" class="mr-2 h-4 w-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" #{@@enable_top_rail ? 'checked' : ''} />
                            <label for="enable_top_rail_multi" class="text-sm font-semibold text-gray-700">Enable Top Rail</label>
                        </div>
                        <div class="form-field mb-2">
                            <label for="top_rail_thickness_multi" class="text-xs font-medium text-gray-600 mb-1 block">Top Rail Thickness</label>
                            <input type="text" id="top_rail_thickness_multi" value="#{@@top_rail_thickness}" />
                        </div>
                        <div class="form-field">
                            <label for="top_rail_depth_multi" class="text-xs font-medium text-gray-600 mb-1 block">Top Rail Depth</label>
                            <input type="text" id="top_rail_depth_multi" value="#{@@top_rail_depth}" />
                        </div>
                    </div>
                    <div class="flex flex-col">
                        <div class="flex items-center mb-2">
                            <input type="checkbox" id="enable_bottom_rail_multi" class="mr-2 h-4 w-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" #{@@enable_bottom_rail ? 'checked' : ''} />
                            <label for="enable_bottom_rail_multi" class="text-sm font-semibold text-gray-700">Enable Bottom Rail</label>
                        </div>
                        <div class="form-field mb-2">
                            <label for="bottom_rail_thickness_multi" class="text-xs font-medium text-gray-600 mb-1 block">Bottom Rail Thickness</label>
                            <input type="text" id="bottom_rail_thickness_multi" value="#{@@bottom_rail_thickness}" />
                        </div>
                        <div class="form-field">
                            <label for="bottom_rail_depth_multi" class="text-xs font-medium text-gray-600 mb-1 block">Bottom Rail Depth</label>
                            <input type="text" id="bottom_rail_depth_multi" value="#{@@bottom_rail_depth}" />
                        </div>
                    </div>
                    <div class="flex flex-col">
                        <div class="flex items-center mb-2">
                            <input type="checkbox" id="enable_left_rail_multi" class="mr-2 h-4 w-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" #{@@enable_left_rail ? 'checked' : ''} />
                            <label for="enable_left_rail_multi" class="text-sm font-semibold text-gray-700">Enable Left Rail</label>
                        </div>
                        <div class="form-field mb-2">
                            <label for="left_rail_thickness_multi" class="text-xs font-medium text-gray-600 mb-1 block">Left Rail Thickness</label>
                            <input type="text" id="left_rail_thickness_multi" value="#{@@left_rail_thickness}" />
                        </div>
                        <div class="form-field">
                            <label for="left_rail_depth_multi" class="text-xs font-medium text-gray-600 mb-1 block">Left Rail Depth</label>
                            <input type="text" id="left_rail_depth_multi" value="#{@@left_rail_depth}" />
                        </div>
                    </div>
                    <div class="flex flex-col">
                        <div class="flex items-center mb-2">
                            <input type="checkbox" id="enable_right_rail_multi" class="mr-2 h-4 w-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" #{@@enable_right_rail ? 'checked' : ''} />
                            <label for="enable_right_rail_multi" class="text-sm font-semibold text-gray-700">Enable Right Rail</label>
                        </div>
                        <div class="form-field mb-2">
                            <label for="right_rail_thickness_multi" class="text-xs font-medium text-gray-600 mb-1 block">Right Rail Thickness</label>
                            <input type="text" id="right_rail_thickness_multi" value="#{@@right_rail_thickness}" />
                        </div>
                        <div class="form-field">
                            <label for="right_rail_depth_multi" class="text-xs font-medium text-gray-600 mb-1 block">Right Rail Depth</label>
                            <input type="text" id="right_rail_depth_multi" value="#{@@right_rail_depth}" />
                        </div>
                    </div>
                    <div class="col-span-2 flex items-center mt-2">
                        <input type="checkbox" id="split_rails_multi" class="mr-2 h-4 w-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500" #{@@split_rails ? 'checked' : ''} />
                        <label for="split_rails_multi" class="text-sm font-semibold text-gray-700">Split Rails into Pieces</label>
                    </div>
                    <div class="form-field col-span-2">
                        <label for="rail_material_name_multi" class="text-xs font-medium text-gray-600 mb-1 block">Rail Material Name</label>
                        <input type="text" id="rail_material_name_multi" value="#{@@rail_color_name}" />
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Action Buttons -->
        <div class="setting-group">
            <div class="flex justify-center gap-4 w-full mb-3">
                <button id="previewBtn" class="px-4 py-2 bg-gray-600 text-white font-medium rounded shadow hover:bg-gray-700 transition text-sm w-full">Preview Layout</button>
                <button id="generateBtn" class="px-4 py-2 bg-charcoal text-white font-medium rounded shadow hover:bg-charcoal-light transition text-sm w-full">Generate Layout</button>
            </div>
            <div class="flex justify-center">
                <button id="helpBtn" class="px-3 py-1 bg-gray-500 text-white text-xs rounded hover:bg-gray-600 transition">📖 Help & Documentation</button>
            </div>
        </div>
    </div>
</div>

<script>
    // Global variables
    let currentMode = 'multi_row';
    
    // Tab functionality
    function switchTab(mode) {
        currentMode = mode;
        const multiTab = document.getElementById('multi_row_tab');
        const singleTab = document.getElementById('single_row_tab');
        
        if (mode === 'multi_row') {
            multiTab.className = 'px-8 py-3 text-sm font-medium tab-active transition';
            singleTab.className = 'px-8 py-3 text-sm font-medium tab-inactive transition';
        } else {
            multiTab.className = 'px-8 py-3 text-sm font-medium tab-inactive transition';
            singleTab.className = 'px-8 py-3 text-sm font-medium tab-active transition';
        }
        toggleSingleRowFields();
    }
    
    function toggleSingleRowFields() {
        const isSingleRow = currentMode === 'single_row';
        const heightIndexField = document.getElementById('height_index_field');
        const randomizeHeightsField = document.getElementById('randomize_heights_field');
        
        if (isSingleRow) {
            heightIndexField.classList.add('disabled');
            randomizeHeightsField.classList.add('disabled');
            document.getElementById('height_index').disabled = true;
            document.getElementById('randomize_heights').disabled = true;
        } else {
            heightIndexField.classList.remove('disabled');
            randomizeHeightsField.classList.remove('disabled');
            document.getElementById('height_index').disabled = false;
            document.getElementById('randomize_heights').disabled = false;
        }
    }
    
    document.addEventListener('DOMContentLoaded', function() {
        sketchup.get_user_presets();
        setTimeout(function() { sketchup.get_user_presets(); }, 100);
        
        // Set up tab event listeners
        document.getElementById('multi_row_tab').addEventListener('click', () => switchTab('multi_row'));
        document.getElementById('single_row_tab').addEventListener('click', () => switchTab('single_row'));
        
        // Initial setup
        toggleSingleRowFields();
    });

    function collectSettings() {
        const isSingleRow = currentMode === 'single_row';
        
        return {
            single_row_mode: isSingleRow,
            length: document.getElementById('length').value || '',
            height: document.getElementById('height').value || '',
            thickness: parseFloat(document.getElementById('thickness').value) || 0,
            joint_length: parseFloat(document.getElementById('joint_length').value) || 0,
            joint_width: parseFloat(document.getElementById('joint_width').value) || 0,
            cavity_distance: parseFloat(document.getElementById('cavity_distance').value) || 0,
            pattern_type: document.getElementById('pattern_type').value || 'running_bond',
            layout_start: document.getElementById('layout_start_direction').value || 'center',
            height_index: parseInt(document.getElementById('height_index').value) || 1,
            material_name: document.getElementById('color_name').value || '',
            randomize_lengths: document.getElementById('randomize_lengths').checked,
            randomize_heights: document.getElementById('randomize_heights').checked,
            enable_top_rail: document.getElementById('enable_top_rail_multi').checked,
            top_rail_thickness: parseFloat(document.getElementById('top_rail_thickness_multi').value) || 0,
            top_rail_depth: parseFloat(document.getElementById('top_rail_depth_multi').value) || 0,
            enable_bottom_rail: document.getElementById('enable_bottom_rail_multi').checked,
            bottom_rail_thickness: parseFloat(document.getElementById('bottom_rail_thickness_multi').value) || 0,
            bottom_rail_depth: parseFloat(document.getElementById('bottom_rail_depth_multi').value) || 0,
            enable_left_rail: document.getElementById('enable_left_rail_multi').checked,
            left_rail_thickness: parseFloat(document.getElementById('left_rail_thickness_multi').value) || 0,
            left_rail_depth: parseFloat(document.getElementById('left_rail_depth_multi').value) || 0,
            enable_right_rail: document.getElementById('enable_right_rail_multi').checked,
            right_rail_thickness: parseFloat(document.getElementById('right_rail_thickness_multi').value) || 0,
            right_rail_depth: parseFloat(document.getElementById('right_rail_depth_multi').value) || 0,
            rail_material_name: document.getElementById('rail_material_name_multi').value || '',
            split_rails: document.getElementById('split_rails_multi').checked,
            synchronize_patterns: document.getElementById('synchronize_patterns').checked,
            force_horizontal: document.getElementById('force_horizontal').checked,
            preserve_corners: document.getElementById('preserve_corners').checked,
            use_flat_grouping: document.getElementById('use_flat_grouping').checked,
            min_piece_length: parseFloat(document.getElementById('min_piece_length').value) || 0
        };
    }

    document.getElementById('generateBtn').addEventListener('click', function() {
        const settings = collectSettings();
        sketchup.apply_settings(JSON.stringify(settings));
    });

    document.getElementById('helpBtn').addEventListener('click', function() {
        sketchup.open_documentation();
    });

    document.getElementById('previewBtn').addEventListener('click', function() {
        const settings = collectSettings();
        settings.preview = true;
        sketchup.apply_settings(JSON.stringify(settings));
    });

    // Load preset button
    document.getElementById('load_preset_btn').addEventListener('click', function() {
        const selectedPreset = document.getElementById('preset_dropdown').value;
        if (!selectedPreset) {
            alert('Please select a preset first');
            return;
        }
        sketchup.load_preset(selectedPreset);
    });
    

    
    // Auto-load preset when dropdown changes
    document.getElementById('preset_dropdown').addEventListener('change', function() {
        const selectedPreset = this.value;
        if (selectedPreset) {
            sketchup.load_preset(selectedPreset);
        }
    });

    // Save preset button
    document.getElementById('save_preset_btn').addEventListener('click', function() {
        const name = document.getElementById('preset_name').value.trim();
        if (!name) {
            alert('Please enter a preset name');
            return;
        }
        
        // Validate that we have actual values, not placeholders
        const lengthVal = document.getElementById('length').value;
        const heightVal = document.getElementById('height').value;
        
        if (!lengthVal || lengthVal === 'length' || !heightVal || heightVal === 'height') {
            alert('Please fill in the panel dimensions before saving a preset.');
            return;
        }
        
        const settings = collectSettings();
        console.log('Saving preset with settings:', settings);
        sketchup.save_preset(name, JSON.stringify(settings));
        document.getElementById('preset_name').value = '';
        
        // Show success toast
        const toast = document.createElement('div');
        toast.className = 'success-toast';
        toast.textContent = '✓ Preset saved successfully!';
        document.body.appendChild(toast);
        setTimeout(() => toast.remove(), 3000);
        
        setTimeout(function() { sketchup.get_user_presets(); }, 100);
    });

    // Function to update UI with preset data
    function applyPresetToUI(presetData) {
        if (presetData.length) document.getElementById('length').value = presetData.length;
        if (presetData.height) document.getElementById('height').value = presetData.height;
        if (presetData.thickness) document.getElementById('thickness').value = presetData.thickness;
        if (presetData.joint_length) document.getElementById('joint_length').value = presetData.joint_length;
        if (presetData.joint_width) document.getElementById('joint_width').value = presetData.joint_width;
        if (presetData.cavity_distance) document.getElementById('cavity_distance').value = presetData.cavity_distance;
        if (presetData.pattern_type) document.getElementById('pattern_type').value = presetData.pattern_type;
        if (presetData.layout_start_direction) document.getElementById('layout_start_direction').value = presetData.layout_start_direction;
        if (presetData.start_row_height_index) document.getElementById('height_index').value = presetData.start_row_height_index;
        if (presetData.color_name) document.getElementById('color_name').value = presetData.color_name;
        if (presetData.hasOwnProperty('randomize_lengths')) document.getElementById('randomize_lengths').checked = presetData.randomize_lengths;
        if (presetData.hasOwnProperty('randomize_heights')) document.getElementById('randomize_heights').checked = presetData.randomize_heights;
        
        // Layout mode
        if (presetData.hasOwnProperty('single_row_mode')) {
            switchTab(presetData.single_row_mode ? 'single_row' : 'multi_row');
        }
        
        // Rail settings
        if (presetData.hasOwnProperty('enable_top_rail')) document.getElementById('enable_top_rail_multi').checked = presetData.enable_top_rail;
        if (presetData.top_rail_thickness) document.getElementById('top_rail_thickness_multi').value = presetData.top_rail_thickness;
        if (presetData.top_rail_depth) document.getElementById('top_rail_depth_multi').value = presetData.top_rail_depth;
        if (presetData.hasOwnProperty('enable_bottom_rail')) document.getElementById('enable_bottom_rail_multi').checked = presetData.enable_bottom_rail;
        if (presetData.bottom_rail_thickness) document.getElementById('bottom_rail_thickness_multi').value = presetData.bottom_rail_thickness;
        if (presetData.bottom_rail_depth) document.getElementById('bottom_rail_depth_multi').value = presetData.bottom_rail_depth;
        if (presetData.hasOwnProperty('enable_left_rail')) document.getElementById('enable_left_rail_multi').checked = presetData.enable_left_rail;
        if (presetData.left_rail_thickness) document.getElementById('left_rail_thickness_multi').value = presetData.left_rail_thickness;
        if (presetData.left_rail_depth) document.getElementById('left_rail_depth_multi').value = presetData.left_rail_depth;
        if (presetData.hasOwnProperty('enable_right_rail')) document.getElementById('enable_right_rail_multi').checked = presetData.enable_right_rail;
        if (presetData.right_rail_thickness) document.getElementById('right_rail_thickness_multi').value = presetData.right_rail_thickness;
        if (presetData.right_rail_depth) document.getElementById('right_rail_depth_multi').value = presetData.right_rail_depth;
        if (presetData.rail_color_name) document.getElementById('rail_material_name_multi').value = presetData.rail_color_name;
        if (presetData.hasOwnProperty('split_rails')) document.getElementById('split_rails_multi').checked = presetData.split_rails;
        
        // Advanced settings
        if (presetData.hasOwnProperty('synchronize_patterns')) document.getElementById('synchronize_patterns').checked = presetData.synchronize_patterns;
        if (presetData.hasOwnProperty('force_horizontal_layout')) document.getElementById('force_horizontal').checked = presetData.force_horizontal_layout;
        if (presetData.hasOwnProperty('preserve_corners')) document.getElementById('preserve_corners').checked = presetData.preserve_corners;
        if (presetData.hasOwnProperty('use_flat_grouping')) document.getElementById('use_flat_grouping').checked = presetData.use_flat_grouping;
        
        // Minimum piece length
        if (presetData.min_piece_length) document.getElementById('min_piece_length').value = presetData.min_piece_length;
    }
</script>
</body>
</html>
    HTML
    
    dialog = UI::HtmlDialog.new({
      :dialog_title => "PARAMETRIX-NEWUI Configuration",
      :preferences_key => "com.parametrix.newui.layout",
      :scrollable => false,
      :resizable => false,
      :width => 520,
      :height => 650, 
      :left => 100,
      :top => 100,
      :style => UI::HtmlDialog::STYLE_DIALOG
    })
    
    dialog.set_html(html)
    
    dialog.add_action_callback("apply_settings") { |action_context, json_string|
      settings = JSON.parse(json_string)
      
      # Multi-Row Settings
      @@length = settings["length"]
      @@height = settings["height"]
      @@thickness = settings["thickness"]
      @@joint_length = settings["joint_length"]
      @@joint_width = settings["joint_width"]
      @@cavity_distance = settings["cavity_distance"]
      @@pattern_type = settings["pattern_type"]
      @@layout_start_direction = settings["layout_start"]
      @@start_row_height_index = settings["height_index"]
      @@color_name = settings["material_name"]
      @@randomize_lengths = settings["randomize_lengths"]
      @@randomize_heights = settings["randomize_heights"]

      # Single-Row Settings (use same UI values when in single-row mode)
      @@single_row_length = settings["length"]
      @@single_row_height = settings["height"]
      @@single_row_thickness = settings["thickness"]
      @@single_row_joint_length = settings["joint_length"]
      @@single_row_joint_width = settings["joint_width"]
      @@single_row_cavity_distance = settings["cavity_distance"]
      @@single_row_pattern_type = settings["pattern_type"]
      @@single_row_randomize_lengths = settings["randomize_lengths"]
      
      # Rail Settings
      @@enable_top_rail = settings["enable_top_rail"]
      @@top_rail_thickness = settings["top_rail_thickness"]
      @@top_rail_depth = settings["top_rail_depth"]
      @@enable_bottom_rail = settings["enable_bottom_rail"]
      @@bottom_rail_thickness = settings["bottom_rail_thickness"]
      @@bottom_rail_depth = settings["bottom_rail_depth"]
      @@enable_left_rail = settings["enable_left_rail"]
      @@left_rail_thickness = settings["left_rail_thickness"]
      @@left_rail_depth = settings["left_rail_depth"]
      @@enable_right_rail = settings["enable_right_rail"]
      @@right_rail_thickness = settings["right_rail_thickness"]
      @@right_rail_depth = settings["right_rail_depth"]
      @@rail_color_name = settings["rail_material_name"]
      @@split_rails = settings["split_rails"]
      
      # Advanced Settings
      @@synchronize_patterns = settings["synchronize_patterns"]
      @@force_horizontal_layout = settings["force_horizontal"]
      @@preserve_corners = settings["preserve_corners"]
      @@use_flat_grouping = settings["use_flat_grouping"]
      @@single_row_mode = settings["single_row_mode"]
      
      # Minimum piece length settings
      min_piece_value = settings["min_piece_length"] || 0
      @@enable_min_piece_length = min_piece_value > 0
      @@min_piece_length = min_piece_value
      
      is_preview = settings["preview"] || false
      
      if is_preview
        # Preview mode: don't close dialog, remove previous preview
        remove_preview
        result = create_multi_face_unified_layout(multi_face_position, 0, { preview: true })
      else
        # Generate mode: close dialog, create final layout
        dialog.close
        remove_preview
        result = create_multi_face_unified_layout(multi_face_position, 0, { preview: false })
      end
      
      if result == 0
        UI.messagebox("Layout creation failed. Check console for details.")
      end
    }
    
    # Preset management callbacks
    dialog.add_action_callback("save_preset") { |action_context, name, json_string|
      settings = JSON.parse(json_string)
      success = PresetManager.save_preset(name, settings)
      if success
        # Refresh the preset list in the UI
        dialog.execute_script("sketchup.get_user_presets();")
      else
        dialog.execute_script("alert('Failed to save preset. Check console for details.')")
      end
    }
    
    dialog.add_action_callback("load_preset") { |action_context, name|
      preset_data = PresetManager.load_preset(name)
      if preset_data
        PresetManager.apply_preset_to_globals(preset_data)
        dialog.execute_script("applyPresetToUI(#{preset_data.to_json})")
      else
        dialog.execute_script("alert('Failed to load preset: #{name}')")
      end
    }
    
    dialog.add_action_callback("get_user_presets") { |action_context|
      presets = PresetManager.list_presets
      
      # Optimized script to clear and repopulate the dropdown
      presets_json = presets.to_json
      script = "
        var presets = #{presets_json};
        var dropdown = document.getElementById('preset_dropdown');
        var current_value = dropdown.value;
        
        // Clear all options except the placeholder
        while (dropdown.options.length > 1) {
          dropdown.remove(1);
        }
        
        // Add all presets from the authoritative list
        presets.forEach(function(presetName) {
          var option = document.createElement('option');
          option.value = presetName;
          option.textContent = presetName;
          dropdown.appendChild(option);
        });
        
        // Restore selection if it still exists
        if (presets.includes(current_value)) {
          dropdown.value = current_value;
        }
      "
      dialog.execute_script(script)
    }
    
    dialog.add_action_callback("delete_preset") { |action_context, name|
      success = PresetManager.delete_preset(name)
      if success
        dialog.execute_script("document.getElementById('preset_dropdown').value = ''; sketchup.get_user_presets();")
      else
        dialog.execute_script("alert('Cannot delete this preset')")
      end
    }
    
    dialog.add_action_callback("open_documentation") { |action_context|
      extension_dir = File.dirname(File.dirname(File.dirname(__FILE__)))
      doc_path = File.join(extension_dir, "PARAMETRIX_Documentation.html")
      if File.exist?(doc_path)
        UI.openURL("file:///#{doc_path.gsub('\\', '/')}")
      else
        UI.messagebox("Documentation file not found at: #{doc_path}")
      end
    }
    
    dialog.set_on_closed {
      puts "[PARAMETRIX P-11] Dialog closed - removing preview"
      remove_preview
    }

    
    dialog.show
    
    dialog.execute_script("sketchup.get_user_presets();")
  end

end