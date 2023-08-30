import '../../exports.dart';

class NewsContainer extends StatelessWidget {
  final String title;
  final String? imageURL;
  final String newsURL;
  final String description;
  final Color backgroundColor;
  final Color foregroundColor;

  const NewsContainer(
      {super.key,
      required this.title,
      this.imageURL,
      required this.newsURL,
      required this.description,
      required this.backgroundColor,
      required this.foregroundColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      margin: EdgeInsets.symmetric(
          horizontal: Responsive.screenWidth(context) * 0.02,
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
              subtitle: Text(description,
                  style: Theme.of(context).textTheme.bodySmall),
            ),
          ],
        ),
      ),
    );
  }
}
