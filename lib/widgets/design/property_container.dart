import '../../exports.dart';

class PropertyContainer extends StatelessWidget {
  final Property property;
  const PropertyContainer({super.key, required this.property});

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
            Stack(
              children: [
                Container(
                  height: Responsive.screenHeight(context) * 0.25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          Responsive.screenWidth(context) * 0.025),
                      image: DecorationImage(
                          image: NetworkImage(property.imagesURL[0]),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                  left: Responsive.screenWidth(context) * 0.025,
                  top: Responsive.screenHeight(context) * 0.020,
                  child: Container(
                    height: Responsive.screenHeight(context) * 0.05,
                    width: Responsive.screenWidth(context) * 0.45,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(
                          Responsive.screenWidth(context) * 0.025),
                    ),
                    child: Center(
                      child: Text(
                        'RS ${property.monthlyRent}/month',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )
              ],
            ),
            ListTile(
              title: Text(
                property.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                property.address,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.justify,
              ),
              trailing: IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PropertyDetailScreen(property: property))),
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
