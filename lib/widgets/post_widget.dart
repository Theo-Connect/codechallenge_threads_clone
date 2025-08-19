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
        horizontal: Sizes.size16,
        vertical: Sizes.size16,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100, width: Sizes.size1 / 2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: Sizes.size18,
                backgroundImage: NetworkImage(widget.post.avatar),
              ),
              if (widget.post.replies > 0) ...[
                Gaps.v8,
                Container(
                  width: Sizes.size2,
                  height: Sizes.size24,
                  color: Colors.grey.shade300,
                ),
                Gaps.v8,
                SizedBox(
                  width: Sizes.size30,
                  height: Sizes.size30,
                  child: Stack(
                    children: [
                      if (widget.post.replies == 1)
                        CircleAvatar(
                          radius: Sizes.size7 + Sizes.size1 / 2,
                          backgroundImage: NetworkImage(
                              'https://picsum.photos/seed/${widget.post.username}1/100/100'),
                        )
                      else if (widget.post.replies == 2) ...[
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: CircleAvatar(
                            radius: Sizes.size6,
                            backgroundImage: NetworkImage(
                                'https://picsum.photos/seed/${widget.post.username}2/100/100'),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: CircleAvatar(
                            radius: Sizes.size6,
                            backgroundImage: NetworkImage(
                                'https://picsum.photos/seed/${widget.post.username}1/100/100'),
                          ),
                        ),
                      ] else ...[
                        Positioned(
                          left: Sizes.size12,
                          top: Sizes.size20,
                          child: CircleAvatar(
                            radius: Sizes.size4,
                            backgroundImage: NetworkImage(
                                'https://picsum.photos/seed/${widget.post.username}3/100/100'),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: Sizes.size8,
                          child: CircleAvatar(
                            radius: Sizes.size6,
                            backgroundImage: NetworkImage(
                                'https://picsum.photos/seed/${widget.post.username}2/100/100'),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: CircleAvatar(
                            radius: Sizes.size8,
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
                        fontSize: Sizes.size15,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      widget.post.timeAgo,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: Sizes.size15,
                      ),
                    ),
                    Gaps.h8,
                    Icon(
                      Icons.more_horiz,
                      color: Colors.grey.shade600,
                      size: Sizes.size20,
                    ),
                  ],
                ),
                if (widget.post.text != null) ...[
                  Gaps.v6,
                  Text(
                    widget.post.text!,
                    style: const TextStyle(
                      fontSize: Sizes.size15,
                      height: 1.3,
                    ),
                  ),
                ],
                if (widget.post.images != null) ...[
                  Gaps.v8,
                  Stack(
                    children: [
                      SizedBox(
                        height: Sizes.size280,
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
                                  const EdgeInsets.symmetric(horizontal: Sizes.size4),
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
                Gaps.v12,
                Row(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: Sizes.size22,
                      color: Colors.grey.shade700,
                    ),
                    Gaps.h16,
                    Icon(
                      Icons.chat_bubble_outline,
                      size: Sizes.size22,
                      color: Colors.grey.shade700,
                    ),
                    Gaps.h16,
                    Icon(
                      Icons.repeat,
                      size: Sizes.size22,
                      color: Colors.grey.shade700,
                    ),
                    Gaps.h16,
                    Icon(
                      Icons.send,
                      size: Sizes.size22,
                      color: Colors.grey.shade700,
                    ),
                  ],
                ),
                Gaps.v8,
                Text(
                  '${widget.post.replies} ${widget.post.replies == 1 ? 'reply' : 'replies'} • ${widget.post.likes} ${widget.post.likes == 1 ? 'like' : 'likes'}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: Sizes.size13,
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
