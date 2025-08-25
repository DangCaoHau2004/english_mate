import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/viewModels/authentication/auth_gate_cubit.dart';
import 'package:english_mate/viewModels/authentication/userInfo/user_info_bloc.dart';
import 'package:english_mate/viewModels/authentication/userInfo/user_info_event.dart';
import 'package:english_mate/viewModels/authentication/userInfo/user_info_state.dart';
import 'package:english_mate/views/authentication/signUp/steps/sign_up_gender_selection_view.dart';
import 'package:english_mate/views/authentication/signUp/steps/sign_up_set_date_of_birth_view.dart';
import 'package:english_mate/views/authentication/signUp/steps/sign_up_set_email_view.dart';
import 'package:english_mate/views/authentication/signUp/steps/sign_up_set_name_view.dart';
import 'package:english_mate/views/authentication/signUp/steps/sign_up_set_study_time_view.dart';
import 'package:english_mate/widgets/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserInfoView extends StatefulWidget {
  const UserInfoView({super.key});

  @override
  State<UserInfoView> createState() => _UserInfoViewState();
}

class _UserInfoViewState extends State<UserInfoView> {
  late final List<Widget> _steps;
  late final int _totalSteps;
  late final UserInfoBloc _userInfoBloc;
  int _currentStep = 1;

  @override
  void initState() {
    super.initState();
    // nếu như auth là email hoặc google
    _userInfoBloc = context.read<UserInfoBloc>();
    _steps = [
      const SignUpSetNameView(),
      const SignUpGenderSelectionView(),
      const SignUpSetDateOfBirthView(),
      const SignUpSetStudyTimeView(),
    ];
    _totalSteps = _steps.length;
  }

  void _onStepBack() async {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
    } else {
      // Nếu đang ở bước đầu tiên, quay lại màn hình trước đó
      final shouldExit = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Thoát đăng ký thông tin?",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          content: Text(
            "Bạn chưa hoàn tất đăng ký thông tin. Nếu quay lại, bạn sẽ bị đăng xuất.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(false),
              child: const Text("Hủy"),
            ),
            TextButton(
              onPressed: () => context.pop(true),
              child: const Text("Xác nhận"),
            ),
          ],
        ),
      );

      if (shouldExit == true) {
        _logOutAccount();
      }
    }
  }

  void _logOutAccount() async {
    // reset lại authCubit
    context.read<AuthGateCubit>().reset();
    //đăng xuất tài khoản google
    GoogleSignIn.instance.signOut();
    await FirebaseAuth.instance.signOut();
    context.pop();
  }

  bool _isCurrentStepValid() {
    final state = _userInfoBloc.state;
    final currentWidget = _steps[_currentStep - 1];

    if (currentWidget is SignUpSetNameView) {
      return state.fullName.isNotEmpty;
    }
    if (currentWidget is SignUpSetEmailView) {
      return state.email != null && state.email!.contains("@");
    }
    // Đối với các bước không cần validation, luôn trả về true
    if (currentWidget is SignUpGenderSelectionView ||
        currentWidget is SignUpSetDateOfBirthView ||
        currentWidget is SignUpSetStudyTimeView) {
      return true;
    }

    return false;
  }

  // Hàm xử lý khi nhấn nút "Tiếp theo"
  void _onStepContinue() {
    FocusScope.of(context).unfocus();
    // nếu sai định dạng
    if (!_isCurrentStepValid()) {
      // thông báo
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đúng định dạng yêu cầu!")),
      );
      return;
    }
    if (_currentStep < _totalSteps) {
      setState(() {
        _currentStep++;
      });
    } else {
      //submit lên db
      context.read<UserInfoBloc>().add(UserInfoSubmitted());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserInfoBloc, UserInfoState>(
      // chắc chắn sẽ xảy ra kể cả khi có lặp lại lỗi do nó sẽ load thành loading trước khi load lại lỗi
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == UserInfoStatus.failure) {
          _logOutAccount();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Lỗi không xác định')),
          );
        }
        // nếu thành công
        else if (state.status == UserInfoStatus.success) {
          // sửa thành user mới thành cũ
          context.read<AuthGateCubit>().changeIsNewUser();
          // nếu user là null
          if (state.userData == null) {
            // báo lỗi
            context.read<UserInfoBloc>().add(
              UserInfoErrorOccurred(
                errorMessage: "Lỗi không thể tạo tài khoản",
              ),
            );
          }
          context.read<AuthGateCubit>().changeUserData(state.userData!);
          // đã xử lý điều hướng trong app_route
          // context.go(RoutePath.home);
        } else if (state.status == UserInfoStatus.loading) {
          showDialog(
            context: context,
            builder: (context) {
              return const LoadingDialog(content: "Vui lòng chờ");
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: _onStepBack,
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          title: LinearProgressIndicator(
            value: _currentStep / _totalSteps,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            backgroundColor: Theme.of(
              context,
            ).colorScheme.secondary.withAlpha(50),
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.surface,
            ),
            minHeight: 16,
          ),
          actions: [
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "$_currentStep/$_totalSteps",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: IndexedStack(index: _currentStep - 1, children: _steps),
              ),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 16),
                child: ElevatedButton(
                  onPressed: _onStepContinue,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("Tiếp tục"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
