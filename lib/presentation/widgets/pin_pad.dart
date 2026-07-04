import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class PinPad extends StatelessWidget {
  final String value;
  final int length;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onComplete;

  const PinPad({
    super.key,
    required this.value,
    required this.onChanged,
    this.length = 6,
    this.onComplete,
  });

  void _press(String key) {
    String next;
    if (key == 'del') {
      next = value.isEmpty ? '' : value.substring(0, value.length - 1);
    } else {
      if (value.length >= length) return;
      next = value + key;
    }
    onChanged(next);
    if (next.length == length) {
      Future.delayed(
          const Duration(milliseconds: 140), () => onComplete?.call(next));
    }
  }

  @override
  Widget build(BuildContext context) {
    final keys = [
      '1', '2', '3',
      '4', '5', '6',
      '7', '8', '9',
      'bio', '0', 'del'
    ];

    final subLabels = {
      '1': '',
      '2': 'A B C',
      '3': 'D E F',
      '4': 'G H I',
      '5': 'J K L',
      '6': 'M N O',
      '7': 'P Q R S',
      '8': 'T U V',
      '9': 'W X Y Z',
      '0': '+',
    };

    return Column(
      children: [
        // PIN dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(length, (i) {
            final filled = i < value.length;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 14,
              height: 14,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: filled ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: filled ? AppColors.primary : AppColors.primary.withValues(alpha: 0.38),
                  width: 1.8,
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 36),
        // Keypad grid
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.15,
          children: keys.map((k) {
            if (k == 'bio') {
              return _KeyButton(
                onTap: () => onComplete?.call(value),
                child: const Icon(Icons.fingerprint_rounded,
                    size: 32, color: AppColors.primary),
              );
            }
            if (k == 'del') {
              return _KeyButton(
                onTap: () => _press('del'),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                    size: 20, color: AppColors.slate500),
              );
            }

            final label = subLabels[k];
            return _KeyButton(
              onTap: () => _press(k),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    k,
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink,
                      height: 1.1,
                    ),
                  ),
                  if (label != null && label.isNotEmpty)
                    Text(
                      label,
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 8.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.slate400,
                        letterSpacing: 0.6,
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _KeyButton extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;

  const _KeyButton({required this.onTap, required this.child});

  @override
  State<_KeyButton> createState() => _KeyButtonState();
}

class _KeyButtonState extends State<_KeyButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 60),
          width: 74,
          height: 74,
          decoration: BoxDecoration(
            color: _pressed
                ? Colors.white.withValues(alpha: 0.52)
                : AppColors.glass.withValues(alpha: 0.68),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.22),
              width: 1.0,
            ),
          ),
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}
