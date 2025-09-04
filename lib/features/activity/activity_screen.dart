import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _generateActivities() {
    return [
      {
        'username': 'john_mobbin',
        'action': 'Mentioned you',
        'content': 'Here\'s a thread you should follow if you love botany @jane_mobbin',
        'time': '4h',
        'avatar': 'https://picsum.photos/100/100?random=300',
        'icon': Icons.alternate_email,
        'iconColor': Colors.green,
      },
      {
        'username': 'john_mobbin',
        'action': 'Starting out my gardening club with thr...',
        'content': 'Count me in!',
        'time': '4h',
        'avatar': 'https://picsum.photos/100/100?random=301',
        'icon': FontAwesomeIcons.reply,
        'iconColor': Colors.blue,
      },
      {
        'username': 'the.plantdads',
        'action': 'Followed you',
        'content': null,
        'time': '5h',
        'avatar': 'https://picsum.photos/100/100?random=302',
        'icon': Icons.person_add,
        'iconColor': Colors.purple,
        'showFollowing': true,
      },
      {
        'username': 'the.plantdads',
        'action': null,
        'content': 'Definitely broken! 🎩 👀 🌱',
        'time': '5h',
        'avatar': 'https://picsum.photos/100/100?random=303',
        'icon': FontAwesomeIcons.heart,
        'iconColor': Colors.pink,
      },
      {
        'username': 'theberryjungle',
        'action': null,
        'content': '🌱 👀 🎩',
        'time': '5h',
        'avatar': 'https://picsum.photos/100/100?random=304',
        'icon': FontAwesomeIcons.heart,
        'iconColor': Colors.pink,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final activities = _generateActivities();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Activity',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Theme.of(context).brightness == Brightness.dark 
                ? Colors.black 
                : Colors.white,
              unselectedLabelColor: Theme.of(context).brightness == Brightness.dark 
                ? Colors.white 
                : Colors.black,
              indicator: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark 
                  ? Colors.white 
                  : Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: const EdgeInsets.symmetric(horizontal: 20),
              tabs: const [
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text('All'),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text('Replies'),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text('Mentions'),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text('Verified'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildActivityList(activities),
                  _buildActivityList(activities.where((a) => a['icon'] == FontAwesomeIcons.reply).toList()),
                  _buildActivityList(activities.where((a) => a['action'] == 'Mentioned you').toList()),
                  _buildActivityList([]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityList(List<Map<String, dynamic>> activities) {
    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(activity['avatar']),
              ),
              Positioned(
                bottom: -2,
                right: -2,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: activity['iconColor'],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor, 
                      width: 2
                    ),
                  ),
                  child: Icon(
                    activity['icon'],
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          title: Row(
            children: [
              Text(
                activity['username'],
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                activity['time'],
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (activity['action'] != null) ...[
                Text(
                  activity['action'],
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
              ],
              if (activity['content'] != null)
                Text(
                  activity['content'],
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark 
                      ? Colors.white 
                      : Colors.black,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
          trailing: activity['showFollowing'] == true
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark 
                        ? Colors.grey.shade600 
                        : Colors.grey.shade300
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Following',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        );
      },
    );
  }
}