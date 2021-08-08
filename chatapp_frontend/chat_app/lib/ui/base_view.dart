import 'package:chat_app/viemodels/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/locator.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseViemodel> extends StatefulWidget {
  const BaseView({
    Key? key,
    required this.builder,
    this.onModelReady,
    this.onModelDestroy,
  }) : super(key: key);
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final void Function(T)? onModelReady;
  final void Function(T)? onModelDestroy;

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViemodel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: Consumer<T>(
        builder: widget.builder,
      ),
    );
  }

  @override
  void dispose() {
    if (widget.onModelDestroy != null) {
      widget.onModelDestroy!(model);
    }
    super.dispose();
  }
}
