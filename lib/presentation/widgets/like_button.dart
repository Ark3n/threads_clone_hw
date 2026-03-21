import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/domain/entities/post.dart';
import 'package:threads_clone/presentation/bloc/feed_cubit.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({super.key, required this.post});
  final Post post;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 150),
    );
    _scale = Tween<double>(
      begin: 1.0,
      end: 1.4,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _controller.forward();
        await _controller.reverse();
        context.read<FeedCubit>().likePost(widget.post.id);
      },
      child: Row(
        children: [
          ScaleTransition(
            scale: _scale,
            child: Icon(
              widget.post.isLiked ? Icons.favorite : Icons.favorite_border,
              size: 20,
              color: widget.post.isLiked ? Colors.red : null,
            ),
          ),
          SizedBox(width: 4),
          if (widget.post.likes > 0)
            Text(
              widget.post.likes.toString(),
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
        ],
      ),
    );
  }
}
