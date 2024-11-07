import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/categories_model.dart';
import 'package:shop_app/model/change_favorite_model.dart';
import 'package:shop_app/model/favorite_model.dart';
import 'package:shop_app/model/home_model.dart';
import 'package:shop_app/model/login_model.dart';
import 'package:shop_app/screens/favorites/favorites.dart';
import 'package:shop_app/screens/products/products.dart';
import 'package:shop_app/screens/settings/settings.dart';
import 'package:shop_app/shared/cubit/shop/shop_states.dart';
import 'package:shop_app/shared/natwork/cache_helper.dart';
import 'package:shop_app/shared/natwork/dio_helper.dart';

import '../../../screens/cateogries/cateogries.dart';
import '../../constant.dart';
import '../../natwork/end_point.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List screenList = [
    ProductsScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  void changeScreens(index) {
    currentIndex = index;
    emit(ShopBottomNavState());
  }

  HomeModel? homeModel;
  Map<int?, bool?>? favorite = {};

  void getHomeData() {
    emit(ShopLoadingCategoriesDataState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data.products.forEach((element) {
        favorite?.addAll({element.id: element.inFavorites});
      });

      // print(favorite.toString());

      emit(ShopSuccessGetHomeDataState());
    }).catchError((error) {
      emit(ShopErrorGetHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(ShopLoadingCategoriesDataState());

    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      // print(' Categories aya');

      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      emit(ShopErrorCategoriesDataState(error.toString()));
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavorite(int? productId) {
    favorite?[productId] = !favorite![productId]!;
    emit(ShopChangeFavoriteState());
    DioHelper.postData(
        url: FAVORITE,
        token: token,
        data: {"product_id": productId}).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      print(changeFavoriteModel?.message);
      print(changeFavoriteModel?.status);
      // print(value.data);
      if (!changeFavoriteModel!.status!) {
        favorite?[productId] = !favorite![productId]!;
      } else {
        getFavoriteData();
      }
      emit(ShopSuccessChangeFavoriteState(changeFavoriteModel!));
    }).catchError((error) {
      if (!changeFavoriteModel!.status!) {
        favorite?[productId] = !favorite![productId]!;
      }
      emit(ShopErrorChangeFavoriteState(error.toString()));
    });
  }

  FavoriteModel? favoriteModel;

  void getFavoriteData() {
    emit(ShopLoadingFavoriteDataState());
    print(' Favorite aya');
    DioHelper.getData(url: FAVORITE, token: token).then((value) {
      favoriteModel = FavoriteModel?.fromJson(value.data);

      // print(' Favorite aya');
      // print(value.data);

      emit(ShopSuccessFavoriteDataState());
    }).catchError((error) {
      emit(ShopErrorFavoriteDataState(error.toString()));
    });
  }

  ShopLoginModel? shopLoginModel;

  void getProfileData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);

      // print(value.data);

      emit(ShopSuccessUserDataState(shopLoginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState(error.toString()));
    });
  }

  void updateProfileData(
      {required String name,
        required String phone,
        required String email}) {
    emit(ShopLoadingUpDateUserDataState());
    DioHelper.putData(url: UPDATE_PROFILE,
      token: token,
      data: {
      'name':name,
        'phone':phone,
        'email':email
      }
    ).then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);

      print(value.data);

      emit(ShopSuccessUpDateUserDataState(shopLoginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpDateUserDataState(error.toString()));
    });
  }
}
