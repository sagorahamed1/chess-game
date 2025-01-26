

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/custom_button.dart';

class WhiteOrBlackOptionDialog extends StatefulWidget {
  const WhiteOrBlackOptionDialog({super.key});

  @override
  _WhiteOrBlackOptionDialogState createState() => _WhiteOrBlackOptionDialogState();
}

class _WhiteOrBlackOptionDialogState extends State<WhiteOrBlackOptionDialog> {
  String selectedOption = 'White';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        SizedBox(height: 35.h),

        Center(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey[300], // Background color
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSegment('White', Icons.person, Colors.blue),
                // _buildSegment('Random', Icons.people, Colors.black),
                _buildSegment('Black', Icons.person, Colors.black),
              ],
            ),
          ),
        ),



        SizedBox(height: 35.h),

        CustomButton(title: "Play", onpress: (){

        })
      ],
    );
  }

  Widget _buildSegment(String text, IconData icon, Color iconColor) {
    final bool isSelected = selectedOption == text; // Check if selected
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedOption = text; // Update selected option
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? iconColor : Colors.grey,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? iconColor : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

