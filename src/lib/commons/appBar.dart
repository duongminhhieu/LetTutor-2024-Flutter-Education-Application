import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: SvgPicture.asset('lib/assets/images/lettutor_logo.svg',
          semanticsLabel: "My SVG", height: 36),
      actions: [
        MaterialButton(
          onPressed: () {},
          minWidth: 20,
          color: Colors.grey.shade300,
          textColor: Colors.white,
          padding: const EdgeInsets.all(6),
          shape: const CircleBorder(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SvgPicture.asset('lib/assets/images/vietnam.svg',
                semanticsLabel: "My SVG", height: 18),
          ),
        ),
        Container(
          child: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.grey,
            ),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
