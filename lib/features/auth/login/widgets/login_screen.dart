import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:live_order_tracking/core/routing/app_routes.dart';
import 'package:live_order_tracking/core/styling/app_assets.dart';
import 'package:live_order_tracking/core/styling/app_colors.dart';
import 'package:live_order_tracking/core/styling/app_styles.dart';
import 'package:live_order_tracking/core/utils/animated_snack_dialog.dart';
import 'package:live_order_tracking/core/widgets/custom_text_field.dart';
import 'package:live_order_tracking/core/widgets/loading_widget.dart';
import 'package:live_order_tracking/core/widgets/primary_button_widget.dart';
import 'package:live_order_tracking/core/widgets/spacing_widgets.dart';
import 'package:live_order_tracking/features/auth/login/cubit/login_cubit.dart';
import 'package:live_order_tracking/features/auth/login/cubit/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();

    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is LoadingLoginState) {
              return LoadingWidget();
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeightSpace(28),
                    SizedBox(
                      width: 335.w,
                      child: Text(
                        "Login To Your Account",
                        style: AppStyles.primaryHeadLinesStyle,
                      ),
                    ),
                    const HeightSpace(8),
                    SizedBox(
                      width: 335.w,
                      child: Text(
                        "it's great to see you again",
                        style: AppStyles.grey12MediumStyle,
                      ),
                    ),
                    const HeightSpace(20),
                    Center(
                      child: Image.asset(
                        AppAssets.order,
                        width: 190.w,
                        height: 190.w,
                      ),
                    ),
                    const HeightSpace(32),
                    Text("Email", style: AppStyles.black16w500Style),
                    const HeightSpace(8),
                    CustomTextField(
                      controller: email,
                      hintText: "Enter Your Email",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your Email";
                        }
                        return null;
                      },
                    ),
                    const HeightSpace(16),
                    Text("Password", style: AppStyles.black16w500Style),
                    const HeightSpace(8),
                    CustomTextField(
                      hintText: "Enter Your Password",
                      controller: password,
                      suffixIcon: Icon(
                        Icons.remove_red_eye,
                        color: AppColors.greyColor,
                        size: 20.sp,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your Password";
                        }
                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                    const HeightSpace(55),
                    PrimayButtonWidget(
                      buttonText: "Sign in",
                      onPress: () {
                        if (formKey.currentState!.validate()) {
                          context.read<LoginCubit>().login(
                            email.text,
                            password.text,
                          );
                        }
                      },
                    ),
                    const Spacer(),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoutes.registerScreen);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: AppStyles.black16w500Style.copyWith(
                              color: AppColors.secondaryColor,
                            ),
                            children: [
                              TextSpan(
                                text: "Join",
                                style: AppStyles.black15BoldStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const HeightSpace(16),
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {
            if (state is SuccessLoginState) {
              showAnimatedSnackDialog(
                context,
                message: state.message,
                type: AnimatedSnackBarType.success,
              );
              GoRouter.of(context).pushReplacementNamed(AppRoutes.homeScreen);
            }
            if (state is ErrorLoginState) {
              showAnimatedSnackDialog(
                context,
                message: state.message,
                type: AnimatedSnackBarType.error,
              );
            }
          },
        ),
      ),
    );
  }
}
