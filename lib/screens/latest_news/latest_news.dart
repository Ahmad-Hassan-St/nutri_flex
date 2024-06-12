import 'package:flutter/material.dart';
import 'package:lifefit/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/api_services.dart';
import '../../services/url_lanucher.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = ApiServices().apiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(child: Text('Home Feed',style:Theme.of(context).textTheme.displayLarge)),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data found.'));
          } else {
            var articles = snapshot.data!['articles'];
            return ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                var article = articles[index];
                return CustomListTile(
                  title: article['title'],
                  description: article['description'] ?? 'No description available.',
                  imageUrl: article['urlToImage'] ?? 'https://via.placeholder.com/400x160',
                  linkUrl: article['url'],
                );
              },
            );
          }
        },
      ),
    );
  }
}

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
                    foregroundColor: Colors.white, // foreground (text) color
                    backgroundColor: Colors.white, // background color
                    shadowColor: Colors.black, // shadow color
                    elevation: 10, // elevation of button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // rounded corners
                    ),
                  ),
                  onPressed: () async {
                    ContactUs.open(linkUrl);
                  },
                  child: Text('Read Now',style: Theme.of(context).textTheme.displayMedium,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
