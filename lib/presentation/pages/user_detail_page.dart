import 'package:flutter/material.dart';
import '../../core/appColors/app_colors.dart';
import '../../core/appTextStyle/app_text_style.dart';
import '../../domain/entities/user.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserDetailPage extends StatelessWidget {
  final User user;
  const UserDetailPage({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
            user.fullName,
          style: AppTextStyle.newTextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back,
            color: AppColors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: CachedNetworkImageProvider(user.avatar??""),
            ),
            const SizedBox(height: 16),
            Text(
                user.fullName,
              style: AppTextStyle.newTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
                user.email??'',
              style: AppTextStyle.newTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
                user.phone ?? 'Phone not available',
              style: AppTextStyle.newTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
