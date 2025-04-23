import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_demo/core/core.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.initialValue,
    this.controller,
    this.hintText,
    this.label,
    this.onChanged,
    this.isReadOnly = false,
    this.obscureText = false,
    this.inputFormatters,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final String? hintText;
  final String? label;
  final void Function(String value)? onChanged;
  final String? Function(String? value)? validator;
  final bool isReadOnly;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.v,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              label ?? '',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        Container(
          padding: const EdgeInsets.all(AppPadding.large),
          decoration: BoxDecoration(
            color: context.colorScheme.outlineVariant.withValues(alpha: .4),
            borderRadius: const BorderRadius.all(AppRadius.xlarge),
          ),
          child: Row(
            spacing: 4.h,
            children: [
              Icon(Icons.search_rounded, color: context.colorScheme.outline),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  initialValue: initialValue,
                  onChanged: onChanged,
                  validator: validator,
                  obscureText: obscureText,
                  readOnly: isReadOnly,
                  obscuringCharacter: '*',
                  inputFormatters: inputFormatters,
                  textInputAction: textInputAction,
                  keyboardType: keyboardType,
                  minLines: minLines,
                  maxLines: maxLines,
                  maxLength: maxLength,
                  buildCounter:
                      (
                        context, {
                        required currentLength,
                        required isFocused,
                        required maxLength,
                      }) => const SizedBox.shrink(),
                  decoration: InputDecoration.collapsed(
                    hintText: hintText,
                    hintStyle: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.outline,
                    ),
                    filled: true,
                    fillColor: context.colorScheme.outlineVariant.withValues(
                      alpha: .1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
