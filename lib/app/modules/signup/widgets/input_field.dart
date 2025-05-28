import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final IconData? suffixIcon;
  final ValueChanged<String>? onChanged;

  const InputField({
    Key? key,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          onChanged: onChanged, // ← ini yang penting
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          ),
        ),
      ],
    );
  }
}
