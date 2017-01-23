CancerType.create(name: 'Mama')
CancerType.create(name: 'Tireóide')
CancerType.create(name: 'Linfoma')
CancerType.create(name: 'Leucemia')

TreatmentType.create(name: 'Cirurgia')
TreatmentType.create(name: 'Quimioterapia')
TreatmentType.create(name: 'Terapia Oral')
TreatmentType.create(name: 'Radioterapia')

MissionType.create(name: 'Sumiço do Anjo')
MissionType.create(name: 'Sumiço do Superador')
MissionType.create(name: 'Denúncia do Anjo')

@treatment_types  = TreatmentType.all
@cancer_types  = CancerType.all
mission_types  = MissionType.all

def profile_generator(participant, treatment: false)
  profile = ParticipantProfile.new(city: Faker::Address.city, state: Faker::Address.state)
  profile.first_name = Faker::Name.first_name
  profile.last_name = Faker::Name.last_name

  participant.profile = profile
  treatment_profile(participant) if treatment
  participant.save
end

def treatment_profile(participant)
  treatments = []
  cancer_treatments = []
  (0..rand(0..3)).each  {
    treatment = Treatment.new(status: :doing)
    treatment.treatment_type = @treatment_types[rand(0..2)]
    treatments << treatment

    cancer_treatment = CancerTreatment.new
    cancer_treatment.cancer_type = @cancer_types[rand(0..2)]
    cancer_treatments << cancer_treatment
  }

  participant.build_current_treatment_profile
  participant.current_treatment_profile.treatments << treatments
  participant.current_treatment_profile.cancer_treatments << cancer_treatments
  participant.save
end


(1..50).each do |n|
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

  profile_generator(overcomer, treatment: true)
  profile_generator(angel, treatment: true)
  profile_generator(archangel)

  t = Trinity.create(overcomer: overcomer, angel: angel, archangel: archangel)
  (0..rand(0..10)).each  {
    m = Mission.new(mission_type: mission_types[rand(0..2)])
    m.participant = t.overcomer
    m.trinity = t
    m.save!
  }

  puts "Created: #{t}"
end
