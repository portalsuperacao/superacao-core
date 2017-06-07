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
  profile = ParticipantProfile.new
  profile.first_name = Faker::Name.first_name
  profile.last_name = Faker::Name.last_name
  profile.occupation = Faker::Name.title
  profile.birthdate     = Faker::Date.birthday
  profile.country       = Faker::Address.country
  profile.state         = Faker::Address.state
  profile.city          = Faker::Address.city
  profile.lat           = Faker::Address.latitude
  profile.lng           = Faker::Address.longitude
  profile.relationship  = 'Solteira'
  profile.sons          = rand(0..5)
  profile.facebook      = Faker::Internet.url
  profile.instagram     = Faker::Internet.url
  profile.whatsapp      = Faker::Internet.url
  profile.youtube       = Faker::Internet.url
  profile.snapchat      = Faker::Internet.url
  profile.genre         = [:male, :female, :other].sample
  profile.email         = Faker::Internet.email
  profile.belief        = Faker::Food::spice

  participant.profile = profile
  treatment_profiles(participant) if treatment
  participant.save
end

def treatment_profiles(participant)
  if [true, false].sample
    participant.myself!
  else
    participant.family_member!
    participant.family_member = participant.family_members.to_a.sample(1).to_h.first[0]
  end

  if [true, false].sample
    participant.during_treatment!
    treatment_profile(participant.build_current_treatment_profile, :current)
  else
    participant.overcome!
    treatment_profile(participant.build_past_treatment_profile, :past)
  end
end

def treatment_profile(treatment_profile, treatment_period = :current)
  treatments = []
  cancer_treatments = []
  (0..rand(0..3)).each  {
    treatment = Treatment.new()
    treatment.treatment_type = @treatment_types[rand(0..2)]
    treatment.status = :done
    if treatment_period == :current
      status = [:doing, :done]
      treatment.status = status[rand(0..1)]
      treatment_profile.metastasis = [true, false].sample
      treatment_profile.relapse = [true, false].sample
    end
    treatments << treatment

    cancer_treatment = CancerTreatment.new
    cancer_treatment.cancer_type = @cancer_types[rand(0..2)]
    cancer_treatments << cancer_treatment
  }

  treatment_profile.treatments << treatments
  treatment_profile.cancer_treatments << cancer_treatments

  if treatment_period == :current and [true, false].sample
    treatment_profile(treatment_profile, :past)
  end
end


max_overcomers_counter = 0
archangel = nil
angel = nil
(1..50).each do |n|
  overcomer = Overcomer.create(uid: n)

  if max_overcomers_counter == 0
    angel = Angel.create(uid: "#{n}_a")
    max_overcomers_counter += 1
  elsif max_overcomers_counter == 2
    max_overcomers_counter = 0
  else
    max_overcomers_counter += 1
  end

  if n == 1 or (n % rand(1..n)) == 0
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
