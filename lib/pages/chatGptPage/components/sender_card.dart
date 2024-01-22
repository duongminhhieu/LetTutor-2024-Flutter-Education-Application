import 'package:flutter/material.dart';

StatelessWidget senderCard(Size size, String text) {
  return Container(
    alignment: Alignment.topRight,
    margin: const EdgeInsets.only(right: 16.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          padding: const EdgeInsets.all(16.0),
          // width: size.width * .64,
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.12),
                    offset: const Offset(0, 27),
                    blurRadius: 27,
                    spreadRadius: .5)
              ]),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width * .64),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        ),
      ],
    ),
  );
}
