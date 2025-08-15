import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_workout/data/data%20source/local/sharedpreferences_helper.dart';
import 'package:magic_workout/data/models/sets_model.dart';
import 'package:magic_workout/data/models/workout_model.dart';
import 'package:uuid/uuid.dart';

final workoutListProvider = NotifierProvider<WorkoutViewModel,List<WorkoutModel>>(WorkoutViewModel.new);
class WorkoutViewModel extends Notifier<List<WorkoutModel>>{

  @override
  List<WorkoutModel> build() =>[];



   loadWorkoutList() async{
     String jsonData = await SharedPreference.instance.getData();
     state = (jsonDecode(jsonData) as List).map((workouts)=>WorkoutModel.fromJson(workouts)).toList();
   }


  String generateId(){
    return Uuid().v1();
  }

  DateTime generateDate(){
    return DateTime.now();
  }

  addWorkout({required String name,required List<SetsModel>  setsList }) async{
    state=[...state,WorkoutModel(id: generateId(), name: name, date: generateDate(), setsList:setsList)];
    await SharedPreference.instance.setSetData(jsonData: jsonEncode(state.map((v)=>v.toJson()).toList()));
  }


  removeWorkout(int index){
    state.removeAt(index);
    state=[...state];
  }


}