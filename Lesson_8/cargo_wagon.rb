class CargoWagon < Wagon

  def initialize(space)
    super(:cargo_wagon, space)
  end

  def view_type
    "Грузовой вагон"
  end

end
