import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/appColors/app_colors.dart';
import '../controllers/user_controller.dart';
import '../widgets/user_tile.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
          title: const Text('Users')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (q) => controller.search(q),
                decoration: InputDecoration(
                  hintText: 'Search by name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(width: 1,color: AppColors.helloColors)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(width: 1,color: AppColors.helloColors)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(width: 1,color: AppColors.helloColors)
                  ),
                ),
              ),
            ),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value && controller.users.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.error.value != null &&
                    controller.users.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(controller.error.value ?? 'Error'),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => controller.fetchUsers(refresh: true),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                final list = controller.filteredUsers;
                if (list.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: controller.refresh,
                    child: ListView(
                      children: const [
                        SizedBox(height: 200),
                        Center(child: Text('No users found')),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: controller.refresh,
                  child: ListView.builder(
                    controller: controller.scrollController,
                    itemCount: list.length + (controller.hasMore.value ? 1 : 0),
                    // separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      if (index >= list.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final user = list[index];
                      return UserTile(user: user);
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
