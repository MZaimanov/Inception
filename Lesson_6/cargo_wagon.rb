class CargoWagon < Wagon

  def initialize
    @type = :cargo_wagon
  end

  def view_type
    "Грузовой вагон"
  end

end
