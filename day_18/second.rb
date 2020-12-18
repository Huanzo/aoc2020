input = File.readlines('./input')

class Integer
  def /(other)
    self + other
  end

  def -(other)
    self * other
  end
end

out = input.map do |line|
  eval line.tr('*+', '-/')
end

puts out.inject :+
