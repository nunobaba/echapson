# ECHAPSON V1
# Server side
# --------


Meteor.startup ->
  if Routes.find().count() == 0

    # Kickstart a database
    Routes.insert
      id: "es1"
      author: "Cyrielle"
      title: "L'Echappée Sonore embarque sur l'Orient Express"
      brief: "En route sur le fabuleux et célébrissime train de Paris à Istanbul."
      url: "//j46.video2.blip.tv/6660008677546/Nunobaba-TamboursDAilleurs313.mp3"
      pic: "images/es1.jpg"

    Routes.insert
      id: "es2"
      author: "Cyrielle"
      title: "L'Echappée Sonore dans les mines du roi Salomon"
      brief: "A la découverte du trésor jamais découvert du plus roi de Judée"
      url: "//j46.video2.blip.tv/6660008677546/Nunobaba-TamboursDAilleurs313.mp3"
      pic: "images/es1.jpg"

