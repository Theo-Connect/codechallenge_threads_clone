import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_clone/models/post.dart';
import 'package:threads_clone/providers/post_notifier.dart';
import 'package:threads_clone/widgets/post_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _getThreadText(int index) {
    final threadTexts = [
      'Just finished my morning coffee and ready to tackle the day! ☕️',
      'Anyone else think this weather is absolutely perfect today?',
      'Working on a new project and feeling excited about the possibilities 🚀',
      'Sometimes the best conversations happen in the most unexpected places',
      'Reminder: it\'s okay to take breaks and prioritize your mental health',
      'That moment when you finally solve a problem you\'ve been stuck on for hours 💡',
      'Currently reading an amazing book that I can\'t put down',
      'Food for thought: what if we approached every challenge as an opportunity?',
      'Grateful for the small moments that make life beautiful',
      'Pro tip: always keep learning, no matter how experienced you become',
      'The sunset tonight was absolutely breathtaking 🌅',
      'Sometimes you need to step back to see the bigger picture',
      'Celebrating small wins because they add up to big achievements',
      'Music has this incredible power to change your entire mood',
      'Just had the most interesting conversation with a stranger today',
    ];
    return threadTexts[index % threadTexts.length];
  }

  List<Post> _generatePosts() {
    final faker = Faker();
    final timeOptions = [
      '1m',
      '5m',
      '15m',
      '1h',
      '2h',
      '5h',
      '8h',
      '12h',
      '1d',
      '2d',
      '3d'
    ];

    return List.generate(15, (index) {
      final hasImages = faker.randomGenerator.boolean();
      final imageCount =
          hasImages ? faker.randomGenerator.integer(3, min: 1) : 0;

      return Post(
        username: faker.internet.userName().toLowerCase(),
        text: _getThreadText(index),
        images: imageCount > 0
            ? List.generate(imageCount,
                (i) => 'https://picsum.photos/400/400?random=${index * 10 + i}')
            : null,
        timeAgo: timeOptions[faker.randomGenerator.integer(timeOptions.length)],
        replies: faker.randomGenerator.integer(100),
        likes: faker.randomGenerator.integer(500),
        avatar: 'https://picsum.photos/100/100?random=${index + 100}',
      );
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = _generatePosts();
    final postState = ref.watch(postProviderNotifier);
    final allPosts = [...postState.userPosts, ...posts];
        
    return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Icon(
                  FontAwesomeIcons.threads,
                  color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.white 
                    : Colors.black,
                  size: 36,
                ),
                centerTitle: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                floating: true,
                snap: true,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => PostWidget(post: allPosts[index]),
                  childCount: allPosts.length,
                ),
              ),
            ],
          ),
    );
  }
}
