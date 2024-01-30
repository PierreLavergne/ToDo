import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../styles/colors.dart';
// ignore: depend_on_referenced_packages
import 'package:bootstrap_icons/bootstrap_icons.dart';

// ignore: constant_identifier_names
enum LabelType { LOW, MEDIUM, IMPORTANT, URGENT }

// ignore: must_be_immutable
class CardTask extends StatefulWidget {
  String title;
  String description;
  LabelType label;
  DateTime? deadline;
  String? status;
  bool animate = true;

  CardTask({
    super.key,
    required this.title,
    required this.description,
    required this.label,
    required this.deadline,
    required this.animate,
    required this.status,
  });

  @override
  State<CardTask> createState() => _CardTaskState();
}

class _CardTaskState extends State<CardTask> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      animate: widget.animate,
      duration: const Duration(seconds: 1),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          decoration: BoxDecoration(
            color: widget.status == 'Done' ? AppColors.grey200 : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: AppColors.grey400,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.spaceBetween,
            children: [
              Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.center,
                spacing: 4,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey800,
                      fontFamily: 'Poppins',
                      decoration: widget.status == 'Done'
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  Text(
                    widget.description == ''
                        ? 'No description'
                        : widget.description,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey600,
                      fontFamily: 'Poppins',
                      decoration: widget.status == 'Done'
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: widget.label == LabelType.LOW
                              ? AppColors.green100
                              : widget.label == LabelType.MEDIUM
                                  ? AppColors.blue100
                                  : widget.label == LabelType.IMPORTANT
                                      ? AppColors.orange100
                                      : AppColors.red100,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: widget.label == LabelType.LOW
                                    ? AppColors.green700
                                    : widget.label == LabelType.MEDIUM
                                        ? AppColors.blue700
                                        : widget.label == LabelType.IMPORTANT
                                            ? AppColors.orange600
                                            : AppColors.red700,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.label
                                  .toString()
                                  .split('.')
                                  .last
                                  .toLowerCase()
                                  .replaceRange(
                                      0,
                                      1,
                                      widget.label
                                          .toString()
                                          .split('.')
                                          .last
                                          .toLowerCase()[0]
                                          .toUpperCase()),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: widget.label == LabelType.LOW
                                    ? AppColors.green700
                                    : widget.label == LabelType.MEDIUM
                                        ? AppColors.blue700
                                        : widget.label == LabelType.IMPORTANT
                                            ? AppColors.orange600
                                            : AppColors.red700,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                          decoration: const BoxDecoration(
                            color: AppColors.grey50,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(BootstrapIcons.calendar,
                                  size: 14, color: AppColors.grey600),
                              const SizedBox(width: 4),
                              Text(
                                '${widget.deadline!.day}/${widget.deadline!.month}/${widget.deadline!.year}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey600,
                                  fontFamily: 'Poppins',
                                ),
                              )
                            ],
                          )),
                    ],
                  )
                ],
              ),
              Checkbox(
                  value: widget.status == 'Done' ? true : false,
                  activeColor: AppColors.blue600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  onChanged: (value) {
                    setState(() {
                      widget.status = value! ? 'Done' : 'Pending';
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
