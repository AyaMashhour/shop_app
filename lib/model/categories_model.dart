class CategoriesModel {
  bool? status;
 late CategoriesDataModel dataModel;

  CategoriesModel.fromJson(Map<String,dynamic>json){

    status=json['status'];
    dataModel=CategoriesDataModel.fromJson(json['data']);
  }

}

class CategoriesDataModel {
  late int currentPage;
  List<DataModel> categoriesdata = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    json['data'].forEach((element) {
      categoriesdata.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  late int id;

  late String name;

  late String image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
