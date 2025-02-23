import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:e_learning/features/courses/domain/entity/course_entity.dart';
import 'package:e_learning/features/home/presentation/view_model/home/home_event.dart';
import 'package:e_learning/features/home/presentation/view_model/home/home_state.dart';
import 'package:http/http.dart' as http;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchCoursesEvent>(_fetchCourses);
  }

  Future<void> _fetchCourses(
      FetchCoursesEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    try {
      final response =
          await http.get(Uri.parse("http://10.0.2.2:5003/courses/all"));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<CourseEntity> courses =
            data.map((e) => CourseEntity.fromJson(e)).toList();
        emit(HomeLoaded(courses));
      } else {
        emit(HomeError("Failed to load courses"));
      }
    } catch (e) {
      emit(HomeError("An error occurred: $e"));
    }
  }
}
