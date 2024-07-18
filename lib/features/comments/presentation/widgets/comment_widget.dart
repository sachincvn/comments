import 'package:comments/core/theme/app_theme.dart';
import 'package:comments/features/comments/domain/entites/comment_entity.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final CommentEntity comment;

  const CommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: AppTheme.grayColor,
        radius: 30,
        child: Text(
          comment.name[0].toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Name: ',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: AppTheme.grayColor),
                ),
                TextSpan(
                  text: comment.name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.secondaryColor),
                ),
              ],
            ),
          ),
          RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Email: ',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: AppTheme.grayColor),
                ),
                TextSpan(
                  text: comment.email,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.secondaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
      subtitle: Text(
        comment.body,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
