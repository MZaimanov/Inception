class CargoTrain < Train
  attr_reader :type
  attr_accessor_with_history :route

  def initialize(number)
    @type = :cargo_train
    super
  end

  def view_type
    'Грузовой '
  end
end
