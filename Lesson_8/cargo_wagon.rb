class CargoWagon < Wagon

  def initialize(space)
    super(:cargo_wagon, space)
  end

  def load(space)
    super(space)
  end

  def free
    super
  end

  def view_type
    "Грузовой вагон"
  end

end
