import 'package:flutter/material.dart';
import 'package:threads_clone/models/post.dart';

class PostProvider extends ChangeNotifier {
  final List<Post> _userPosts = [];

  List<Post> get userPosts => _userPosts;

  void addPost(Post post) {
    _userPosts.insert(0, post);
    notifyListeners();
  }
}