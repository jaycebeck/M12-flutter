import 'package:flutter/material.dart';

import '../main.dart';
import '../pages/events_example.dart';

class myAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Text('M12 Calendar'),
      leading: IconButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => StartPage())),
          icon: Icon(Icons.home_outlined)),
      actions: [
        IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => TableEventsExample())),
            icon: Icon(Icons.calendar_month_outlined)),
        //IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LogOutPage())), icon: Icon(Icons.logout_outlined)),
        //IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LogOutPage())), icon: Icon(Icons.login_outlined))
      ],
    ) as PreferredSizeWidget;
  }
}
