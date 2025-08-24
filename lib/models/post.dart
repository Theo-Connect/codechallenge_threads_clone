class Post {
  final String username;
  final String? text;
  final List<String>? images;
  final String timeAgo;
  final int replies;
  final int likes;
  final String avatar;

  Post({
    required this.username,
    this.text,
    this.images,
    required this.timeAgo,
    required this.replies,
    required this.likes,
    required this.avatar,
  });
}
