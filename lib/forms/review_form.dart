import '../exports.dart';

class ReviewForm extends StatefulWidget {
  final String propertyId;
  const ReviewForm({super.key, required this.propertyId});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  int review = -1;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, child) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: Responsive.screenHeight(context) * 0.45,
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Responsive.screenHeight(context) * 0.04,
                      horizontal: Responsive.screenWidth(context) * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Give Review',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                          height: Responsive.screenHeight(context) * 0.005),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'What do you think about this property?',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(height: Responsive.screenHeight(context) * 0.02),
                      review != -1
                          ? Center(
                              child: Text(
                                reviewStatus(review),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(height: Responsive.screenHeight(context) * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (index) => IconButton(
                            onPressed: () {
                              setState(() {
                                review = index;
                              });
                            },
                            icon: Icon(
                              index <= review ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Responsive.screenHeight(context) * 0.03),
                      CustomButton(
                        onPressed: () {
                          if (review != -1) {
                            context.read<ReviewProvider>().update(
                                widget.propertyId,
                                review + 1,
                                context.read<AuthProvider>().currentUser!.uid);
                            Navigator.pop(context);
                          }
                        },
                        label: 'Submit',
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        isLoading: auth.isLoading,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

String reviewStatus(int review) {
  switch (review) {
    case 0:
      {
        return 'Very Bad';
      }
    case 1:
      {
        return 'Bad';
      }
    case 2:
      {
        return 'Average';
      }
    case 3:
      {
        return 'Good';
      }
    default:
      {
        return 'Very Good';
      }
  }
}
