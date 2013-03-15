# ECHAPSON V1
# Server side
# --------


Meteor.startup ->
  if not Trails.find().count()

    # Kickstart a database
    Trails.insert
      id: "es1"
      author: "Cyrielle"
      title: "L'Echappée Sonore embarque sur l'Orient Express"
      brief: "En route sur le fabuleux et célébrissime train de Paris à Istanbul."
      url: "//j46.video2.blip.tv/6660008677546/Nunobaba-TamboursDAilleurs313.mp3"
      pic: "/images/es1.jpg"
      color: "#58b79e"
      coords: [
        [48.8742, 2.3470]
        [42.3583, -71.0603]
        [23.7000, 90.3833]
      ]

    Trails.insert
      id: "es2"
      author: "Cyrielle"
      title: "L'Echappée Sonore dans les mines du roi Salomon"
      brief: "A la découverte du trésor jamais découvert du plus roi de Judée"
      url: "//j46.video2.blip.tv/6660008677546/Nunobaba-TamboursDAilleurs313.mp3"
      pic: "/images/es1.jpg"
      color: "#e5681a"
      coords: [
        [45.5081, -73.5550]
        [21.3114, -157.7964]
        [35.4112, 135.8337]
        [60.1708, 24.9375]
      ]

  Meteor.publish "trails", -> Trails.find()