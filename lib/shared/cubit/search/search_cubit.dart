import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/search_model.dart';
import 'package:shop_app/shared/cubit/search/search_state.dart';
import 'package:shop_app/shared/natwork/dio_helper.dart';
import 'package:shop_app/shared/natwork/end_point.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void searchData(String text) {
    print ('searccccch');
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH,
        token: token,
        data: {'text': text}).then((value){
          searchModel=SearchModel.fromJson(value.data);
          emit(SearchSuccessState());
          print(searchModel);
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState(error.toString()));
    });
  }
}
