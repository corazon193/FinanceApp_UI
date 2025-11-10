// lib/widgets/grid_menu_item.dart
import 'package:flutter/material.dart';

/// GridMenuItem — modern bright finance style
/// - gradient (passed or default)
/// - icon color follows the gradient
/// - soft shadow
/// - press animation (scale) + ripple
class GridMenuItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final List<Color>? gradientColors; // if null, defaults are used

  const GridMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.gradientColors,
  });

  @override
  State<GridMenuItem> createState() => _GridMenuItemState();
}

class _GridMenuItemState extends State<GridMenuItem> {
  bool _pressed = false;

  void _handleTapDown(_) => setState(() => _pressed = true);
  void _handleTapUp(_) => setState(() => _pressed = false);
  void _handleTapCancel() => setState(() => _pressed = false);

  List<Color> get _colors =>
      widget.gradientColors ??
      const [
        Color(0xFFBEE6FF), // light blue
        Color(0xFF8EDDFE), // sky
      ];

  // pick a sensible icon color from the gradient (midpoint)
  Color get _iconColor {
    final c1 = _colors.first;
    final c2 = _colors.last;
    // simple midpoint mix
    return Color.fromARGB(
      ((c1.alpha + c2.alpha) ~/ 2),
      ((c1.red + c2.red) ~/ 2),
      ((c1.green + c2.green) ~/ 2),
      ((c1.blue + c2.blue) ~/ 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = 14.0;
    final scale = _pressed ? 0.98 : 1.0;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      behavior: HitTestBehavior.translucent,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        scale: scale,
        child: Material(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: InkWell(
              onTap: widget.onTap,
              splashFactory: InkRipple.splashFactory,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: _colors,
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // circular icon container
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white.withValues(alpha: 0.12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        // subtle inner gradient to add depth
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.08),
                            Colors.white.withValues(alpha: 0.02),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Icon(widget.icon, size: 24, color: _iconColor),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // label + subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.label,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F1724),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Quick action',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(
                                0xFF0F1724,
                              ).withValues(alpha: 0.55),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // chevron
                    Icon(
                      Icons.chevron_right,
                      color: const Color(0xFF0F1724).withValues(alpha: 0.45),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
