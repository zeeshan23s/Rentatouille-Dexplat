import 'dart:typed_data';
import '../exports.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({super.key});

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    String userID =
        Provider.of<AuthProvider>(context, listen: false).currentUser!.uid;

    return Consumer<UserProvider>(builder: (context, user, child) {
      return Flexible(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Responsive.screenHeight(context) * 0.02,
              horizontal: Responsive.screenWidth(context) * 0.04),
          child: StreamBuilder(
              stream: user.read(userID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data?.data() != null) {
                    return Column(
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              user.isLoading
                                  ? CircleAvatar(
                                      backgroundColor: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.7),
                                      radius: Responsive.screenHeight(context) *
                                          0.1,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                      ),
                                    )
                                  : snapshot.data!['imageURL'] == null
                                      ? CircleAvatar(
                                          backgroundColor: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.7),
                                          radius:
                                              Responsive.screenHeight(context) *
                                                  0.1,
                                          child: Image.asset(
                                              AppAssets.defaultProfilePic),
                                        )
                                      : CircleAvatar(
                                          radius:
                                              Responsive.screenHeight(context) *
                                                  0.1,
                                          foregroundImage: NetworkImage(
                                              snapshot.data!['imageURL']),
                                        ),
                              Positioned(
                                bottom:
                                    Responsive.screenHeight(context) * 0.005,
                                right: Responsive.screenWidth(context) * 0.02,
                                child: GestureDetector(
                                  onTap: () async {
                                    final XFile? pickedImage = await picker
                                        .pickImage(source: ImageSource.gallery);

                                    if (pickedImage != null) {
                                      final Uint8List image =
                                          await pickedImage.readAsBytes();

                                      await user.updateImage(userID, image,
                                          snapshot.data!['name']);
                                    }
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    radius: Responsive.screenHeight(context) *
                                        0.025,
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                          Responsive.screenHeight(context) *
                                              0.01),
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            height: Responsive.screenHeight(context) * 0.05),
                        CustomizedTextField(
                          controller: TextEditingController(
                              text: snapshot.data!['name']),
                          labelText: 'Full Name',
                          prefixIcon: const Icon(Icons.person),
                          readOnly: true,
                        ),
                        SizedBox(
                            height: Responsive.screenHeight(context) * 0.02),
                        CustomizedTextField(
                          controller: TextEditingController(
                              text: snapshot.data!['email']),
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.person),
                          readOnly: true,
                        ),
                        SizedBox(
                            height: Responsive.screenHeight(context) * 0.02),
                        CustomizedTextField(
                          controller: TextEditingController(
                              text: snapshot.data!['phoneNumber']),
                          labelText: 'Phone Number',
                          prefixIcon: const Icon(Icons.person),
                          readOnly: true,
                        ),
                        SizedBox(
                            height: Responsive.screenHeight(context) * 0.02),
                        CustomizedTextField(
                          controller: TextEditingController(
                              text: snapshot.data!['address']),
                          labelText: 'Address',
                          prefixIcon: const Icon(Icons.person),
                          readOnly: true,
                        ),
                        SizedBox(
                            height: Responsive.screenHeight(context) * 0.04),
                        CustomButton(
                          label: 'Delete Account',
                          onPressed: () async {
                            context.read<AuthProvider>().unregister();
                            await user.delete(userID).whenComplete(() {
                              context.read<AuthProvider>().logout();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      user.status['message'] ??
                                          'Account Deletion Unsuccessful!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: AppColors
                                                  .lightThemePrimaryColor)),
                                  backgroundColor:
                                      user.status['status'] == 'success'
                                          ? Colors.green
                                          : Colors.red,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            });
                          },
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      );
    });
  }
}
