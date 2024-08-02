import 'package:bloc/bloc.dart';
import 'package:consume_api_bloc_dio/data/datasource/remote_datasource.dart';
import 'package:consume_api_bloc_dio/data/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final RemoteDatasource remoteDataSource;
  UserBloc({required this.remoteDataSource}) : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      emit(UserLoading());
      try {
        final result = await remoteDataSource.getUsers();
        emit(UserLoaded(result.data));
      } catch (error) {
        emit(UserError(error.toString()));
      }
    });
  }
}
