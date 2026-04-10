import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threads_clone/data/datasources/local_post_data_source.dart';
import 'package:threads_clone/data/repositories/post_repository_impl.dart';
import 'package:threads_clone/presentation/bloc/create_post/create_post_cubit.dart';
import 'package:threads_clone/presentation/bloc/feed/feed_cubit.dart';
import 'package:threads_clone/presentation/bloc/feed/feed_state.dart';
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
              // prepare
              final repository = PostRepositoryImpl(LocalPostDataSource());
              final imagePicker = ImagePicker();
              Navigator.push(
                context,
                MaterialPageRoute(
                  // Provide CreatePostCubit to CreatePostScreen()
                  builder: (_) => BlocProvider(
                    create: (context) =>
                        CreatePostCubit(repository, imagePicker),
                    child: CreatePostScreen(),
                  ),
                ),
              );
            },
            icon: Icon(Icons.edit_outlined),
          ),
        ],
      ),
      //List of all posts
      body: BlocConsumer<FeedCubit, FeedState>(
        listener: (context, state) {},
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
