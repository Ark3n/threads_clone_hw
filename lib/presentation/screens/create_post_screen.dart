import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/presentation/bloc/feed_cubit.dart';
import 'package:threads_clone/presentation/bloc/feed_state.dart';

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
          BlocConsumer<FeedCubit, FeedState>(
            listener: (context, state) {},
            builder: (context, state) {
              return TextButton(
                onPressed: () {
                  final text = _controller.text.trim();
                  if (text.isNotEmpty) {
                    context.read<FeedCubit>().createPost(text);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Publish',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
