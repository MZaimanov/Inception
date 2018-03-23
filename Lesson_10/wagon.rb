class Wagon
  include CompanyName
  include Validation
  include Accessors

  attr_reader :type, :filled, :type, :space

  strong_attr_accessor :train, Train

  validate :space, :presence, true



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
