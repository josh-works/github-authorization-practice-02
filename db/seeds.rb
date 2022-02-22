cordinate_list = %w[    
  39.76622709413315,-105.22932827525855
  39.76622709413315,-105.22932827525855
  39.76507172805369,-105.22876739501953
  39.75840785139829,-105.22524833679199
  39.7467280172376,-105.22061347961427
  39.75425084928869,-105.22481918334962
  39.76071718860089,-105.22627830505371
  39.763141909318925,-105.22679328918458
  39.76485730642079,-105.2269220352173
  39.76657266078731,-105.2268147468567
]

Pin.find_or_create_by(
  description: "a dangerous intersection (at times) for everyone who uses it.",
  latitude: 39.7664442,
  longitude: -105.228456
)

Pin.find_or_create_by(
  description: "This is a dangerous street for cyclists; drivers get annoyed with cyclists, and vice versa.",
  latitude: 39.766444,
  longitude: -105.228456
)
puts "making pins"
10.times do |n|
  coords = cordinate_list.sample.split(",")
  Pin.create(
    description: Faker::Marketing.buzzwords,
    latitude: coords[0],
    longitude: coords[1]
  )
end

