import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:healthy/constants/buttons/icon.dart';


class MyButton extends StatefulWidget {
  final  Function() open;
  final Function () close;
  final Function () onTap;
  final bool isOpen;
  final IconData icon;
  final Color backgroundColor;
  const MyButton({required this.open,required this.close, required this.onTap,required this.isOpen,required this.backgroundColor, required this.icon,super.key});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  final _duration = const Duration(milliseconds: 200);
  var _isPressed  = false;
  
  _pressDown() {
    setState(() {
      _isPressed =true;
    });
  }

  _pressUp() {
    setState(() {
      _isPressed = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pressDown(),
      onTapUp:(_) => _pressUp (),
      onTapCancel:() => _pressUp() ,
      onTap: () => widget.isOpen ? widget.close() : widget.onTap(),
      onLongPress: () {
        if(!widget.isOpen){
          widget.open();
          _pressUp();
        }
      },
      child: AnimatedScale(
        duration: _duration,
        scale: _isPressed || widget.isOpen? 0.8:1,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                offset: Offset(0, 2),
                color: Colors.black12,
              )
            ],
          ),
          child: Stack(
            children: [
             MyIconsButton(icon: Icon(Icons.close_rounded, size: 28.sp,color: widget.backgroundColor,),
              backgroundColor: Colors.white),
               AnimatedOpacity(
                opacity: widget.isOpen ? 0:1,
                duration: _duration,
                 child: MyIconsButton(icon: Icon(widget.icon, size: 28.sp,color: widget.backgroundColor,),
                         backgroundColor: Colors.white),
               ),
            ],
          ),
        ),
      ),
    );
  }
}