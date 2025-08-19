import 'package:flutter/material.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/models/post.dart';

class PostWidget extends StatefulWidget {
  final Post post;

  const PostWidget({super.key, required this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100, width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(widget.post.avatar),
              ),
              if (widget.post.replies > 0) ...[
                const SizedBox(height: 8),
                Container(
                  width: 2,
                  height: 24,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Stack(
                    children: [
                      if (widget.post.replies == 1)
                        CircleAvatar(
                          radius: 7.5,
                          backgroundImage: NetworkImage(
                              'https://picsum.photos/seed/${widget.post.username}1/100/100'),
                        )
                      else if (widget.post.replies == 2) ...[
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: CircleAvatar(
                            radius: 6,
                            backgroundImage: NetworkImage(
                                'https://picsum.photos/seed/${widget.post.username}2/100/100'),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: CircleAvatar(
                            radius: 6,
                            backgroundImage: NetworkImage(
                                'https://picsum.photos/seed/${widget.post.username}1/100/100'),
                          ),
                        ),
                      ] else ...[
                        Positioned(
                          left: 12,
                          top: 20,
                          child: CircleAvatar(
                            radius: 4,
                            backgroundImage: NetworkImage(
                                'https://picsum.photos/seed/${widget.post.username}3/100/100'),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 8,
                          child: CircleAvatar(
                            radius: 6,
                            backgroundImage: NetworkImage(
                                'https://picsum.photos/seed/${widget.post.username}2/100/100'),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: CircleAvatar(
                            radius: 8,
                            backgroundImage: NetworkImage(
                                'https://picsum.photos/seed/${widget.post.username}1/100/100'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.post.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      widget.post.timeAgo,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                      ),
                    ),
                    Gaps.h8,
                    Icon(
                      Icons.more_horiz,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                  ],
                ),
                if (widget.post.text != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    widget.post.text!,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.3,
                    ),
                  ),
                ],
                if (widget.post.images != null) ...[
                  const SizedBox(height: 8),
                  Stack(
                    children: [
                      SizedBox(
                        height: 280,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: widget.post.images!.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(Sizes.size8),
                                child: Image.network(
                                  widget.post.images![index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      if (widget.post.images!.length > 1)
                        Positioned(
                          top: Sizes.size12,
                          right: Sizes.size12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size8,
                              vertical: Sizes.size4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(Sizes.size12),
                            ),
                            child: Text(
                              '${_currentImageIndex + 1}/${widget.post.images!.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 22,
                      color: Colors.grey.shade700,
                    ),
                    Gaps.h16,
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 22,
                      color: Colors.grey.shade700,
                    ),
                    Gaps.h16,
                    Icon(
                      Icons.repeat,
                      size: 22,
                      color: Colors.grey.shade700,
                    ),
                    Gaps.h16,
                    Icon(
                      Icons.send,
                      size: 22,
                      color: Colors.grey.shade700,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${widget.post.replies} ${widget.post.replies == 1 ? 'reply' : 'replies'} • ${widget.post.likes} ${widget.post.likes == 1 ? 'like' : 'likes'}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
