import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthy/constants/buttons/button.dart';
import 'package:healthy/constants/buttons/mathB.dart';
import 'package:healthy/constants/buttons/mathPrep.dart';

class QuickActionMenu extends StatefulWidget {
  final Function() onTap;
  final IconData icon;
  final Color backgroundColor;
  final Widget child;
  final List<QuickAction> actions;
  const QuickActionMenu({required this.onTap,required this.icon, required this.backgroundColor,required this.child,required this.actions,
  super.key}) : assert (actions.length == 3 , 'actions must have 3 items');

  @override
  State<QuickActionMenu> createState() => _QuickActionMenuState();
}

class _QuickActionMenuState extends State<QuickActionMenu> {
  var _isOpen = false;

  _open(){
    setState(() {
      HapticFeedback.lightImpact();
      _isOpen=true;
    });
  }

  _close() {
    setState(() {
      HapticFeedback.lightImpact();
      _isOpen=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        widget.child,
        IgnorePointer(
          ignoring: !_isOpen,
          child: AnimatedOpacity(
            opacity: _isOpen ? 1:0,
            duration: const Duration( milliseconds: 150),
            child: GestureDetector(
              onTap: _close,
              child: Container(
                color: Colors.white.withOpacity(0.6),
              ),
            ),
          ),
        ),
        ...widget.actions.map(
          (action) => QuickActionButton(action, close: _close, index:widget.actions.indexOf(action), isOpen: _isOpen)
        ),
        Padding(padding: EdgeInsets.all(16.0).copyWith(bottom: MediaQuery.of(context).padding.bottom+ 16),
        child: MyButton(open: _open, close: _close, onTap: widget.onTap, isOpen: _isOpen, backgroundColor: widget.backgroundColor, icon: widget.icon),
        ),
      ],
    );
  }
}