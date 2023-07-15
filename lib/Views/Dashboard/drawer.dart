import 'package:flutter/material.dart';
import 'package:shopsavvy/Models/DB/User.dart';
import 'package:shopsavvy/Models/Utils/Colors.dart';
import 'package:shopsavvy/Models/Utils/Common.dart';
import 'package:shopsavvy/Models/Utils/Images.dart';
import 'package:shopsavvy/Models/Utils/Routes.dart';
import 'package:shopsavvy/Views/Auth/login.dart';
import 'package:shopsavvy/Views/Cart/History.dart';

class DashboardMenu extends StatefulWidget {
  int selection = 1;

  DashboardMenu({Key? key, required selection}) : super(key: key);

  @override
  _DashboardMenuState createState() =>
      _DashboardMenuState(selection: selection);
}

class _DashboardMenuState extends State<DashboardMenu> {
  int selection;
  User? storedUser;
  bool isDataLoaded = false;

  _DashboardMenuState({required this.selection});

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    storedUser = await User.getUser();
    setState(() {
      isDataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isDataLoaded
        ? Container(
            width: displaySize.width * 0.6,
            decoration: BoxDecoration(color: color6),
            child: ListView(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: displaySize.height * 0.15,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 60.0,
                          width: 60.0,
                          child: ClipOval(
                            child: Image.asset(
                              user,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  storedUser!.name,
                                  style: TextStyle(
                                      color: color3,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  storedUser!.email,
                                  style: TextStyle(
                                      color: color3,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
                ListTile(
                  tileColor:
                      (selection == 1) ? color4.withOpacity(0.3) : color6,
                  leading: Icon(
                    Icons.home,
                    color: color3.withOpacity(0.8),
                  ),
                  title: Text(
                    'Home',
                    style:
                        TextStyle(color: color3, fontWeight: FontWeight.w400),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: color3,
                    size: 15.0,
                  ),
                ),
                (storedUser!.usertype == '3')
                    ? ListTile(
                        tileColor:
                            (selection == 1) ? color4.withOpacity(0.3) : color6,
                        leading: Icon(
                          Icons.inventory_outlined,
                          color: color3.withOpacity(0.8),
                        ),
                        title: Text(
                          'History',
                          style: TextStyle(
                              color: color3, fontWeight: FontWeight.w400),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: color3,
                          size: 15.0,
                        ),
                        onTap: () {
                          Routes(context: context).navigate(History());
                        },
                      )
                    : const SizedBox.shrink(),
                ListTile(
                  tileColor: color6,
                  leading: Icon(
                    Icons.logout,
                    color: color3.withOpacity(0.8),
                  ),
                  title: Text(
                    'Logout',
                    style:
                        TextStyle(color: color3, fontWeight: FontWeight.w400),
                  ),
                  onTap: () {
                    Routes(context: context).navigateReplace(const Login());
                  },
                ),
              ],
            ),
          )
        : CircularProgressIndicator();
  }
}
