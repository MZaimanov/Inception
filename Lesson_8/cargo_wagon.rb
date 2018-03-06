class CargoWagon < Wagon

  attr_reader :filled

  def initialize(volume)
    @type = :cargo_wagon
    @volume = volume
    @filled = 0
  end

  def load(volume)
    raise "Нет свободного места" if volume + @filled > @volume
    @filled += volume
  end

  def free
    @volume - @filled
  end

  def view_type
    "Грузовой вагон"
  end

end
