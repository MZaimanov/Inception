class PassengerWagon < Wagon
  def initialize(space)
    super(:passenger_wagon, space)
  end

  def load
    super(1)
  end

  def view_type
    'Пассажирский вагон '
  end
end
