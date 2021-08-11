import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/DetailProvider.dart';

class ReviewDialog extends StatefulWidget {
  final String id;
  final DetailProvider state;
  const ReviewDialog(
    this.id,
    this.state, {
    Key? key,
  }) : super(key: key);

  @override
  _ReviewDialogState createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _review = TextEditingController();

  void submitForm() {
    Map<String, dynamic> data = {
      'id': widget.id,
      'name': _name.text,
      'review': _review.text
    };

    widget.state.addReview(json.encode(data));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 350,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Review",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 16),
                Text('Name'),
                SizedBox(
                  height: 4,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextField(
                    controller: _name,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text('Review'),
                SizedBox(
                  height: 4,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextField(
                    controller: _review,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 1,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                  ),
                  child: Text('Close'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_name.text.isNotEmpty && _review.text.isNotEmpty) {
                      submitForm();
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                  ),
                  child: Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
