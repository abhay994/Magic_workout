import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_workout/data/models/sets_model.dart';
import 'package:magic_workout/ui/workout_list_screen/workout_list_viewmodel.dart';
import 'package:magic_workout/ui/sets_screen/widgets/workout_set_dialog.dart';
import 'package:magic_workout/ui/sets_screen/widgets/workout_sets_list_widget.dart';
import 'package:magic_workout/ui/sets_screen/sets_viewmodel.dart';

class WorkoutScreen extends ConsumerStatefulWidget {
  final int? id;
  const WorkoutScreen({super.key, this.id});

  @override
  ConsumerState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends ConsumerState<WorkoutScreen> {
  final TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if(widget.id!=null) _loadSetsId(widget.id!);
  }

  void _loadSetsId(int id){

    nameController.text = ref.read(workoutListProvider)[id].name;
    Future.delayed(Duration(microseconds: 100),(){
      ref.watch(setsProvider.notifier).load(workoutId: id);
    });
  }

  void save(){
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a workout name')),
      );
      return;
    }



    if(widget.id!=null){
      ref.read(setsProvider.notifier).saveEdit(workoutId: widget.id!,name:nameController.text );}
    else{
      ref.read(workoutListProvider.notifier).addWorkout(name: nameController.text,setsList: ref.read(setsProvider));}

    ref.read(setsProvider.notifier).clear();
    context.go('/');
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){context.go('/'); ref.read(setsProvider.notifier).clear();},icon: Icon(Icons.arrow_back_ios_new),),
        title: Text("New Workout"),
        actions: [
          Padding(
            padding:  EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: ()=>save(), child:  const Text("Save")),
          )
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: [
            TextFormField(
              controller:nameController,
              decoration: const InputDecoration(
                labelText: 'Workout Name',
                border: OutlineInputBorder(),

              ),


            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sets ${ref.watch(setsProvider).length}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async{
                   await showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(20.0)),
                        child: SizedBox(
                           height: 300,
                            child: WorkoutSetDialog(setsModel: SetsModel(exercise:Exercise.squat.displayName,weight: 0,repetitions: 0),newSet: true,)),
                      ),
                    );
                  },
                  // onPressed: ()=>ref.read(setsProvider.notifier).addNewSet(),
                  child: const Text('Add Set'),
                ),
              ],
            ),
            SizedBox(height: 20,),

            Expanded(child: WorkoutSetsListWidget()),

          ],
        ),
      ),
    );
  }
}
