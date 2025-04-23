import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_demo/core/core.dart';
import 'package:news_demo/src/home/bloc/home/home_bloc.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({super.key, required TextEditingController search})
    : _search = search;

  final TextEditingController _search;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.medium,
        vertical: AppPadding.large,
      ),
      child:
          Platform.isIOS
              ? CupertinoSearchTextField(
                controller: _search,
                placeholder: 'Search News',
                onChanged: (value) {
                  _onSearchChanged(context, value);
                },
              )
              : CustomTextField(
                controller: _search,
                hintText: 'Search News',
                onChanged: (value) {
                  _onSearchChanged(context, value);
                },
              ),
    );
  }

  void _onSearchChanged(BuildContext context, String value) {
    Debouncer().run(() {
      context.read<HomeBloc>().add(
        FetchArticles(isRefresh: true, query: value.trim().toLowerCase()),
      );
    });
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({this.milliseconds = 500});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
