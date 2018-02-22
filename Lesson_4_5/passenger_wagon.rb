class PassengerWagon < Wagon

  attr_reader :type

  def initialize
    @type = :passenger_wagon
  end

  def view_type
    "Пассажирский вагон"
  end

end
