import 'package:flutter/material.dart';
import 'package:kontena_pos/constants.dart';

class ButtonFilter extends StatelessWidget {
  const ButtonFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 130,
            child: MaterialButton(
              onPressed: () {},
              color: buttoncolor,
              textColor: Colors.white,
              height: 50,
              child: Text(
                'All',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(width: 8),
          Container(
            height: 50,
            width: 130,
            child: MaterialButton(
              onPressed: () {},
              color: buttoncolor,
              textColor: Colors.white,
              height: 50,
              child: Text(
                'Food',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(width: 8),
          Container(
            width: 130,
            height: 50,
            child: MaterialButton(
              onPressed: () {},
              color: buttoncolor,
              textColor: Colors.white,
              height: 65,
              child: Text(
                'Beverage',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(width: 8),
          Container(
            height: 50,
            width: 130,
            child: MaterialButton(
              onPressed: () {},
              color: buttoncolor,
              textColor: Colors.white,
              child: Text('Breakfast',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}
