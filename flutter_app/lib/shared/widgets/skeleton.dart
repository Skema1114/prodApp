import 'package:flutter/material.dart';

/// Placeholder com efeito shimmer simples — substitui CircularProgressIndicator
/// em listas/grids enquanto dados carregam.
class Skeleton extends StatefulWidget {
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  const Skeleton({super.key, this.height, this.width, this.borderRadius});

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment(-1 + _ctrl.value * 2, 0),
            end: Alignment(1 + _ctrl.value * 2, 0),
            colors: const [
              Color(0xFFEEEEEE),
              Color(0xFFF8F8F8),
              Color(0xFFEEEEEE),
            ],
          ),
        ),
      ),
    );
  }
}
