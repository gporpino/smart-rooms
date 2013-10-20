class Time
  def to(to, step = 15.minutes)
    [self].tap { |array| array << array.last + step while array.last < to }
  end
end
