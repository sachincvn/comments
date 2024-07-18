import 'package:comments/core/usecases/usecase.dart';
import 'package:comments/features/authentication/domain/usecase/logout_user_usecase.dart';
import 'package:comments/features/comments/domain/entites/comment_entity.dart';
import 'package:comments/features/comments/domain/usecase/get_comments_usecase.dart';
import 'package:flutter/material.dart';

class CommentsViewModel extends ChangeNotifier {
  final GetCommentsUseCase getCommentsUseCase;
  final LogoutUserUseCase logoutUserUseCase;

  CommentsViewModel(this.logoutUserUseCase, {required this.getCommentsUseCase});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  final List<CommentEntity> _comments = [];
  List<CommentEntity> get comments => _comments;

  int _currentPage = 1;
  final int _perPage = 10;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  Future<void> fetchComments({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _comments.clear();
      _hasMore = true;
    }

    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    final params = GetCommentsParams(
      start: (_currentPage - 1) * _perPage,
      limit: _perPage,
    );

    final result = await getCommentsUseCase(params);

    result.fold(
      (failure) {
        _isLoading = false;
        _errorMessage = 'Failed to fetch comments: ${failure.message}';
        notifyListeners();
      },
      (newComments) {
        _isLoading = false;
        _errorMessage = '';
        _comments.addAll(newComments);

        if (newComments.isEmpty || newComments.length < _perPage) {
          _hasMore = false;
        } else {
          _currentPage++;
        }

        notifyListeners();
      },
    );
  }

  Future<void> logoutUser() async {
    final logoutResult = await logoutUserUseCase(NoParams());
    logoutResult.fold((l) {
      _errorMessage = 'Failed to logout: ${l.message}';
      notifyListeners();
    }, (r) => notifyListeners());
  }
}
