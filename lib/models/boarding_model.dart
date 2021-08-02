class BoardingModel {
  final String image;
  final String textTitle;
  final String textBody;

  BoardingModel({this.image, this.textTitle, this.textBody});
}
List <BoardingModel> boardingList =
[
  BoardingModel(
      image: 'assets/onboarding.jpg',
      textTitle: 'onboarding1',
      textBody: 'TextBody'),
  BoardingModel(
      image: 'assets/shopping.jpg',
      textTitle: 'onboarding2',
      textBody: 'TextBody'),
  BoardingModel(
      image: 'assets/shopping2.jpg',
      textTitle: 'onboarding3',
      textBody: 'TextBody1'),
];