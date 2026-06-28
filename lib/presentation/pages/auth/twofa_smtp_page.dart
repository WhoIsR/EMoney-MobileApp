import 'package:flutter/material.dart';
import 'twofa_totp_page.dart';

class TwoFASmtpPage extends StatefulWidget {
  final String mode; // 'login' or 'setup'
  const TwoFASmtpPage({super.key, this.mode = 'login'});
  @override
  State<TwoFASmtpPage> createState() => _TwoFASmtpPageState();
}

class _TwoFASmtpPageState extends State<TwoFASmtpPage> {
  @override
  Widget build(BuildContext context) {
    return TwoFATotpPage(mode: widget.mode == 'login' ? 'setup' : widget.mode);
  }
}
