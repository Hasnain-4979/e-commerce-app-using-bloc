import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isLoading;

  const RoundButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  color: Colors.cyanAccent,
                  strokeWidth: 4,
                )
              : Text(
                  title,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 187, 13, 13),
                  ),
                ),
        ),
      ),
    );
  }
}
