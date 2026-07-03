import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class AppField extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final String value;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool autoFocus;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;

  const AppField({
    super.key,
    this.label,
    this.placeholder,
    required this.value,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.autoFocus = false,
    this.maxLength,
    this.textInputAction,
    this.onEditingComplete,
  });

  @override
  State<AppField> createState() => _AppFieldState();
}

class _AppFieldState extends State<AppField> {
  late final TextEditingController _ctrl;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(AppField old) {
    super.didUpdateWidget(old);
    if (old.value != widget.value && _ctrl.text != widget.value) {
      _ctrl.value = _ctrl.value.copyWith(text: widget.value);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: AppColors.slate600,
            ),
          ),
          const SizedBox(height: 8),
        ],
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _focused ? AppColors.orange : AppColors.gray600,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              if (widget.prefixIcon != null)
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    _focused ? AppColors.orange : AppColors.gray600,
                    BlendMode.srcIn,
                  ),
                  child: widget.prefixIcon!,
                ),
              if (widget.prefixIcon != null) const SizedBox(width: 10),
              Expanded(
                child: Focus(
                  onFocusChange: (f) => setState(() => _focused = f),
                  child: TextField(
                    controller: _ctrl,
                    onChanged: widget.onChanged,
                    keyboardType: widget.keyboardType,
                    obscureText: widget.obscureText,
                    autofocus: widget.autoFocus,
                    maxLength: widget.maxLength,
                    textInputAction: widget.textInputAction,
                    onEditingComplete: widget.onEditingComplete,
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 15.5,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: widget.placeholder,
                      hintStyle: const TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 15.5,
                        fontWeight: FontWeight.w400,
                        color: AppColors.gray500,
                      ),
                      filled: false,
                      fillColor: Colors.transparent,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
              if (widget.suffixIcon != null) ...[
                widget.suffixIcon!,
                const SizedBox(width: 4),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
