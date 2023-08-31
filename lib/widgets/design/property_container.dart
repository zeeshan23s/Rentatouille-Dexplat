import '../../exports.dart';

class PropertyContainer extends StatelessWidget {
  const PropertyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: EdgeInsets.symmetric(
          vertical: Responsive.screenHeight(context) * 0.01),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Responsive.screenHeight(context) * 0.01,
            horizontal: Responsive.screenWidth(context) * 0.02),
        child: Column(
          children: [
            Container(
              height: Responsive.screenHeight(context) * 0.25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      Responsive.screenWidth(context) * 0.025),
                  image: DecorationImage(
                      image: NetworkImage(AppAssets.defaultNewsImage),
                      fit: BoxFit.cover)),
            ),
            ListTile(
              title: Text(
                "Testing",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                'Rawalpindi',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.justify,
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_outward_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
