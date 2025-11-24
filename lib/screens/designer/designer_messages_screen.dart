import 'package:flutter/material.dart';
import '../../config/app_routes.dart';

class Message {
  final String id;
  final String senderName;
  final String senderImage;
  final String message;
  final String time;
  final bool isRead;
  final int unreadCount;

  Message({
    required this.id,
    required this.senderName,
    required this.senderImage,
    required this.message,
    required this.time,
    required this.isRead,
    required this.unreadCount,
  });
}

class DesignerMessagesScreen extends StatefulWidget {
  const DesignerMessagesScreen({super.key});

  @override
  State<DesignerMessagesScreen> createState() => _DesignerMessagesScreenState();
}

class _DesignerMessagesScreenState extends State<DesignerMessagesScreen> {
  final List<Message> _messages = [
    Message(
      id: '1',
      senderName: 'John Doe',
      senderImage: '',
      message: 'Hi, I need some changes in the design',
      time: '10:30 AM',
      isRead: false,
      unreadCount: 3,
    ),
    Message(
      id: '2',
      senderName: 'Sarah Wilson',
      senderImage: '',
      message: 'Thanks for the quick response!',
      time: '09:15 AM',
      isRead: false,
      unreadCount: 1,
    ),
    Message(
      id: '3',
      senderName: 'Mike Johnson',
      senderImage: '',
      message: 'Can we schedule a call today?',
      time: 'Yesterday',
      isRead: false,
      unreadCount: 2,
    ),
    Message(
      id: '4',
      senderName: 'Emily Brown',
      senderImage: '',
      message: 'The design looks perfect!',
      time: 'Yesterday',
      isRead: true,
      unreadCount: 0,
    ),
    Message(
      id: '5',
      senderName: 'David Lee',
      senderImage: '',
      message: 'When can we start the project?',
      time: '2 days ago',
      isRead: true,
      unreadCount: 0,
    ),
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredMessages = _messages.where((message) {
      return message.senderName.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          message.message.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search messages...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Messages List
          Expanded(
            child: filteredMessages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.message_outlined,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No messages found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredMessages.length,
                    itemBuilder: (context, index) {
                      final message = filteredMessages[index];
                      return _MessageCard(
                        message: message,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.designerChat,
                            arguments: {
                              'customerId': message.id,
                              'customerName': message.senderName,
                            },
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter Messages',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.mark_email_unread),
                title: const Text('Unread Messages'),
                onTap: () {
                  Navigator.pop(context);
                  // Apply filter
                },
              ),
              ListTile(
                leading: const Icon(Icons.mark_email_read),
                title: const Text('Read Messages'),
                onTap: () {
                  Navigator.pop(context);
                  // Apply filter
                },
              ),
              ListTile(
                leading: const Icon(Icons.list),
                title: const Text('All Messages'),
                onTap: () {
                  Navigator.pop(context);
                  // Apply filter
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MessageCard extends StatelessWidget {
  final Message message;
  final VoidCallback onTap;

  const _MessageCard({required this.message, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: message.isRead ? 0 : 2,
      color: message.isRead ? Colors.white : Colors.blue[50],
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orange,
          child: Text(
            message.senderName[0].toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                message.senderName,
                style: TextStyle(
                  fontWeight: message.isRead
                      ? FontWeight.normal
                      : FontWeight.bold,
                ),
              ),
            ),
            Text(
              message.time,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(
                message.message,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: message.isRead
                      ? FontWeight.normal
                      : FontWeight.w500,
                ),
              ),
            ),
            if (message.unreadCount > 0)
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  message.unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
