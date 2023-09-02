import '../../exports.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  final _chats = [];

  bool _chatLoading = false;

  @override
  void initState() {
    super.initState();
    getChats();
  }

  void getChats() async {
    _chatLoading = true;

    if (mounted) {
      QuerySnapshot chats = await context
          .read<ChatProvider>()
          .viewChats(context.read<AuthProvider>().currentUser!.uid);

      for (DocumentSnapshot chat in chats.docs) {
        Property? property = await _getPropertyInfo(chat['propertyID']);
        AppUser? user = await _getUserInfo(chat['proprietorID']);
        _chats.add({'chatId': chat.id, 'property': property, 'user': user});
      }
    }

    setState(() {
      _chatLoading = false;
    });
  }

  Future<Property?> _getPropertyInfo(String propertyId) async {
    if (mounted) {
      return await context.read<PropertyProvider>().getProperty(propertyId);
    }
    return null;
  }

  Future<AppUser?> _getUserInfo(String userId) async {
    if (mounted) {
      return await context.read<UserProvider>().getUser(userId);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: _chatLoading == false
          ? _chats.isEmpty
              ? Center(
                  child: Text('No chats available',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500)),
                )
              : ListView.builder(
                  itemCount: _chats.length,
                  itemBuilder: ((context, index) {
                    return Card(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: ListTile(
                        leading: CircleAvatar(
                            foregroundImage: NetworkImage(
                                _chats[index]['property'].imagesURL[0])),
                        title: Text(_chats[index]['property'].title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        subtitle: Text(
                            '${_chats[index]['user'].name}\n(Seller)',
                            style: Theme.of(context).textTheme.bodySmall),
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                          chatId: _chats[index]['chatId'])));
                            },
                            icon: const Icon(Icons.chat_outlined)),
                      ),
                    );
                  }),
                )
          : Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            ),
    );
  }
}
