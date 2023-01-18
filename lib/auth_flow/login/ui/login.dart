import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzel/auth_flow/auth_cubit/auth_cubit.dart';
import 'package:manzel/auth_flow/auth_cubit/auth_state.dart';
import 'package:manzel/auth_flow/data/models/send_models/auth_send_model.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';
import 'package:manzel/flutter_flow/flutter_flow_util.dart';
import 'package:manzel/shared/styles/sizes.dart';
import 'package:manzel/shared/ui/components/custom_button.dart';
import 'package:manzel/shared/ui/components/custom_check_box.dart';
import 'package:manzel/shared/ui/components/custom_text_field.dart';
import 'package:manzel/shared/validators/auth_validator.dart';

//TODO apply translation
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phone = TextEditingController();
  late AuthCubit _cubit;

  TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool agree = false;

  @override
  void initState() {
    this._cubit = BlocProvider.of<AuthCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).white,
      body: Container(
        width: getWidth(context),
        height: getHeight(context),
        padding: PAGE_EDGES_PADDING_ALL,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Image.asset("assets/images/auth_logo.png",
                        width: getWidth(
                          context,
                          ratio: 0.8,
                        ))),
                SizedBox(
                  height: getHeight(context, ratio: 0.02),
                ),
                Center(
                  child: Text(
                    "Sign In",
                    style: FlutterFlowTheme.of(context)
                        .title3
                        .copyWith(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                CustomTextField(
                  controller: _phone,
                  label: "phone",
                  validator: AuthValidator.validateNumber,
                  required: true,
                  hint: "05xxxx xxxx",
                  prefixIconWidget: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Image.asset(
                        "assets/images/saudi_flag.png",
                        width: 21,
                        height: 15,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 25,
                        color: Colors.black26,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(context, ratio: 0.17),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "By clicking continue, you agree",
                        style: FlutterFlowTheme.of(context).title3.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                      ),
                      Text(
                        "to our terms & conditions & privacy policy",
                        style: FlutterFlowTheme.of(context).title3.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: FlutterFlowTheme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(context, ratio: 0.04),
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return CustomButton(
                      text: "Continue",
                      loading: state is AuthStateLoading ? state.login : false ,
                      validationKey: _formKey,
                      onPressed: () {
                        //TODO run the API here
                        // context.goNamed("choose_otp");
                        _cubit.dataModel.phoneNumber = _phone.text ;
                        _cubit.login();
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
