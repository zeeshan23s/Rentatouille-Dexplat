import '../exports.dart';

class RentHistoryScreen extends StatelessWidget {
  final List<dynamic> rentHistroy;
  const RentHistoryScreen({super.key, required this.rentHistroy});

  @override
  Widget build(BuildContext context) {
    debugPrint(rentHistroy.toString());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Rent History',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Responsive.screenHeight(context) * 0.02,
            horizontal: Responsive.screenWidth(context) * 0.04),
        child: Column(
          children: rentHistroy.asMap().entries.map((e) {
            DateTime paymentDate = DateTime.fromMicrosecondsSinceEpoch(
                e.value['receivedDate'].microsecondsSinceEpoch);
            return Card(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Responsive.screenHeight(context) * 0.01,
                    horizontal: Responsive.screenWidth(context) * 0.04),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Jan 2023',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: Responsive.screenWidth(context) * 0.08),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Status: ',
                            style: Theme.of(context).textTheme.bodySmall,
                            children: <TextSpan>[
                              TextSpan(
                                text: e.value['receivedDate'] != null
                                    ? 'Paid'
                                    : 'Unpaid',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            height: Responsive.screenHeight(context) * 0.0025),
                        RichText(
                          text: TextSpan(
                            text: 'Payment Date: ',
                            style: Theme.of(context).textTheme.bodySmall,
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    '${checkMonth(paymentDate.month)} ${paymentDate.day}, ${paymentDate.year}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

String checkMonth(int month) {
  switch (month) {
    case 1:
      {
        return 'Jan';
      }
    case 2:
      {
        return 'Feb';
      }
    case 3:
      {
        return 'Mar';
      }
    case 4:
      {
        return 'Apr';
      }
    case 5:
      {
        return 'May';
      }
    case 6:
      {
        return 'Jun';
      }
    case 7:
      {
        return 'Jul';
      }
    case 8:
      {
        return 'Aug';
      }
    case 9:
      {
        return 'Sep';
      }
    case 10:
      {
        return 'Oct';
      }
    case 11:
      {
        return 'Nov';
      }
    default:
      {
        return 'Dec';
      }
  }
}
