import 'package:flutter/material.dart';
import '../styles/colors.dart';

enum Variante {
  primary,
  secondary,
  tertiary,
  primaryBordered,
  validate,
  delete,
}

enum SizeButton {
  sm,
  md,
  lg,
  xl,
  xxl,
  xxxl,
}

class Buttons extends StatefulWidget {
  final Variante variant;
  final SizeButton size;
  final Text msg;
  final Function? onPressed;
  final int? widthBtn;
  final Icon? icon;
  const Buttons({
    super.key,
    required this.variant,
    required this.size,
    required this.msg,
    this.onPressed,
    this.widthBtn,
    this.icon,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ButtonsState createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    Color backgroundcolor;
    BorderSide borderSide;
    TextStyle textStyle;
    double radius;

    switch (widget.size) {
      case SizeButton.sm:
        textStyle = TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: widget.variant == Variante.secondary
              ? const Color(0xFF2E4C9A)
              : Colors.white,
          fontFamily: 'Poppins',
        );
        radius = 8;
        break;
      case SizeButton.md:
        textStyle = TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: widget.variant == Variante.secondary
              ? const Color(0xFF2E4C9A)
              : Colors.white,
          fontFamily: 'Poppins',
        );
        radius = 10;
        break;
      case SizeButton.lg:
        textStyle = TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: widget.variant == Variante.secondary
              ? const Color(0xFF2E4C9A)
              : Colors.white,
          fontFamily: 'Poppins',
        );
        radius = 12;
        break;
      case SizeButton.xl:
        textStyle = TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: widget.variant == Variante.secondary
              ? const Color(0xFF2E4C9A)
              : Colors.white,
          fontFamily: 'Poppins',
        );
        radius = 12;
        break;
      case SizeButton.xxl:
        textStyle = TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: widget.variant == Variante.secondary
              ? const Color(0xFF2E4C9A)
              : Colors.white,
          fontFamily: 'Poppins',
        );
        radius = 16;
        break;
      case SizeButton.xxxl:
        textStyle = TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: widget.variant == Variante.secondary
              ? const Color(0xFF2E4C9A)
              : Colors.white,
          fontFamily: 'Poppins',
        );
        radius = 16;
        break;
      default:
        textStyle = const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.blue300,
          fontFamily: 'Poppins',
        );
        radius = 8;
        break;
    }

    switch (widget.variant) {
      case Variante.primary:
        backgroundcolor = AppColors.blue700;
        borderSide = const BorderSide(
          color: AppColors.blue700,
          style: BorderStyle.solid,
          width: 2,
        );
        break;
      case Variante.secondary:
        backgroundcolor = Colors.white;
        borderSide = const BorderSide(
          color: AppColors.blue200,
          style: BorderStyle.solid,
          width: 2,
        );
        break;
      case Variante.tertiary:
        backgroundcolor = AppColors.grey500;
        borderSide = const BorderSide(
          color: AppColors.grey400,
          style: BorderStyle.solid,
          width: 2,
        );
        break;
      case Variante.primaryBordered:
        backgroundcolor = AppColors.blue700;
        borderSide = const BorderSide(
          color: AppColors.blue700,
          style: BorderStyle.solid,
          width: 2,
        );
        break;
      case Variante.validate:
        backgroundcolor = AppColors.green600;
        borderSide = const BorderSide(
          color: AppColors.green600,
          style: BorderStyle.solid,
          width: 2,
        );
        break;
      case Variante.delete:
        backgroundcolor = AppColors.red600;
        borderSide = const BorderSide(
          color: AppColors.red600,
          style: BorderStyle.solid,
          width: 2,
        );
        break;
      default:
        backgroundcolor = Colors.grey;
        borderSide = const BorderSide(
          color: Colors.transparent,
          style: BorderStyle.solid,
          width: 0,
        );
        break;
    }

    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () async {
        widget.onPressed!();
      },
      child: Container(
        constraints: BoxConstraints(
          maxWidth: screenWidth,
        ),
        padding: EdgeInsets.symmetric(
            vertical: widget.size == SizeButton.sm ||
                    widget.size == SizeButton.lg ||
                    widget.size == SizeButton.md
                ? 6
                : 12,
            horizontal: widget.size == SizeButton.sm ||
                    widget.size == SizeButton.lg ||
                    widget.size == SizeButton.md
                ? 16
                : 24),
        decoration: BoxDecoration(
          color: backgroundcolor,
          border: Border.fromBorderSide(borderSide),
          borderRadius: BorderRadius.circular(radius),
        ),
        width: widget.widthBtn != null
            ? widget.widthBtn!.toDouble()
            : double.infinity,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceEvenly,
          children: [
            widget.icon != null ? widget.icon! : Container(),
            Text(
              widget.msg.data.toString(),
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
