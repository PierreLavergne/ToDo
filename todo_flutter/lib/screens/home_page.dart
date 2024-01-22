import 'dart:convert';

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
                              modifyModal(modalSheetContext),
                            ];
                          },
                        );
                      }),
                  const SizedBox(width: 16),
                  Buttons(
                    variant: Variante.secondary,
                    size: SizeButton.md,
                    msg: const Text("Filter",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: 'Poppins')),
                    icon: const Icon(BootstrapIcons.filter_left,
                        color: AppColors.blue700, size: 32),
                    widthBtn: 160,
                    onPressed: () {},
                  ),
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
                            isDone: false,
                            deadline: DateTime.parse(todos[index]['deadline']),
                            animate: true,
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

SliverWoltModalSheetPage modifyModal(BuildContext context) {
  String name = '';
  String description = '';
  DateTime? deadline;
  String label = 'Low';
  return WoltModalSheetPage(
    hasTopBarLayer: false,
    backgroundColor: AppColors.white,
    hasSabGradient: true,
    enableDrag: true,
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          CustomField(
            label: 'Name',
            value: '',
            isPassword: false,
            onChanged: (value) {
              name = value;
            },
          ),
          const SizedBox(height: 16),
          CustomField(
            label: 'Description',
            value: '',
            isPassword: false,
            onChanged: (value) {
              description = value;
            },
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<DateTime?>(
            valueListenable: ValueNotifier(deadline),
            builder: (context, value, child) {
              return value == null
                  ? Buttons(
                      onPressed: () async {
                        Logger().i('avant showDatePicker $value');
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025),
                        );
                        if (selectedDate != null) {
                          deadline = selectedDate;
                          value =
                              selectedDate; // Cette ligne ne met pas à jour la valeur affichée, il faudrait utiliser ValueNotifier(deadline).value = selectedDate; à la place
                        }
                        Logger().i('après showDatePicker $value');
                      },
                      // ignore: unnecessary_null_comparison
                      msg: Text(
                          deadline == null
                              ? 'Sélectionnez une date'
                              : 'Date sélectionnée',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: 'Poppins')),

                      variant: Variante.primary,
                      size: SizeButton.md,
                    )
                  : Text(
                      'Date sélectionnée : ${value.day}/${value.month}/${value.year}',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'Poppins'),
                    );
            },
          ),
          const SizedBox(height: 16),
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
                  label = newValue!;
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
                  icon: const Icon(BootstrapIcons.x,
                      color: AppColors.blue700, size: 32),
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
                  icon: const Icon(BootstrapIcons.x,
                      color: AppColors.white, size: 32),
                  onPressed: () {
                    // Sending the task details to the server
                    putTodos({
                      'name': name,
                      'description': description,
                      'deadline': deadline!.toIso8601String(),
                      'label': label
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
