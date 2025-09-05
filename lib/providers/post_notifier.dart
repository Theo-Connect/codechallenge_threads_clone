import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads_clone/models/post.dart';

class PostNotifier extends Notifier<PostState> {
  @override
  PostState build() {
    return PostState(userPosts: []);
  }

  void addPost(Post post) {
    state = PostState(userPosts: [post, ...state.userPosts]);
  }
}

class PostState {
  final List<Post> userPosts;

  PostState({required this.userPosts});
}

final postProviderNotifier = NotifierProvider<PostNotifier, PostState>(() {
  return PostNotifier();
});