import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/data/datasources/local_comment_data_source.dart';
import 'package:threads_clone/data/repositories/comment_repository_impl.dart';
import 'package:threads_clone/domain/entities/post.dart';
import 'package:threads_clone/presentation/bloc/comments/comments_cubit.dart';
import 'package:threads_clone/presentation/bloc/comments/comments_state.dart';
import 'package:threads_clone/presentation/widgets/comment_input.dart';
import 'package:threads_clone/presentation/widgets/comment_tile.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key, required this.post});
  final Post post;

  // method to open ModalBottomSheet
  static Future<void> show(BuildContext context, Post post) async {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocProvider(
          create: (context) => CommentsCubit(
            CommentRepositoryImpl(LocalCommentDataSource()),
            post.id!,
          )..loadComments(),
          child: CommentsScreen(post: post),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // context.read<CommentsCubit>().loadComments();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 8, 8),
            child: Row(
              children: [
                Text(
                  'Comments',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade300),
          Expanded(
            child: BlocBuilder<CommentsCubit, CommentsState>(
              builder: (context, state) {
                if (state.status == .loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state.comments.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.comment_outlined),
                        SizedBox(height: 12),
                        Text(
                          'No comment yet',
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                  );
                }
                // on success show comments
                return ListView.separated(
                  itemBuilder: (context, i) =>
                      CommentTile(comment: state.comments[i]),
                  separatorBuilder: (_, _) =>
                      Divider(height: 1, color: Colors.grey),
                  itemCount: state.comments.length,
                );
              },
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade300),
          CommentInput(),
        ],
      ),
    );
  }
}
