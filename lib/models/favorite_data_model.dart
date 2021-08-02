class FavoriteDataModel
{
  bool status;
  String message;

  FavoriteDataModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
  }



}