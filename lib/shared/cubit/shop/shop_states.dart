import 'package:shop_app/model/change_favorite_model.dart';
import 'package:shop_app/model/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopBottomNavState extends ShopStates {}

class ShopLoadingGetHomeDataState extends ShopStates {}

class ShopSuccessGetHomeDataState extends ShopStates {}

class ShopErrorGetHomeDataState extends ShopStates {
  final String error;

  ShopErrorGetHomeDataState(this.error);
}

class ShopLoadingCategoriesDataState extends ShopStates {}

class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {
  final String error;

  ShopErrorCategoriesDataState(this.error);
}


class ShopChangeFavoriteState extends ShopStates {}


class ShopSuccessChangeFavoriteState extends ShopStates {
  final ChangeFavoriteModel model;

  ShopSuccessChangeFavoriteState(this.model);

}

class ShopErrorChangeFavoriteState extends ShopStates {
  final String error;

  ShopErrorChangeFavoriteState(this.error);
}

class ShopLoadingFavoriteDataState extends ShopStates {}

class ShopSuccessFavoriteDataState extends ShopStates {}

class ShopErrorFavoriteDataState extends ShopStates {
  final String error;

  ShopErrorFavoriteDataState(this.error);
}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {
  ShopLoginModel model;
  ShopSuccessUserDataState(this.model);
}

class ShopErrorUserDataState extends ShopStates {
  final String error;

  ShopErrorUserDataState(this.error);
}

class ShopLoadingUpDateUserDataState extends ShopStates {}

class ShopSuccessUpDateUserDataState extends ShopStates {
  ShopLoginModel model;
  ShopSuccessUpDateUserDataState(this.model);
}

class ShopErrorUpDateUserDataState extends ShopStates {
  final String error;

  ShopErrorUpDateUserDataState(this.error);
}