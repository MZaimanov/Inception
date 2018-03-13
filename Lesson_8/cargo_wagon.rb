class CargoWagon < Wagon

  def initialize(space)
    @type = :cargo_wagon
    super
  end

  def load(space)
    raise "Нет свободного места".red if space > free
    @filled += space
  end

  def free
    super
  end

  def view_type
    "Грузовой вагон"
  end

end
