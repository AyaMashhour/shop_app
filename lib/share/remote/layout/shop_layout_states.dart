import 'package:shop_application/models/favorite_data_model.dart';
import 'package:shop_application/models/login_screen_user_data.dart';
import 'package:shop_application/models/profile_data_model.dart';

abstract class ShopLayoutStates{}

class LayoutInitialState extends ShopLayoutStates{}

class LayoutChangeNavigationBar extends ShopLayoutStates{}

class LayoutLoadingHomeData extends ShopLayoutStates{}

class LayoutSuccessHomeData extends ShopLayoutStates{}

class LayoutErrorHomeData extends ShopLayoutStates{}

class CategoriesLoadingHomeData extends ShopLayoutStates{}

class CategoriesSuccessHomeData extends ShopLayoutStates{}

class CategoriesErrorHomeData extends ShopLayoutStates{}

class FavoriteChangeIcon extends ShopLayoutStates{}

class FavoriteSuccessHomeData extends ShopLayoutStates{
  final FavoriteDataModel model;

  FavoriteSuccessHomeData(this.model);
}

class FavoriteErrorHomeData extends ShopLayoutStates{}
//   favoriteScreen
class ShopLoadingFavoriteScreen extends ShopLayoutStates{}

class ShopSuccessFavoriteScreen extends ShopLayoutStates{}

class ShopErrorFavoriteScreen extends ShopLayoutStates{}

//   profileData

class ShopLoadingProfileScreen extends ShopLayoutStates{}

class ShopSuccessProfileScreen extends ShopLayoutStates{
  final ProfileModel profileModel;

  ShopSuccessProfileScreen(this.profileModel);

}

class ShopErrorProfileScreen extends ShopLayoutStates{}
//updateProfile

class ShopLoadingUpdateProfileScreen extends ShopLayoutStates{}

class ShopSuccessUpdateProfileScreen extends ShopLayoutStates{
  final ProfileModel profileModel;

  ShopSuccessUpdateProfileScreen(this.profileModel);

}

class ShopErrorUpdateProfileScreen extends ShopLayoutStates{}

//search

class ShopLoadingSearchScreen extends ShopLayoutStates{}

class ShopSuccessSearchScreen extends ShopLayoutStates{}

class ShopErrorSearchScreen extends ShopLayoutStates{}

