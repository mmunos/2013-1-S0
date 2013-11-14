#Movies
Movie.create(name: "The Hunger Games: Catching Fire",date: "2013-11-21 00:00:00", genre: "Action, Adventure,  Sci-Fi ", description: "Katniss Everdeen and Peeta Mellark become targets o...", director: " Francis Lawrence", duration: 146)
Movie.create(name: "X-Men: First Class", date: "2011-06-03 00:00:00", genre: "Action, Adventure, Sci-Fi", description: "In 1962, the United States government enlists the h...", director: "Matthew Vaughn", duration: 132)
Movie.create(name: "The Fault in Our Stars", date:"2014-06-06 00:00:00",genre:"Drama", description: "Hazel and Gus are two teenagers who share anacerbi...", director: "Josh Boone", duration: 126)
Movie.create(name: "Sen to Chihiro no kamikakushi", date: "2002-10-25 00:00:00", genre: "Animation, Adventure, Family ", description: "In the middle of her familys move to the suburbs, ...", director: "Hayao Miyazaki", duration: 125)
Movie.create(name: "Pulp Fiction", date: "1994-11-14 00:00:00", genre: "Crime, Drama, Thriller", description: "The lives of two mob hit men, a boxer, a gangster's...", director: "Quentin Tarantino", duration: 154)
Movie.create(name: "The Matrix", date: "1999-06-29 00:00:00", genre: "Action, Adventure, Sci-Fi", description: "A computer hacker learns from mysterious rebels abo...", director: "Andy Wachowski, Lana Wachowski", duration: 136)

#Series
s1 = Serial.create(name: "Doctor Who", date: "2005-03-26 00:00:00", genre: "Adventure, Drama, Family", description: "The Doctor looks and seems human. He's handsome, wi...", director: nil, duration: nil)

s2 = Serial.create(name: "The O.C.", date: "2003-08-14 00:00:00", genre: " Comedy, Drama, Romance",description: "Ensemble drama revolving around the young adult com...", director: nil, duration: nil)

#season
se1 = Season.create(description: "The 2005 series constitutes a loose story arc, deal...", date: "2005-03-26", number: 1, serial: s1)
se2 = Season.create(description: "The first episode of the series, \"New Earth\", wasa...", date: "2006-04-15", number: 2, serial: s1)
se3 = Season.create(description: "The first season of The O.C. commenced airing in th...", date: "2003-08-05", number: 1, serial: s2)

#Episodes
Episode.create(name: "Rose", description: "Rose Tyler is just an ordinary shop worker living a...", date: "2005-03-26", number: 1, write: "Russell T Davies", director: "Keith Boak", duration: 45, season: se1)

Episode.create(name: "The End Of The World", description: "Rose goes off on her first adventure with the Docto...", date: "2005-04-02", number: 2, write: "Russell T Davies", director: "Euros Lyn", duration: 45, season: se1)

Episode.create(name: "The Unquiet Dead", description: "The Doctor has great expectations for his latest ad...", date: "2005-04-09", number: 3, write: "Mark Gatiss", director: "Euros Lyn", duration: 45,season: se1)

Episode.create(name: "Aliens of London", description: "The Doctor returns Rose to her own time - well, sor...", date: "2005-04-16", number: 4, write: "Russell T Davies", director: "Keith Boak", duration: 45, season: se1)

Episode.create(name: "World War Three", description: "The fiendish Slitheen have been unmasked as the one...", date: "2005-04-23", number: 5, write: "Russell T Davies", director: "Keith Boak", duration: 45, season: se1)

Episode.create(name: "New Earth", description: "As Rose Tyler embarks upon her first big TARDIS adv...", date: "2006-04-15", number: 1, write: "Russell T Davies", director: "James Hawes", duration: 45, season: se2)

Episode.create(name: "Tooth and Claw", description: "The Doctor and Rose are transported to 19th Century...", date: "2006-04-22", number: 2, write: "Russell T Davies", director: "Euros Lyn", duration: 45, season: se2)

Episode.create(name: "School Reunion", description: "The Krillitanes - aliens with a mix-and-match physi...", date: "2006-04-29", number: 3, write: "Toby Whithouse", director: "James Hawes", duration: 45, season: se3)

Episode.create(name: "Pilot", description: "After Ryan just escapes jail time and is kicked out...", date: "2003-08-05", number: 1, write: "Josh Schwartz", director: "Doug Liman", duration: 44, season: se3)

Episode.create(name: "The Model Home", description: "Marissa and Seth convince Ryan not to leave Newport...", date: "2003-08-12", number: 2, write: "Allan Heinberg, Josh Schwartz", director: "Doug Liman", duration: 44, season: se3)

Episode.create(name: "The Gamble", description: "Sandy comes to Ryan's rescue once again. Kirsten de...", date: "2003-08-19", number: 3, write: "Jane Espenson", director: "Ian Toynton", duration: 44, season: se3)