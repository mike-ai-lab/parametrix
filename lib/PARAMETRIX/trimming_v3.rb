# PARAMETRIX Trimming V3 - Proper Layout Trimming Implementation

module PARAMETRIX_TRIMMING

  PARAMETRIX_TRIM_VERSION = "PARAMETRIX_TRIM_V3_1.0"

  def self.boolean2d_exact(layout_group, original_face, face_matrix = nil)
    begin

      model = Sketchup.active_model
      ents  = model.active_entities
      return layout_group unless model && layout_group && original_face

      faces = []
      comps = []

      model.selection.each do |e|
        if e.class == Sketchup::Face
          faces << e
        end
        if e.class == Sketchup::Group
          comps << e
        end
        if e.class == Sketchup::ComponentInstance
          comps << e
        end
      end

      if faces.empty?
        model.selection.each do |e|
          if e.class == Sketchup::ComponentInstance
            glued_face = e.glued_to
            faces << glued_face if glued_face
          end
        end
      end

      return layout_group if faces.empty?

      gp = ents.add_group
      gents = gp.entities

      # Use face_clone method for proper hole handling
      face_clone(gents, faces)

      boundary_face = gents.grep(Sketchup::Face).first
      unless boundary_face && boundary_face.valid?
        gp.erase! rescue nil
        return layout_group
      end

      # Ensure same normal direction
      boundary_face.reverse! if boundary_face.normal.dot(original_face.normal) < 0

      # Add layout entities to intersect (this is where the trimming happens)
      layout_ents = layout_group.entities

      # The key: intersect_with creates the proper trimmed geometry
      layout_ents.intersect_with(
        true,                               # self_intersect: true for proper cutting
        layout_group.transformation,        # Transform for layout entities
        gents,                             # Entities to intersect with (boundary)
        gp.transformation,                 # Transform for boundary entities
        false,                             # solids_only: false for 2D trimming
        []                                 # entities_to_exclude
      )

      faces_to_remove = []
      layout_ents.grep(Sketchup::Face).each do |f|
        # Classify the center point of each face against the boundary
        # If PointOutside, the face is outside the boundary and should be removed
        if boundary_face.classify_point(f.bounds.center) == Sketchup::Face::PointOutside
          faces_to_remove << f
        end
      end

      layout_ents.erase_entities(faces_to_remove)

      lonely_edges = []
      layout_ents.grep(Sketchup::Edge).each do |edge|
        lonely_edges << edge if edge.faces.empty?
      end
      layout_ents.erase_entities(lonely_edges) unless lonely_edges.empty?

      gp.erase! rescue nil

      # Convert to proper 2D cutting component
      inst = layout_group.to_component
      defn = inst.definition
      be = defn.behavior
      be.is2d = true
      be.cuts_opening = true
      be.snapto = 0
      defn.invalidate_bounds

      inst.name = "PARAMETRIX Layout"
      defn.name = "PARAMETRIX Layout Def"

      return inst

    rescue => e
      begin; gp.erase! if gp && gp.respond_to?(:erase!); rescue; end
      return layout_group
    end
  end

  # Face cloning method (handles holes properly)
  def self.face_clone(gents, faces)
    faces2go = []

    faces.each do |face|
      # Create faces for all loops (outer + inner holes)
      face.loops.each { |loop| gents.add_face(loop.vertices) }

      # Re-add outer face to ensure proper structure
      oface = gents.add_face(face.outer_loop.vertices)

      # Find and mark internal faces for removal
      gents.each do |f|
        next if f.class != Sketchup::Face
        f.edges.each do |e|
          if e.faces.length > 1
            faces2go << f
            break
          end
        end
      end
    end

    gents.erase_entities(faces2go) # Remove internal faces (holes)
  end

end