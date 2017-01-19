MissionType.create(name: 'Sumiço do Anjo')
MissionType.create(name: 'Sumiço do Superador')
MissionType.create(name: 'Denúncia do Anjo')
mission_types  = MissionType.all

(1..100).each do |n|
  overcomer = Overcomer.create(uid: n)

  max_overcomers_counter = 0

  if max_overcomers_counter == 0
    angel = Angel.create(uid: "#{n}_a")
  elsif max_overcomers_counter == 2
    max_overcomers_counter = 0
  else
    max_overcomers_counter += 1
  end

  if n == 1 or n % 10
    archangel = Archangel.create(uid: "#{n}_ar")
  end
  overcomer.build_participant_profile(city: Faker::Address.city, state: Faker::Address.state)
  overcomer.profile.first_name = Faker::Name.first_name
  overcomer.profile.last_name = Faker::Name.last_name
  overcomer.save
  angel.build_participant_profile(city: Faker::Address.city, state: Faker::Address.state)
  angel.profile.first_name = Faker::Name.first_name
  angel.profile.last_name = Faker::Name.last_name
  angel.save
  archangel.build_participant_profile(city: Faker::Address.city, state: Faker::Address.state)
  archangel.profile.first_name = Faker::Name.first_name
  archangel.profile.last_name = Faker::Name.last_name
  archangel.save

  t = Trinity.create(overcomer: overcomer, angel: angel, archangel: archangel)
  (0..rand(0..10)).each  {
    m = Mission.new(mission_type: mission_types[rand(0..2)])
    m.participant = t.overcomer
    m.trinity = t
    m.save!
  }

  puts "Created: #{t}"
end
