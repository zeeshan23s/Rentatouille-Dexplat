import 'package:url_launcher/url_launcher_string.dart';

import '../../exports.dart';

class NewsContainer extends StatelessWidget {
  final String title;
  final String? imageURL;
  final String newsURL;
  final String description;

  const NewsContainer({
    super.key,
    required this.title,
    this.imageURL,
    required this.newsURL,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: EdgeInsets.symmetric(
          horizontal: Responsive.screenWidth(context) * 0.04,
          vertical: Responsive.screenHeight(context) * 0.01),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Responsive.screenHeight(context) * 0.01,
            horizontal: Responsive.screenWidth(context) * 0.02),
        child: Column(
          children: [
            Image.network(
              imageURL ?? AppAssets.defaultNewsImage,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              width: Responsive.screenWidth(context) * 0.35,
              child: CustomButton(
                  label: 'View',
                  onPressed: () async {
                    if (await canLaunchUrlString(newsURL)) {
                      await launchUrlString(newsURL,
                          mode: LaunchMode.externalApplication);
                    }
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).scaffoldBackgroundColor),
            )
          ],
        ),
      ),
    );
  }
}
