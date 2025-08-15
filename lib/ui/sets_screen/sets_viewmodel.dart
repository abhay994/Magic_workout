import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_workout/data/models/sets_model.dart';
import 'package:magic_workout/ui/workout_list_screen/workout_list_viewmodel.dart';

final setsProvider = NotifierProvider<SetsViewModel,List<SetsModel>>(SetsViewModel.new);
class SetsViewModel extends Notifier<List<SetsModel>>{
  ScrollController scrollController = ScrollController();

  @override
  List<SetsModel> build() => [];

  // Add NewSet
  addNewSet(SetsModel setsModel) {
    state=[...state,setsModel];
    // Trigger the scroll .
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollController.jumpTo(scrollController.position.maxScrollExtent));
  }

  saveEdit({required int workoutId,required String name}){
    ref.read(workoutListProvider)[workoutId].name=name;
    ref.read(workoutListProvider)[workoutId].setsList = state;
  }

  removeSet(int index){
    state.removeAt(index);
    state=[...state];
    ref.read(setsProvider.notifier);
  }

  updateSet(int index,SetsModel setsModel){
    state[index] = setsModel;
    state=[...state];
  }

  clear(){
    state=[];
    state=[...state];
  }

  load({required int workoutId}){
    state = ref.read(workoutListProvider)[workoutId].setsList;
    state=[...state];
  }



}