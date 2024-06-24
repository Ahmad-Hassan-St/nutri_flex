import 'package:flutter/material.dart';

import '../services/url_lanucher.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String linkUrl;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.linkUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffebf6d6),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Container(
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    // foreground (text) color
                    backgroundColor: Colors.white,
                    // background color
                    shadowColor: Colors.black,
                    // shadow color
                    elevation: 10,
                    // elevation of button
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(20), // rounded corners
                    ),
                  ),
                  onPressed: () async {
                    ContactUs.open(linkUrl);
                  },
                  child: Text(
                    'Read Now',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
