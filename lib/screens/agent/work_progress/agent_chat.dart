import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class AgentChat extends StatefulWidget {
  const AgentChat({super.key});

  @override
  State<AgentChat> createState() => _AgentChatState();
}

class _AgentChatState extends State<AgentChat> {
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> _chats = [
    {
      'name': 'Priya Sharma',
      'role': 'Designer',
      'lastMessage': 'Design is ready for review',
      'time': '10:30 AM',
      'unread': 2,
      'avatar': Icons.person,
    },
    {
      'name': 'Rohan Gupta',
      'role': 'Designer',
      'lastMessage': 'Can we schedule a call?',
      'time': 'Yesterday',
      'unread': 0,
      'avatar': Icons.person,
    },
    {
      'name': 'Material Vendors',
      'role': 'Vendor',
      'lastMessage': 'Order will be delivered tomorrow',
      'time': '2 days ago',
      'unread': 1,
      'avatar': Icons.store,
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: AppColors.agentModule,
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: ListView.builder(
        itemCount: _chats.length,
        itemBuilder: (context, index) => _buildChatTile(_chats[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.agentModule,
        child: const Icon(Icons.add_comment, color: Colors.white),
      ),
    );
  }

  Widget _buildChatTile(Map<String, dynamic> chat) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.agentModule.withOpacity(0.2),
          child: Icon(chat['avatar'], color: AppColors.agentModule, size: 28),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                chat['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              chat['time'],
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chat['role'],
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              chat['lastMessage'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: chat['unread'] > 0
            ? Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.agentModule,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  chat['unread'].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
        onTap: () => _openChatScreen(chat),
      ),
    );
  }

  void _openChatScreen(Map<String, dynamic> chat) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _ChatScreen(chat: chat)),
    );
  }
}

class _ChatScreen extends StatefulWidget {
  final Map<String, dynamic> chat;

  const _ChatScreen({required this.chat});

  @override
  State<_ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<_ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hello! How can I help you?', 'isSent': false, 'time': '10:00 AM'},
    {
      'text': 'I need to discuss the design',
      'isSent': true,
      'time': '10:01 AM',
    },
    {
      'text': 'Sure! Design is ready for review',
      'isSent': false,
      'time': '10:30 AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSkyBlue,
      appBar: AppBar(
        backgroundColor: AppColors.agentModule,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(widget.chat['avatar'], color: AppColors.agentModule),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chat['name'],
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    widget.chat['role'],
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.videocam), onPressed: () {}),
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isSent = message['isSent'] as bool;
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isSent ? AppColors.agentModule : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message['text'],
              style: TextStyle(color: isSent ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 4),
            Text(
              message['time'],
              style: TextStyle(
                color: isSent ? Colors.white70 : Colors.grey[600],
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.attach_file, color: AppColors.agentModule),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            mini: true,
            onPressed: () {
              if (_messageController.text.isNotEmpty) {
                // Send message logic
                _messageController.clear();
              }
            },
            backgroundColor: AppColors.agentModule,
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
