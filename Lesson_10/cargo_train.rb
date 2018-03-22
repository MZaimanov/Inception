class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    @type = :cargo_train
    super
  end

  def view_type
    'Грузовой'
  end
end
