import 'package:get/get.dart';
import '../../domain/usecases/get_users.dart';
import '../../domain/entities/user.dart';
import '../../core/errors/failures.dart';
import 'package:flutter/material.dart';

class UserController extends GetxController {
  final GetUsers getUsers;
  UserController({required this.getUsers});

  final users = <User>[].obs;
  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final hasMore = true.obs;
  final error = RxnString();
  final query = ''.obs;
  final scrollController = ScrollController();

  int _page = 1;
  final int _perPage = 10;

  @override
  void onInit() {
    super.onInit();
    fetchUsers(initial: true);


    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  Future<void> fetchUsers({bool initial = false, bool refresh = false}) async {
    if (isLoading.value || isLoadingMore.value) return;

    if (refresh || initial) {
      _page = 1;
      hasMore.value = true;
      users.clear();
    }

    if (_page == 1) {
      isLoading.value = true;
    } else {
      isLoadingMore.value = true;
    }

    error.value = null;

    final res = await getUsers(page: _page, perPage: _perPage);

    res.fold(
          (failure) {
        if (_page == 1 && users.isEmpty) {
          error.value = failure is CacheFailure
              ? 'No cached data available.'
              : 'Failed to load users. Please try again.';
        }
      },
          (fetched) {
        if (fetched.isEmpty) {
          hasMore.value = false;
        } else {
          users.addAll(fetched);
          if (fetched.length < _perPage) {
            hasMore.value = false;
          } else {
            _page++;
          }
        }
      },
    );

    isLoading.value = false;
    isLoadingMore.value = false;
  }

  Future<void> loadMore() async {
    if (!hasMore.value || isLoadingMore.value) return;
    await fetchUsers();
  }

  Future<void> refresh() async => fetchUsers(refresh: true);

  void search(String q) {
    query.value = q.trim().toLowerCase();
  }

  List<User> get filteredUsers {
    final q = query.value;
    if (q.isEmpty) return users;
    return users.where((u) {
      final name = '${u.firstName} ${u.lastName}'.toLowerCase();
      return name.contains(q);
    }).toList();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
