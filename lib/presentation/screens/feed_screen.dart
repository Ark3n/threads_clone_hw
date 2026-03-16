import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/presentation/bloc/feed_cubit.dart';
import 'package:threads_clone/presentation/bloc/feed_state.dart';
import 'package:threads_clone/presentation/screens/create_post_screen.dart';
import 'package:threads_clone/presentation/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Threads v2.0',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreatePostScreen()),
              );
            },
            icon: Icon(Icons.edit_outlined),
          ),
        ],
      ),

      // List of all posts
      body: BlocBuilder<FeedCubit, FeedState>(
        builder: (context, state) {
          switch (state.status) {
            case FeedStatus.initial:
              return Center(child: Text('No posts yet'));

            // Loading...
            case FeedStatus.loading:
              return Center(child: CircularProgressIndicator());

            // Handel Error
            case FeedStatus.error:
              return Center(child: Text('Something went wrong'));

            // Loaded successfully
            case FeedStatus.success:
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 8),
                itemCount: state.posts.length,
                // Divider
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(height: 1);
                },
                itemBuilder: (context, index) {
                  return PostCard(post: state.posts[index]);
                },
              );
          }
        },
      ),
    );
  }
}
