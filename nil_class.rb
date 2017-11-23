class NilClass
  def turn side=""
    "Robot not found!"
  end
  alias :report :turn
  alias :move :turn
end
