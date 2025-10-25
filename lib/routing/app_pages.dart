
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../domain/entities/user.dart';
import '../presentation/pages/user_detail_page.dart';
import 'app_routes.dart';

class AppPages {
  static List<GetPage> getRoutes() {
    return [
      GetPage(name: AppRoutes.userDetailsScreen, page: (){
        final user = Get.arguments as User?;
        return UserDetailPage(user: user!);
      }),

    ];
  }
}
