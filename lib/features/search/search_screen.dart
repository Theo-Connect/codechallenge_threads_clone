import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  List<Map<String, dynamic>> _generateUsers() {
    final faker = Faker();
    final usernames = [
      'rjmithun',
      'vicenews', 
      'trevornoah',
      'condenasttraveller',
      'chef_pillai',
      'malala',
      'sebin_cyriac'
    ];
    
    final descriptions = [
      'Mithun',
      'VICE News',
      'Trevor Noah', 
      'Condé Nast Traveller',
      'Suresh Pillai',
      'Malala Yousafzai',
      'Fishing_freaks'
    ];
    
    final followers = ['26.6K', '301K', '789K', '130K', '69.2K', '237K', '53.2K'];
    
    return List.generate(7, (index) => {
      'username': usernames[index],
      'description': descriptions[index],
      'followers': followers[index],
      'avatar': faker.image.image(width: 100, height: 100, random: true),
      'isVerified': true,
    });
  }

  @override
  Widget build(BuildContext context) {
    final users = _generateUsers();
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Search',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.grey.shade800 
                    : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(user['avatar']),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    user['username'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  if (user['isVerified']) ...[
                                    const SizedBox(width: 4),
                                    const FaIcon(
                                      FontAwesomeIcons.solidCircleCheck,
                                      color: Colors.blue,
                                      size: 14,
                                    ),
                                  ],
                                ],
                              ),
                              Text(
                                user['description'],
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${user['followers']} followers',
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).brightness == Brightness.dark 
                                ? Colors.grey.shade600 
                                : Colors.grey.shade300
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Follow',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}