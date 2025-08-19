import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/models/post.dart';
import 'package:threads_clone/widgets/post_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        text: faker.randomGenerator.boolean() ? faker.lorem.sentence() : null,
        images: imageCount > 0
            ? List.generate(imageCount,
                (i) => faker.image.image(width: 400, height: 400, random: true))
            : null,
        timeAgo: timeOptions[faker.randomGenerator.integer(timeOptions.length)],
        replies: faker.randomGenerator.integer(100),
        likes: faker.randomGenerator.integer(500),
        avatar: faker.image.image(width: 100, height: 100, random: true),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final posts = _generatePosts();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Icon(
              FontAwesomeIcons.threads,
              color: Colors.black,
              size: Sizes.size36,
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            floating: true,
            snap: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => PostWidget(post: posts[index]),
              childCount: posts.length,
            ),
          ),
        ],
      ),
    );
  }
}
