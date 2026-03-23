import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/domain/entities/post.dart';
import 'package:threads_clone/domain/repositories/post_repository.dart';
import 'package:threads_clone/presentation/bloc/create_post/create_post_state.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final PostRepository _repository;
  final ImagePicker _picker;

  CreatePostCubit(this._repository, this._picker)
    : super(const CreatePostState());

  // prepare content
  void contentChanged(String value) {
    emit(state.copyWith(content: value));
  }

  // prepare image url
  Future<void> pickFromGallery() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (file == null) return;
    emit(state.copyWith(imageUrl: file.path));
  }

  // remove image
  void removeImage() {
    emit(state.copyWith(imageUrl: null));
  }

  // Create new post and save.
  Future<void> submit() async {
    if (!state.canSubmit) return;

    emit(state.copyWith(status: CreatePostStatus.loading));

    final newPost = Post(
      id: DateTime.now().microsecond.toString(),
      content: state.content.trim(),
      authorId: 'me',
      createdAt: '',
      likes: 0,
      imageUrl: state.imageUrl,
    );

    try {
      await _repository.createPost(newPost);
      emit(state.copyWith(status: CreatePostStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: CreatePostStatus.failure,
          errorMessage: 'Error to create new Post',
        ),
      );
    }
  }
}
