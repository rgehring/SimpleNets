module Validations

  function isMonotonic(toTest::Function)
    delta = 0.001
    x = 0.0
    y = toTest(x)
    while x < 1.0
      x += delta
      last_y = y
      y = toTest(x)
      if y < last_y
        return false
      end
    end
    return true
  end


end
