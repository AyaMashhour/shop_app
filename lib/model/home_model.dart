class HomeModel {
   bool? status;

 late HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannersModel> banners =[];
  List<ProductsModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannersModel.fromJson(element));});

    json['products'].forEach((element) {
      products.add(ProductsModel.fromJson(element));
    });
  } }


class BannersModel {
  int ? id;
  String ?image;

 BannersModel.fromJson(Map<String ,dynamic>json){
  id=json['id'];
  image=json['image'] ;
 }
}

class ProductsModel {
   int? id ;
   dynamic price;
   dynamic discount;
   dynamic oldPrice;
   String ?image ;
   String ?name;
   bool ?inFavorites;
   bool  ?inCart;

   ProductsModel.fromJson(Map<String ,dynamic>json){
    id =json['id'];
    price =json['price'];
    discount =json['discount'];
    oldPrice =json['old_price'];
    image =json['image'];
    name =json['name'];
    inFavorites =json['in_favorites'];
    inCart =json['in_cart'];



   }

}
