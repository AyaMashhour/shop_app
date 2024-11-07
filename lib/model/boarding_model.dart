 class BoardingModel{

  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body
  });

 }
 List <BoardingModel>list =
 [
   BoardingModel(image: 'assets/images/board1.jpg', title: 'title2121', body: 'body 1'),
   BoardingModel(image: 'assets/images/board4.jpg', title: 'title2', body: 'body2'),
   BoardingModel(image: 'assets/images/board3.jpg', title: 'title3', body: 'body3'),
 ];
