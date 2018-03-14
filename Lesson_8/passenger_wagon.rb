class PassengerWagon < Wagon


  def initialize(space)
    #@type = :passenger_wagon
    super(:passenger_wagon, space)
  end

  # def take_a_seat
  #   raise "Нет свободных мест".red if @filled >= @space
  #   @filled += 1
  # end

  def load
    super(1)
  end

  def free
    super
  end

  def view_type
    "Пассажирский вагон"
  end

end
