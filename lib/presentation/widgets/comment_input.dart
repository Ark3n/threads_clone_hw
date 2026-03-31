import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:threads_clone/presentation/bloc/comments/comments_cubit.dart';
import 'package:threads_clone/presentation/bloc/comments/comments_state.dart';

class CommentInput extends StatefulWidget {
  const CommentInput({super.key});

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentsCubit, CommentsState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == CommentStatus.success) {
          _controller.clear();
        }
        if (state.status == CommentStatus.failure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Something went wrong ')));
        }
      },
      builder: (context, state) => Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Avatar
                CircleAvatar(),
                const SizedBox(width: 10),

                // TextFormField
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'add a comment',
                    ),
                    onChanged: (value) {
                      context.read<CommentsCubit>().inputChanged(value);
                    },
                  ),
                ),
                SizedBox(width: 10),
                // Send comment button
                GestureDetector(
                  onTap: state.canSubmit
                      ? () async {
                          await context.read<CommentsCubit>().addComment();
                        }
                      : null,
                  child: Icon(
                    Icons.send,
                    color: state.canSubmit ? Colors.black : Colors.red,
                  ),
                ),
              ],
            ),
            Container(
              width: 120,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
