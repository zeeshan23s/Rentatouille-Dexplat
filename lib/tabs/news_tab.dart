import 'dart:convert';

import '../exports.dart';

class NewsTab extends StatelessWidget {
  const NewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: FutureBuilder<List<News>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text('No data available'),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => NewsContainer(
              title: snapshot.data![index].title,
              newsURL: snapshot.data![index].url,
              imageURL: snapshot.data![index].urlToImage,
              description: snapshot.data![index].description,
            ),
          );
        }
      },
    ));
  }
}

Future<List<News>> fetchData() async {
  Dio dio = Dio();
  List<News> appNews = [];

  dio.options.headers['Authorization'] = '4fb918f8585943ecb9e32ab3c4f3167b';

  final response = await dio.get('https://newsapi.org/v2/everything',
      queryParameters: {'q': 'real estate', 'language': 'en'});

  if (response.statusCode == 200) {
    List<dynamic> data = response.data['articles'];

    for (var element in data) {
      appNews.add(News.fromJson(jsonEncode(element)));
    }
    return appNews;
  } else {
    throw Exception('Failed to load data from the API');
  }
}
