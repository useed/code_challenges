def sq_feet(dimensions)
  l,w,h = dimensions.split("x").map(&:to_i)
  sides = [l*w, w*h, h*l]
  sides.map{|s| s*2}.inject(:+) + sides.min
end

def ribbon(dimensions)
  dimensions = dimensions.split("x").map(&:to_i)
  dimensions.min(2).inject(:+)*2 + dimensions.inject(:*)
end

dimensions = File.open("dimensions.txt"){|f| f.read}.split("\n")

sq_feet = dimensions.inject(0) do |sum, val|
  sum + sq_feet(val)
end

ribbon = dimensions.inject(0) do |sum, val|
  sum + ribbon(val)
end

puts sq_feet
puts ribbon