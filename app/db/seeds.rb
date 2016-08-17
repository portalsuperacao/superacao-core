(1..100).each do |n|
  overcomer = Overcomer.create(name: Faker::Name.name, uid: n)

  max_overcomers_counter = 0

  if max_overcomers_counter == 0
    angel = Angel.create(name: Faker::Name.name, uid: "#{n}_a")
  elsif max_overcomers_counter == 2
    max_overcomers_counter = 0
  else
    max_overcomers_counter += 1
  end

  if n == 1 or n % 10
    archangel = Archangel.create(name: Faker::Name.name, uid: "#{n}_ar")
  end

  Trinity.create(overcomer: overcomer, angel: angel, archangel: archangel)
end
