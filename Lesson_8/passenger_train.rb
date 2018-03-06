class PassengerTrain < Train

  attr_reader :type

  def initialize(number)
    @type = :passenger_train
    super
  end

  def view_type
    "Пассажирский"
  end
end
