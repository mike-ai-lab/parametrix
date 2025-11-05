# PARAMETRIX Multi-Face Position Data Model
# Manages face data and transformations for multi-face layouts

class CladzPARAMETRIXMultiFacePosition
  attr_accessor :faces, :matrices, :face_count
  
  def initialize
    @faces = []
    @matrices = []
    @face_count = 0
  end
  
  def add_face(face, matrix = Geom::Transformation.new)
    @faces << face
    @matrices << matrix
    @face_count += 1
  end
  
  def valid?
    @face_count > 0 && @faces.all? { |face| face && face.valid? }
  end
  
  def get_face_data(index)
    return nil if index >= @face_count
    { face: @faces[index], matrix: @matrices[index] }
  end
end