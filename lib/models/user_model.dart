class User {
  final int id;
  final String name;
  final int age;
  final List<String> imageUrls;
  final List<String> intrests;
  final String bio;
  final String jobTitle;

  const User({
    required this.id,
    required this.name,
    required this.age,
    required this.imageUrls,
    required this.intrests,
    required this.bio,
    required this.jobTitle,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        imageUrls,
        intrests,
        bio,
        jobTitle,
      ];

  static List<User> users = [
    User(
      id: 1,
      age: 25,
      name: 'Neymar',
      imageUrls: [
        'https://phantom-marca.unidadeditorial.es/341a9478190ebbb9984e09b1c3238ad8/resize/1320/f/jpg/assets/multimedia/imagenes/2022/01/12/16420121570853.jpg',
        'https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FNeymar&psig=AOvVaw0XMsirfLeE6cXIMWnX07XF&ust=1650923020615000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCKitwdXVrfcCFQAAAAAdAAAAABAD',
        'https://phantom-marca.unidadeditorial.es/0fb467c00ad2061a3ab26031985b6a7e/resize/1320/f/jpg/assets/multimedia/imagenes/2022/04/24/16507835695496.png',
      ],
      intrests: ['Music', 'Coffee', 'Festivals'],
      jobTitle: 'Footballer',
      bio: 'I play at PSG, we suck.',
    ),
    User(
      id: 2,
      age: 36,
      name: 'Cristiano',
      imageUrls: [
        'https://i2-prod.football.london/incoming/article23720378.ece/ALTERNATES/s1200c/0_The-Manchester-United-family-is-rallying-around-Cristiano-Ronaldo-after-the-tragedy.jpg',
        'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
        'https://i.dailymail.co.uk/1s/2022/04/18/20/56755485-10729225-Cristiano_Ronaldo_s_newborn_son_has_died_according_to_an_announc-a-12_1650308461559.jpg',
      ],
      intrests: ['Music', 'Coffee', 'Festivals'],
      jobTitle: 'Footballer',
      bio: 'I play in Manchester, we really suck.',
    ),
  ];
}
