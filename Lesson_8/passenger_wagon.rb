class PassengerWagon < Wagon

  attr_reader :filled

  def initialize(seats_count)
    @type = :passenger_wagon
    @seats_count = seats_count
    @filled = 0
  end

  def take_a_seat
    raise "Нет свободных мест".red if @filled == @seats_count
    @filled += 1
  end

  def free
    @seats_count - @filled
  end

  def view_type
    "Пассажирский вагон"
  end

end
