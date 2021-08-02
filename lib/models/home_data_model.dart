
// class HomeModel{
//   bool status;
//   HomeDataModel data;
//   HomeModel.fromJson(Map<String,dynamic>json)
//   {
//     status=json['status'];
//     data = HomeDataModel.fromJson(json['data']);
//   }
//
// }
//
// class HomeDataModel{
//   List<HomeDataBannersModel>banners=[];
//   List<HomeDataProductsModel>products=[];
//
//   HomeDataModel.fromJson(Map<String,dynamic>json)
//   {
//
//
//     json['banners'].forEach((element) {
//       banners.add(HomeDataBannersModel.fromJson(element));
//     });
//
//     json['products'].forEach((element) {
//       products.add(HomeDataProductsModel.fromJson(element));
//     });
//   }
//
// }
//
// class HomeDataBannersModel{
//   int id;
//   String image;
//
//   HomeDataBannersModel({this.image,this.id});
//   HomeDataBannersModel.fromJson(Map<String, dynamic>json)
//   {
//     id=json['id'];
//     image=json['image'];
//   }
//
// }
// class HomeDataProductsModel
// {
//   int id;
//   dynamic price;
//   dynamic oldPrice;
//   dynamic discount;
//   String image;
//   String name;
//   bool inFavorites;
//   bool inCart;
//
//   HomeDataProductsModel.fromJson(Map<String ,dynamic>json)
//   {
//     id=json['id'];
//     name=json['name'];
//     price=json['price'];
//     oldPrice=json['old_price'];
//     discount=json['discount'];
//     inFavorites=json['in_favorites'];
//     inCart=json['in_cart'];
//     image=json['images'];
//   }
// }

class HomeModel
{
  bool status;
  HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel
{
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json)
  {
    json['banners'].forEach((element)
    {
      banners.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element)
    {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel
{
  int id;
  String image;

  BannerModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel
{
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  bool inFavorites;
  bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}

