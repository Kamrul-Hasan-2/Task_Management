import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/controller/new_task_list_controller.dart';
import 'package:task_management/ui/home/add_new_task_screen.dart';
import 'package:task_management/ui/widget/centred_circular_progress_indicator.dart';
import 'package:task_management/ui/widget/snack_bar_message.dart';
import 'package:task_management/ui/widget/tm_app_bar.dart';
import 'package:task_management/data/model/task_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewTaskListController _newTaskListController =
      Get.find<NewTaskListController>();

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: GetBuilder<NewTaskListController>(builder: (controller) {
        return _newTaskListController.inProgress
            ? const CentreCircularProgressIndicator()
            : _newTaskListController.taskList.isEmpty
                ? const Center(child: Text("No tasks available"))
                : ListView.builder(
                    itemCount: _newTaskListController.taskList.length,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    itemBuilder: (context, index) {
                      final task = _newTaskListController.taskList[index];
                      return _buildTaskCard(task, index);
                    },
                  );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.to(() => const AddNewTaskScreen());
          if (result == true) {
            _getNewTaskList();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskCard(TaskModel task, int index) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title ?? "Untitled Task",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              task.description ?? "No description provided",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black54,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.createdAt ?? "Unknown date",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      task.creatorEmail ?? "Unknown creator",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _deleteTask(task.sId!, index); // Pass both `taskId` and `index`
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  void _deleteTask(String taskId, int index) async {
    final bool success = await _newTaskListController.deleteTask(taskId);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task deleted successfully")),
      );
    } else {
      snackBarMessage(context, _newTaskListController.errorMessage!, true);
    }
  }

  Future<void> _getNewTaskList() async {
    final bool result = await _newTaskListController.getNewTaskList();

    if (result == false) {
      snackBarMessage(context, _newTaskListController.errorMessage!, true);
    }
  }
}
