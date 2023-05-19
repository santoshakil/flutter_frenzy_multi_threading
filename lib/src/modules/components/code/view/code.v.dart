import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../extensions/context.dart';
import '../../../../extensions/string.dart';
import '../../../../home/model/home.m.dart';
import '../provider/code.p.dart';

class CodePreview extends ConsumerWidget {
  const CodePreview({super.key, required this.module});

  final Modules module;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keys = module.codes.keys;
    return Expanded(
      child: Card(
        child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: ref.watch(codePageControllerProvider(module)),
          itemCount: keys.length,
          itemBuilder: (context, index) {
            final code = keys.elementAt(index);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (code.isNotEmpty)
                  Container(
                    alignment: Alignment.centerRight,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      code,
                      style: context.text.titleLarge!.copyWith(
                        color: code.withWithoutColor,
                      ),
                    ),
                  ),
                Expanded(
                  child: ImageWithZoom(code: code, module: module),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ImageWithZoom extends StatefulWidget {
  const ImageWithZoom({
    super.key,
    required this.code,
    required this.module,
  });

  final String code;
  final Modules module;

  @override
  State<ImageWithZoom> createState() => _ImageWithZoomState();
}

class _ImageWithZoomState extends State<ImageWithZoom>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Animation<Matrix4>? _animation;
  late TransformationController _transformationController;
  final double _minScale = 1.0;
  final double _maxScale = 14.0;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: _transformationController,
      onInteractionEnd: (d) => resetStartAnimation(),
      clipBehavior: Clip.none,
      minScale: _minScale,
      maxScale: _maxScale,
      child: Image.asset(
        'assets/images/${(widget.code.isNotEmpty ? widget.code : widget.module.title).snackCase}.png',
        filterQuality: FilterQuality.high,
        key: ValueKey('CodePreview${widget.code}'),
        fit: BoxFit.contain,
        isAntiAlias: true,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {
        _transformationController.value = _animation!.value;
      });
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _transformationController.dispose();
  }

  void resetStartAnimation() {
    _animation = Matrix4Tween(
            begin: _transformationController.value, end: Matrix4.identity())
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.fastOutSlowIn));
  }
}
