import 'package:flutter/material.dart';
import 'package:user_management/routing/app_routes.dart';
import '../../core/appColors/app_colors.dart';
import '../../core/appShadow/app_shadows.dart';
import '../../core/appTextStyle/app_text_style.dart';
import '../../domain/entities/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../pages/user_detail_page.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      height: 80,
      alignment: Alignment.center,
      // padding: const EdgeInsets.only(right: 12, left: 8, top: 8, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: AppColors.white,
        boxShadow: AppShadows.customSoftShadow,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: CachedNetworkImageProvider(user.avatar??''),
        ),
        title: Text(
            user.fullName,
            style: AppTextStyle.newTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
        ),
        subtitle: Text(
            user.email??'',
          style: AppTextStyle.newTextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: AppColors.black,
          ),
        ),
        onTap: () => Get.to(() => UserDetailPage(user: user)),
      ),
    );
  }
}
