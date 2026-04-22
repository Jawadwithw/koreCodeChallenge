import 'package:flutter/material.dart';
import 'package:korecotask/const_data/fake_users_generator.dart';
import 'package:korecotask/const_paths/images_paths.dart';
import 'package:korecotask/features/dashboard/presentation/widgets/users_data_modal.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, dynamic>> allUsers = FakeUsersGenerator().dashboardData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF0F8F83),
      ),
      body: Stack(
        children: [
          Image.asset(
            ImagesPaths.bg,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            width: MediaQuery.sizeOf(context).width,
            color: Colors.black.withOpacity(0.5),
            child: Container(
              margin: EdgeInsets.only(top: 24),

              child: ListView.builder(
                itemCount: allUsers.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),

                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      onTap: () {
                        //go to details of that item
                        showUserModal(allUsers[index]['data']);
                      },
                      title: Text(
                        allUsers[index]['title'],
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),

                      subtitle: Text(
                        "Count: ${allUsers[index]['data'].where((user) => user["is_active"] == true).length}",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showUserModal(dynamic usersDataList) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return UsersDataModalWidget(
          users: usersDataList,

          onUpdate: () {
            setState(() {});
          },
        );
      },
    );
  }
}
