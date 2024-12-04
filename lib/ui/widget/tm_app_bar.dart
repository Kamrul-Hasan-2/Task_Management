import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/controller/auth_controller.dart';
import 'package:task_management/ui/controller/profile_controller.dart';
import 'package:task_management/ui/home/login_screen.dart';
import 'package:task_management/ui/home/profile_screen.dart';

import '../../data/utils/urls.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isProfileScreenOpen;

  const TMAppBar({
    Key? key,
    this.isProfileScreenOpen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      title: GestureDetector(
        onTap: () {
          if (isProfileScreenOpen) {
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        },
        child: GetBuilder<ProfileController>(builder: (controller) {
          return Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                backgroundImage: controller.userData?.image == null
                    ? null
                    : NetworkImage(
                        Urls.baseUrl + "/" + (controller.userData?.image ?? ''),
                      ),
                child: controller.userData?.image == null
                    ? const Icon(Icons.person, color: Colors.blue)
                    : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.userData?.fullName ?? ' ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      controller.userData?.email ?? ' ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await AuthController.clearUserData();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (route) => false,
            );
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
