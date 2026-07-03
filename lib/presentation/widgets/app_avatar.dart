import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AppAvatar extends StatelessWidget {
  final String name;
  final double size;
  final Color? bg;
  final String? imageUrl;

  const AppAvatar({
    super.key,
    required this.name,
    this.size = 44,
    this.bg,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final palette = [
      AppColors.yellow,
      AppColors.orange,
      AppColors.purple,
      AppColors.green,
      AppColors.blue,
      AppColors.pink,
    ];
    final auto =
        palette[(name.isNotEmpty ? name.codeUnitAt(0) : 0) % palette.length];
    final initials = name
        .split(' ')
        .take(2)
        .map((s) => s.isNotEmpty ? s[0].toUpperCase() : '')
        .join();

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg ?? auto,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.black,
            blurRadius: 0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl != null
          ? Image.network(imageUrl!, fit: BoxFit.cover)
          : Center(
              child: Text(
                initials,
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: size * 0.36,
                  fontWeight: FontWeight.w900,
                  color: AppColors.black,
                ),
              ),
            ),
    );
  }
}
