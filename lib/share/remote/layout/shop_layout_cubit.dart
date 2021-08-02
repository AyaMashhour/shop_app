import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_application/models/category_data_model.dart';
import 'package:shop_application/models/favorite_data_model.dart';
import 'package:shop_application/models/favorite_home_data_model.dart';
import 'package:shop_application/models/home_data_model.dart';
import 'package:shop_application/models/login_screen_user_data.dart';
import 'package:shop_application/models/profile_data_model.dart';
import 'package:shop_application/models/search_data_model.dart';
import 'package:shop_application/modules/categories_screen.dart';
import 'package:shop_application/modules/favourites_screen.dart';
import 'package:shop_application/modules/products_screen.dart';
import 'package:shop_application/modules/setting_screen.dart';
import 'package:shop_application/share/local/doi_helper.dart';
import 'package:shop_application/share/local/end_points.dart';
import 'shop_layout_states.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates> {
  ShopLayoutCubit() : super(LayoutInitialState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> showScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen()
  ];

  void changeBottomNavigationBar(index) {
    currentIndex = index;
    emit(LayoutChangeNavigationBar());
  }

  HomeModel homeModel;

  void getHomeData() {
    emit(LayoutLoadingHomeData());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });

      emit(LayoutSuccessHomeData());
    }).catchError((error) {
      print(error.toString());
      emit(LayoutErrorHomeData());
    });
  }

  CategoriesModel categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(url: CATEGORIES, token: token).then((value) {
      emit(CategoriesLoadingHomeData());
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel.status);
      print(categoriesModel.data.data[0].name);

      emit(CategoriesSuccessHomeData());
    }).catchError((e) {
      print(e.toString());
      emit(CategoriesErrorHomeData());
    });
  }

  Map<int, dynamic> favorites = {};
  FavoriteDataModel favoriteDataModel;

  void changeFavorites(productId) {
    favorites[productId] = !favorites[productId];
    emit(FavoriteChangeIcon());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      favoriteDataModel = FavoriteDataModel.fromJson(value.data);
      print(favoriteDataModel.message);
      print(favoriteDataModel.status);
      if (!favoriteDataModel.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavoritesData();
      }

      emit(FavoriteSuccessHomeData(favoriteDataModel));
    }).catchError((e) {
      favorites[productId] = !favorites[productId];
      print(e.toString());
      emit(FavoriteErrorHomeData());
    });
  }

  FavouriteModel favouriteModel;

  void getFavoritesData() {
    emit(ShopLoadingFavoriteScreen());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favouriteModel = FavouriteModel.fromJson(value.data);
      emit(ShopSuccessFavoriteScreen());
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorFavoriteScreen());
    });
  }

  ProfileModel profileModel;

  void getProfileData() {
    emit(ShopLoadingProfileScreen());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      profileModel = ProfileModel.fromJson(value.data);

      print(profileModel.data.name);
      print(profileModel.data.phone);
      print(profileModel.data.email);

      emit(ShopSuccessProfileScreen(profileModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorProfileScreen());
    });
  }

  void updateProfile({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(ShopLoadingUpdateProfileScreen());
    DioHelper.putData(url: UPDATEPROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      profileModel = ProfileModel.fromJson(value.data);

      print(profileModel.data.name);
      print(profileModel.data.phone);
      print(profileModel.data.email);

      emit(ShopSuccessUpdateProfileScreen(profileModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateProfileScreen());
    });
  }

  SearchModel model;

  void getSearch(text) {
    emit(ShopLoadingSearchScreen());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data:
      {
        'text':text
      },

    ).then((value) {

      model = SearchModel.fromJson(value.data);
      emit(ShopSuccessSearchScreen());
    }).catchError((e) {
      print(e.toString());
      emit(ShopErrorSearchScreen());
    });
  }
}
