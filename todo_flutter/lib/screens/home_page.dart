import 'package:flutter/material.dart';
import 'package:todo_flutter/services/get_todos.dart';
import 'package:todo_flutter/styles/colors.dart';
import 'package:todo_flutter/widgets/buttons.dart';
// ignore: depend_on_referenced_packages
import 'package:bootstrap_icons/bootstrap_icons.dart';
// ignore: depend_on_referenced_packages
import 'package:logger/logger.dart';
import 'package:todo_flutter/widgets/card_task.dart';
import 'package:todo_flutter/widgets/field_custom.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> todos = [];
  bool isValidated = false;

  @override
  void initState() {
    super.initState();
    fetchData(context);
  }

  Future<void> fetchData(BuildContext context) async {
    todos = await getTodos();
  }

  Future<void> updateData(BuildContext context) async {
    setState(() {
      fetchData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF2F4F3),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text(
            "My Todo List",
            style: TextStyle(
                color: Color(0xFF353535),
                fontFamily: 'Poppins',
                fontSize: 32,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Buttons(
                      variant: Variante.primary,
                      size: SizeButton.md,
                      msg: const Text("New Task",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'Poppins')),
                      icon: const Icon(BootstrapIcons.plus,
                          color: AppColors.white, size: 32),
                      widthBtn: 160,
                      onPressed: () {
                        WoltModalSheet.show(
                          context: context,
                          pageListBuilder: (modalSheetContext) {
                            return [
                              modifyModal(modalSheetContext, updateData),
                            ];
                          },
                        );
                      }),
                ],
              ),
              const SizedBox(height: 32),
              FutureBuilder(
                future: fetchData(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          return CardTask(
                            title: todos[index]['name'],
                            description: todos[index]['description'],
                            label: todos[index]['label'] == 'Low'
                                ? LabelType.LOW
                                : todos[index]['label'] == 'Medium'
                                    ? LabelType.MEDIUM
                                    : todos[index]['label'] == 'Important'
                                        ? LabelType.IMPORTANT
                                        : LabelType.URGENT,
                            deadline: DateTime.parse(todos[index]['deadline']),
                            animate: true,
                            status: todos[index]['status'],
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }
}

SliverWoltModalSheetPage modifyModal(
    BuildContext context, Function updateData) {
  return WoltModalSheetPage(
    backgroundColor: AppColors.white,
    enableDrag: true,
    pageTitle: const Text(
      'Create a new task',
      style: TextStyle(
          color: AppColors.grey950,
          fontFamily: 'Poppins',
          fontSize: 32,
          fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: BodyModal(updateData: updateData),
    ),
  );
}

class BodyModal extends StatefulWidget {
  final Function updateData;
  const BodyModal({super.key, required this.updateData});

  @override
  State<BodyModal> createState() => _BodyModalState();
}

class _BodyModalState extends State<BodyModal> {
  String name = '';
  String description = '';
  DateTime? deadline;
  String label = 'Low';
  String status = "Active";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Write a title :',
          style: TextStyle(
            color: AppColors.grey950,
            fontFamily: 'Poppins',
            fontSize: 18,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 8),
        CustomField(
          label: 'Name',
          value: '',
          isPassword: false,
          onChanged: (value) {
            name = value;
          },
        ),
        const SizedBox(height: 16),
        const Text(
          'Write a description :',
          style: TextStyle(
            color: AppColors.grey950,
            fontFamily: 'Poppins',
            fontSize: 18,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 8),
        CustomField(
          label: 'Description',
          value: '',
          isPassword: false,
          onChanged: (value) {
            description = value;
          },
        ),
        const SizedBox(height: 16),
        const Text(
          'Select the end date :',
          style: TextStyle(
            color: AppColors.grey950,
            fontFamily: 'Poppins',
            fontSize: 18,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 8),
        Buttons(
          onPressed: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2025),
            );
            if (selectedDate != null) {
              setState(() {
                deadline = selectedDate;
                deadline!.add(const Duration(hours: 23, minutes: 59));
              });
            }
          },
          msg: Text(
              deadline == null
                  ? 'Sélectionnez une date'
                  : 'Date sélectionnée : ${deadline!.day}/${deadline!.month}/${deadline!.year}',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Poppins')),
          variant: deadline == null ? Variante.primary : Variante.secondary,
          size: SizeButton.md,
        ),
        const SizedBox(height: 16),
        const Text(
          'Select your Label :',
          style: TextStyle(
            color: AppColors.grey950,
            fontFamily: 'Poppins',
            fontSize: 18,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.blue500, width: 2),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: DropdownButton<String>(
              isExpanded: true,
              value: label,
              onChanged: (String? newValue) {
                setState(() {
                  label = newValue!;
                });
              },
              items: <String>['Low', 'Medium', 'Important', 'Urgent']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              underline: Container(),
              dropdownColor: AppColors.white,
              icon: const Icon(BootstrapIcons.chevron_down,
                  color: AppColors.blue500),
              borderRadius: BorderRadius.circular(12),
              style: const TextStyle(
                color: AppColors.grey950,
                fontFamily: 'Poppins',
                fontSize: 18,
                textBaseline: TextBaseline.ideographic,
              )),
        ),
        const SizedBox(height: 16),
        const Text(
          'Select your Status :',
          style: TextStyle(
            color: AppColors.grey950,
            fontFamily: 'Poppins',
            fontSize: 18,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.blue500, width: 2),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: DropdownButton<String>(
              isExpanded: true,
              value: status,
              onChanged: (String? newValue) {
                setState(() {
                  status = newValue!;
                });
              },
              items: <String>['Active', 'Pending', 'Done']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              underline: Container(),
              dropdownColor: AppColors.white,
              icon: const Icon(BootstrapIcons.chevron_down,
                  color: AppColors.blue500),
              borderRadius: BorderRadius.circular(12),
              style: const TextStyle(
                color: AppColors.grey950,
                fontFamily: 'Poppins',
                fontSize: 18,
                textBaseline: TextBaseline.ideographic,
              )),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: Buttons(
                variant: Variante.secondary,
                size: SizeButton.md,
                msg: const Text("Cancel",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Poppins')),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Buttons(
                variant: Variante.validate,
                size: SizeButton.md,
                msg: const Text("Add the task",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Poppins')),
                onPressed: () {
                  Logger().i(name);
                  Logger().i(description);
                  Logger().i(deadline);
                  Logger().i(label);
                  if (name != "" &&
                      deadline != null &&
                      label != '' &&
                      label != '') {
                    putTodos({
                      'name': name,
                      'description': description,
                      'deadline': deadline!.toIso8601String(),
                      'label': label,
                      'status': status,
                    });
                    Navigator.pop(context);
                  } else {
                    Logger().e("Please fill all the fields");
                  }
                  widget.updateData(context);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
