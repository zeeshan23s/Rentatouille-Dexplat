import '../../exports.dart';

class CreateUserScreen extends StatelessWidget {
  CreateUserScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, user, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Create Account',
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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomizedTextField(
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'Name can\'t be blank';
                      }
                      return null;
                    }),
                    controller: _nameController,
                    labelText: 'Full Name',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  SizedBox(height: Responsive.screenHeight(context) * 0.015),
                  CustomizedTextField(
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'Phone number can\'t be blank';
                      }
                      return null;
                    }),
                    controller: _phoneController,
                    labelText: 'Phone Number',
                    prefixIcon: const Icon(Icons.phone),
                  ),
                  SizedBox(height: Responsive.screenHeight(context) * 0.015),
                  CustomizedTextField(
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'Address can\'t be blank';
                      }
                      return null;
                    }),
                    controller: _addressController,
                    labelText: 'Address',
                    prefixIcon: const Icon(Icons.home),
                  ),
                  SizedBox(height: Responsive.screenHeight(context) * 0.03),
                  CustomButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await user
                            .create(
                          AppUser(
                              id: context.read<AuthProvider>().currentUser!.uid,
                              name: _nameController.text,
                              email: context
                                  .read<AuthProvider>()
                                  .currentUser!
                                  .email!,
                              phoneNumber: _phoneController.text,
                              address: _addressController.text),
                        )
                            .whenComplete(() {
                          context.read<AuthProvider>().setIsNewUser(false);
                        });
                      }
                    },
                    label: 'Create',
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                    isLoading: user.isLoading,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
