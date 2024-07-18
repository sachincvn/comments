import 'package:comments/core/theme/app_theme.dart';
import 'package:comments/features/comments/presentation/provider/comments_viewmodel.dart';
import 'package:comments/features/comments/presentation/widgets/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsPage extends StatefulWidget {
  static String routeName = '/comments';
  const CommentsPage({Key? key}) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadComments(refresh: true);
    });
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.lightColor,
        appBar: AppBar(
          title: const Text(
            "Comments",
            style: TextStyle(color: AppTheme.lightColor),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<CommentsViewModel>().logoutUser();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
            )
          ],
          backgroundColor: AppTheme.primaryColor,
        ),
        body: Consumer<CommentsViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading && viewModel.comments.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else if (viewModel.errorMessage.isNotEmpty) {
              return Center(child: Text(viewModel.errorMessage));
            } else {
              return ListView.builder(
                controller: _scrollController,
                itemCount: viewModel.hasMore
                    ? viewModel.comments.length + 1
                    : viewModel.comments.length,
                itemBuilder: (context, index) {
                  if (index < viewModel.comments.length) {
                    final comment = viewModel.comments[index];
                    return CommentWidget(comment: comment);
                  } else {
                    return _buildLoadMoreIndicator(viewModel);
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadMoreIndicator(CommentsViewModel viewModel) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _loadComments({bool refresh = false}) {
    final viewModel = Provider.of<CommentsViewModel>(context, listen: false);
    viewModel.fetchComments(refresh: refresh);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadComments();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
