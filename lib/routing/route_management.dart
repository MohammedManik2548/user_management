import 'app_routes.dart';

class RouteManagement{
  String _routeName=AppRoutes.userDetailsScreen;
   String getNavigatorRoute()  {
     return _routeName;
   }
   void putNavigatorRoute(String routeName) {
     _routeName=routeName;
   }
}