class SingleColorValidator
  attr_reader :known_colors, :subject

  def initialize(subject, known_colors=[])
    @known_colors = known_colors
    @subject = subject
  end

  def color
    subject.color
  end

  def message
    "invalid #{subject_name} color given: #{color}"
  end

  def subject_name
    subject.class.to_s.downcase
  end

  def validate!
    raise ArgumentError, message unless known_colors.include? color
  end
end
