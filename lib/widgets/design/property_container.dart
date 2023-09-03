import '../../exports.dart';

class PropertyContainer extends StatelessWidget {
  final Property property;
  const PropertyContainer({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    String location = '';
    List<String> locationList = property.address.split(' ');
    for (String txt in locationList) {
      location = '$location${txt.replaceFirst(txt[0], txt[0].toUpperCase())} ';
    }
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
                          image: NetworkImage(property.imagesURL.isEmpty
                              ? 'data:image/png;base64,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'
                              : property.imagesURL.first),
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
                location.trimRight(),
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
