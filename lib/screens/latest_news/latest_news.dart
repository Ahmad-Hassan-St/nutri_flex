import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lifefit/constants/colors.dart';
import 'package:lifefit/screens/chat/chat_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../chat_module/screens/home_screen.dart';
import '../../components/news_custom_list_tile.dart';
import '../../services/api_services.dart';
import '../../services/check_internet_services.dart';
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
    print(futureData);
  }

  @override
  Widget build(BuildContext context) {
    futureData = ApiServices().apiData();
    print(futureData);
    Connectivity connectivity =  Connectivity() ;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title:
            Text('Home Feed', style: Theme.of(context).textTheme.displayLarge),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 18.0,
              top: 10,
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomeScreen()));
                },
                icon: const Icon(Icons.chat_outlined)),
          )
        ],
      ),
      body: StreamBuilder<ConnectivityResult>(
        stream: connectivity.onConnectivityChanged,
        builder: (_, snapshot){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CheckInternetConnectionWidget(
              snapshot: snapshot,
              widget: FutureBuilder<Map<String, dynamic>>(
                future: futureData,
                builder: (context, snapshot) {
                  return _buildContent(snapshot);
                },
              ),
            ),
          ) ;
        },
      ),
    );
  }

  Widget _buildContent(AsyncSnapshot<Map<String, dynamic>> snapshot) {
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
            imageUrl:
                article['urlToImage'] ?? 'https://via.placeholder.com/400x160',
            linkUrl: article['url'],
          );
        },
      );
    }
  }
}

