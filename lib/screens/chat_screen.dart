import '../exports.dart';

class ChatScreen extends StatelessWidget {
  final String chatId;
  ChatScreen({super.key, required this.chatId});

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          context.read<RoleProvider>().userRole == RoleType.tenant
              ? 'Chat with Proprietor'
              : 'Chat with Tenant',
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
          children: [
            Expanded(
              child: SizedBox(
                  child: StreamBuilder(
                      stream: context.read<ChatProvider>().streamChat(chatId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<dynamic> chats = snapshot.data!['chat'];
                          return ListView.builder(
                            itemCount: chats.isEmpty ? 0 : chats.length,
                            itemBuilder: (context, index) => Align(
                              alignment: chats[index].keys.first ==
                                      context
                                          .read<AuthProvider>()
                                          .currentUser!
                                          .uid
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(
                                      Responsive.screenWidth(context) * 0.015),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        Responsive.screenHeight(context) * 0.01,
                                    horizontal:
                                        Responsive.screenWidth(context) * 0.02),
                                margin: EdgeInsets.symmetric(
                                    vertical: Responsive.screenHeight(context) *
                                        0.005),
                                child: Text(
                                  snapshot.data!['chat'][index].values.first,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor),
                          );
                        }
                      })),
            ),
            SizedBox(height: Responsive.screenHeight(context) * 0.01),
            CustomizedTextField(
              controller: _messageController,
              labelText: 'Message',
              prefixIcon:
                  Icon(Icons.message, color: Theme.of(context).primaryColor),
              suffixIcon: IconButton(
                  onPressed: () {
                    context.read<ChatProvider>().update(chatId, {
                      context.read<AuthProvider>().currentUser!.uid.toString():
                          _messageController.text
                    });
                    _messageController.clear();
                  },
                  icon:
                      Icon(Icons.send, color: Theme.of(context).primaryColor)),
            )
          ],
        ),
      ),
    );
  }
}
