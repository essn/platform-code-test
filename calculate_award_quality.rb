class CalculateAwardQuality
  attr_reader :new_expires_in, :new_quality

  def self.run(name:, initial_expires_in:, initial_quality:)
    calculator = self.new(
      initial_expires_in: initial_expires_in,
      initial_quality: initial_quality
    )

    method_name = name.gsub(/\s+/, "_").downcase.to_sym 

    if calculator.respond_to?(method_name)
      calculator.send(method_name)
    else
      calculator.default
    end

    calculator
  end

  def initialize(initial_expires_in:, initial_quality:)
    @new_expires_in = initial_expires_in
    @new_quality = initial_quality
  end

  def default
    @new_quality -= 1 if self.new_quality > 0
    @new_expires_in = self.new_expires_in - 1
    @new_quality -= 1 if self.new_expires_in < 0
  end

  def blue_distinction_plus
    # Never change
  end

  def blue_first
    @new_quality += 1 if self.new_quality < 50
    @new_expires_in -= 1
    @new_quality += 1 if self.new_expires_in < 0 && self.new_quality < 50
  end

  def blue_star
    @new_quality -= 2 if self.new_quality > 0
    @new_expires_in = self.new_expires_in - 1
    @new_quality -= 2 if self.new_expires_in < 0

    @new_quality = 0 if self.new_quality < 0
  end

  def blue_compare
    if self.new_quality < 50
      @new_quality += 1 
      @new_quality += 1 if self.new_expires_in < 11
      @new_quality += 1 if self.new_expires_in < 6
    end

    @new_expires_in -= 1

    @new_quality = 0 if self.new_expires_in < 0
  end
end
