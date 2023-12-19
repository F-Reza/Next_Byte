
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_byte/controllers/search_controller.dart';
import 'package:next_byte/models/user_model.dart';
import 'user_profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final SearchControllerX searchController = Get.put(SearchControllerX());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red,
              title: TextFormField(
                decoration: const InputDecoration(
                  filled: false,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onFieldSubmitted: (value) => searchController.searchUser(value),
              ),
            ),
            body: searchController.searchedUsers.isEmpty
                ? const Center(
              child: Text(
                'Search for users!',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
            : ListView.builder(
              itemCount: searchController.searchedUsers.length,
              itemBuilder: (context, index) {
                UserModel user = searchController.searchedUsers[index];
                return InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserProfileScreen(uid: user.uid),
                    ),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        user.image.toString(),
                      ),
                    ),
                    title: Text(
                      user.name.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
        );
      }
    );
  }
}
