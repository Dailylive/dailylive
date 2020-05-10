//import 'package:flutter/material.dart';
//class UserDetailsWithFollowKeys {
//  static final ValueKey userDetails = ValueKey("UserDetails");
//  static final ValueKey follow = ValueKey("follow");
//}
//
//class UserDetailsWithFollow extends StatelessWidget {
//  final UserModel userData;
//
//  const UserDetailsWithFollow({Key key, @required this.userData})
//      : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Row(
//      crossAxisAlignment: CrossAxisAlignment.center,
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//      children: <Widget>[
//        Expanded(
//          flex: 2,
//          child: UserDetails(
//            key: UserDetailsWithFollowKeys.userDetails,
//            userData: userData,
//          ),
//        ),
//        Expanded(
//          flex: 1,
//          child: Container(
//            key: UserDetailsWithFollowKeys.follow,
//            alignment: Alignment.centerRight,
//            child: IconButton(
//              icon: Icon(Icons.group_add), onPressed: () {},
//            ),
//          ),
//        ),
//      ],
//    );
//  }
//}
//class UserDetails extends StatelessWidget {
//  final UserModel userData;
//
//  const UserDetails({Key key, @required this.userData}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return InheritedUserModel(
//      userData: userData,
//      child: Container(
//        child: Row(children: <Widget>[_UserImage(), _UserNameAndEmail()]),
//      ),
//    );
//  }
//}