import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/home/add_new_task_screen.dart';
import 'package:task_management/ui/widget/tm_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddNewTaskScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
