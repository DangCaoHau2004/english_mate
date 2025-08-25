import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/viewModels/authentication/auth_gate_cubit.dart';
import 'package:english_mate/viewModels/editProfile/editProfile/edit_profile_bloc.dart';
import 'package:english_mate/viewModels/editProfile/editProfile/edit_profile_event.dart';
import 'package:english_mate/viewModels/editProfile/editProfile/edit_profile_state.dart';
import 'package:english_mate/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  List<String> optionsGender = ['Nam', 'Nữ', 'Khác'];
  void _showDatePicker(DateTime initialDate) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      initialDate: initialDate,
      context: context,
      firstDate: DateTime(now.year - 100, now.month, now.day),
      lastDate: now,
    );
    if (pickedDate == null) {
      return;
    }
    _onDateOfBirthChanged(pickedDate);
  }

  void _profileSaved() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<EditProfileBloc>().add(EditProfileSaveClicked());
  }

  void _onChangeGender(String value) {
    int index = optionsGender.indexOf(value);
    Gender gender = Gender.values[index];
    context.read<EditProfileBloc>().add(
      EditProfileGenderChanged(gender: gender),
    );
  }

  void _onDateOfBirthChanged(DateTime value) {
    context.read<EditProfileBloc>().add(
      EditDateOfBirthChanged(dateOfBirth: value),
    );
  }

  void _onFullNameChanged(String value) {
    context.read<EditProfileBloc>().add(
      EditProfileFullNameChanged(fullName: value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileBloc, EditProfileState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == UserInfoStatus.loading) {
          showLoadingDialog(context: context);
        } else if (state.status == UserInfoStatus.success) {
          context.pop();
          context.read<AuthGateCubit>().changeUserData(state.editting);
        } else if (state.status == UserInfoStatus.failure) {
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Lỗi không xác định')),
          );
        }
      },
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.editting != current.editting,
      builder: (context, state) {
        final editting = state.editting;
        final original = state.original;
        return Scaffold(
          appBar: AppBar(title: const Text("Thông tin cá nhân")),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Text(
                    "Email",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: editting.email,
                    readOnly: true,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Theme.of(
                        context,
                      ).colorScheme.secondary.withAlpha(25),

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ).applyDefaults(Theme.of(context).inputDecorationTheme),
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Tên người dùng",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: editting.fullName,
                    onChanged: _onFullNameChanged,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Theme.of(
                        context,
                      ).colorScheme.secondary.withAlpha(25),

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ).applyDefaults(Theme.of(context).inputDecorationTheme),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên người dùng';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Giới tính",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: optionsGender[editting.gender.index],
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Theme.of(
                        context,
                      ).colorScheme.secondary.withAlpha(25),

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ).applyDefaults(Theme.of(context).inputDecorationTheme),
                    borderRadius: BorderRadius.circular(12),
                    dropdownColor: Theme.of(
                      context,
                    ).colorScheme.primary, // nền menu
                    style: Theme.of(context).textTheme.bodyMedium,
                    items: optionsGender
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      _onChangeGender(value!);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập giới tính';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Ngày sinh",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    key: ValueKey(
                      DateFormat('dd-MM-yyyy').format(editting.dateOfBirth),
                    ),
                    initialValue: DateFormat(
                      'dd-MM-yyyy',
                    ).format(editting.dateOfBirth).toString(),
                    onTap: () {
                      _showDatePicker(editting.dateOfBirth);
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Theme.of(
                        context,
                      ).colorScheme.secondary.withAlpha(25),

                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ).applyDefaults(Theme.of(context).inputDecorationTheme),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập ngày sinh';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: identical(original, editting)
              ? null
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _profileSaved,
                    child: const Text("Lưu thay đổi"),
                  ),
                ),
        );
      },
    );
  }
}
