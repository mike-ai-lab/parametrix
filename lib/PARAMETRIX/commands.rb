# PARAMETRIX Commands

module PARAMETRIX

  PARAMETRIX_COMMANDS_VERSION = "P-11"

  def self.start_layout_process
    puts "[PARAMETRIX P-11] Starting layout process..."
    model = Sketchup.active_model
    selection = model.selection

    if selection.empty?
      UI.messagebox("Please select one or more faces to create layout.")
      return
    end

    faces_data = analyze_multi_face_selection(selection)

    if faces_data.empty?
      UI.messagebox("No valid faces found in selection.", "PARAMETRIX")
      return
    end

    unless validate_faces_for_processing(faces_data)
      UI.messagebox("Selected faces are not suitable for processing.")
      return
    end

    multi_face_position = CladzPARAMETRIXMultiFacePosition.new

    faces_data.each do |data|
      multi_face_position.add_face(data[:face], data[:matrix])
    end

    show_html_dialog(multi_face_position)
  end

end