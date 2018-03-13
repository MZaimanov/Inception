class Wagon
  include CompanyName
  attr_reader :type
  attr_reader :filled

  def initialize(space)
    @type = type
    @space = space
    @filled = 0
  end

  def free
    @space - @filled
  end

end
