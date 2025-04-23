import 'package:flutter/material.dart';

abstract class AppFormState<T extends StatefulWidget> extends State<T> {
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    _formKey.currentState?.save();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  bool get isFormValid => _formKey.currentState?.validate() ?? false;

  GlobalKey<FormState> get formKey => _formKey;
}
