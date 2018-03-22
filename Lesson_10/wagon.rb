class Wagon
  include CompanyName
  attr_reader :type, :filled

  def initialize(type, space)
    @type = type
    @space = space
    @filled = 0
  end

  def load(space)
    raise 'Нет свободного места'.red if space > free
    @filled += space
  end

  def free
    @space - @filled
  end
end
