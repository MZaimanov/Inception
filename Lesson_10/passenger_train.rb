class PassengerTrain < Train
  attr_reader :type
  attr_accessor_with_history :route

  def initialize(number)
    @type = :passenger_train
    super
  end

  def view_type
    'Пассажирский '
  end
end
