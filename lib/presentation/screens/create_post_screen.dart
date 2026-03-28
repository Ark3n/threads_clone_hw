import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/presentation/bloc/create_post/create_post_cubit.dart';
import 'package:threads_clone/presentation/bloc/create_post/create_post_state.dart';
import 'package:threads_clone/presentation/bloc/feed_cubit.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  // Text field Controller
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
        actions: [
          BlocConsumer<CreatePostCubit, CreatePostState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == CreatePostStatus.success) {
                context.read<FeedCubit>().loadFeed();
                Navigator.pop(context);
              }

              if (state.status == CreatePostStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? 'Something went Wrong'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            // Publish post button
            builder: (context, state) => TextButton(
              onPressed: state.canSubmit
                  ? () {
                      context.read<CreatePostCubit>().submit();
                    }
                  : null,
              child: Text(
                'Publish',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 20, child: Icon(Icons.person)),
                SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: ' What\'s up?',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) =>
                        context.read<CreatePostCubit>().contentChanged(value),
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),

            // Select Image from Gallery
            BlocBuilder<CreatePostCubit, CreatePostState>(
              builder: (context, state) {
                if (state.imageUrl == null) return SizedBox.shrink();
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(state.imageUrl!),
                        //width: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () =>
                            context.read<CreatePostCubit>().removeImage(),
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(150),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.close),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            // Pick IMage from Gallery
            SizedBox(height: 12),
            Row(
              children: [
                IconButton(
                  onPressed: () =>
                      context.read<CreatePostCubit>().pickFromGallery(),
                  icon: Icon(
                    Icons.collections_outlined,
                    size: 30,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
