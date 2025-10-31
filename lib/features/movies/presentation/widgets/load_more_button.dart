import 'package:flutter/material.dart';

/// Button widget for loading more movies with loading state
class LoadMoreButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const LoadMoreButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text('Load More Movies'),
    );
  }
}
