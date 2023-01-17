import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzel/app_state.dart';
import 'package:manzel/backend/api_requests/api_calls.dart';
import 'package:manzel/flutter_flow/flutter_flow_util.dart';

class MyPropertiesBloc extends Cubit<PropertiesState>{
  MyPropertiesBloc() : super(PropertiesState(ApiResponseState.empty));

  getProperties (currentUserUid)async{
    emit(PropertiesState(ApiResponseState.loading));
    ApiCallResponse result  = await GetBookMarkedPropertiesCall.call(
      userId: currentUserUid,
      locale: FFAppState().locale,
      authorazationToken: FFAppState().authToken,
      version: FFAppState().apiVersion,
    );
    List? bookmarkedProperties = await GetBookMarkedPropertiesCall.result(
      result.jsonBody,
    ).toList();
    emit(PropertiesState(ApiResponseState.loaded ,result: result , bookmarkedProperties: bookmarkedProperties));
  } removeProperty (currentUserUid ,bookmarkedPropertiesItem)async{
    emit(PropertiesState(ApiResponseState.loading));
    ApiCallResponse? bookmarkApiResponse =
    await BookmarkPropertyCall
        .call(
      authorazationToken:
      FFAppState()
          .authToken,
      userId:
      currentUserUid,
      propertyId:
      valueOrDefault<
          String>(
        getJsonField(
          bookmarkedPropertiesItem,
          r'''$..property_id''',
        ).toString(),
        '0',
      ),
      version:
      FFAppState()
          .apiVersion,
    );
    emit(PropertiesState(ApiResponseState.loaded , result: bookmarkApiResponse));
  }


}
class PropertiesState extends Equatable{
  final ApiResponseState state ;
   ApiCallResponse? result ;
   List? bookmarkedProperties ;
  PropertiesState(this.state , { this.result , this.bookmarkedProperties });

  @override
  // TODO: implement props
  List<Object?> get props => [this.state , this.result , this.bookmarkedProperties];
}
enum ApiResponseState {

  loading , loaded , error , empty
}