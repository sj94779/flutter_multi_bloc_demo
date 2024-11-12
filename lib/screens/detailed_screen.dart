
import 'package:flutter/material.dart';

import '../model/user_model.dart';

class DetailedScreen extends StatelessWidget {
  const DetailedScreen( {super.key, required this.e});
  final UserModel e;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                maxRadius: 100,
                backgroundImage: NetworkImage(e.avatar!),
              ),
            ),
            SizedBox(height: 20,),
            Text(e.firstName! + " " + e.lastName!,style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold)),
            SizedBox(height: 10,),
            Text(e.email! , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.normal))

          ],
        ),),
      ),
    );
  }
}
