class ProfileModel
{

  ProfileData data;

  ProfileModel.fromJson(Map<String, dynamic>json)
  {
    data=ProfileData.fromJson(json['data']);
  }

}
class ProfileData
{
  String name;
  String email;
  String phone;
  String image;

  ProfileData.fromJson(Map<String, dynamic>json)
  {
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];

  }



}