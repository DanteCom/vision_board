import 'package:vision_board/resources/resources.dart';

class Onboard {
  final String image;
  final String title;
  final String subtitle;

  Onboard({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  static List<Onboard> onboardList = [
    Onboard(
      image: Images.onboard1,
      title: 'make a list of\nvisions',
      subtitle:
          'Add a photo, description and deadline so\nyou don\'t forget anything',
    ),
    Onboard(
      image: Images.onboard2,
      title: 'share your\nopinion with us',
      subtitle: 'We appreciate your thoughts – they drive\nour improvement',
    ),
    Onboard(
      image: Images.onboard3,
      title: 'Fuel ambitions\nwith visuals',
      subtitle:
          'Create your visions effortlessly to makes\nyour dreams come true',
    ),
  ];
}
