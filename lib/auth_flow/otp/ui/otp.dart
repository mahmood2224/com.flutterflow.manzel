import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manzel/auth_flow/auth_cubit/auth_cubit.dart';
import 'package:manzel/auth_flow/auth_cubit/auth_state.dart';
import 'package:manzel/auth_flow/otp/ui/widgets/timer_widget.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';
import 'package:manzel/flutter_flow/flutter_flow_util.dart';
import 'package:manzel/shared/styles/sizes.dart';
import 'package:manzel/shared/ui/components/app_bar.dart';
import 'package:manzel/shared/ui/components/custom_button.dart';
import 'package:manzel/shared/utils/directions.dart';
import 'package:manzel/shared/validators/general_validator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

//TODO apply translation
class OtpScreen extends StatefulWidget {
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController _code = TextEditingController();
  late final AuthCubit _cubit;
  final _forKey = GlobalKey<FormState>();

  @override
  void initState() {
    _cubit = BlocProvider.of<AuthCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Verification", actions: [
        Padding(
          padding: PAGE_EDGES_PADDING_ALL,
          child: Icon(
            Icons.close,
            color: Colors.black,
          ),
        )
      ]),
      body: Container(
        width: getWidth(context),
        height: getHeight(context),
        padding: PAGE_EDGES_PADDING_HORIZONTAL,
        child: SingleChildScrollView(
          child: Form(
            key: _forKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: getHeight(
                  context,
                  ratio: 0.05,
                )),
                Text(
                  "We'll send a verification code to Your contact so you can login or create an account",
                  style: FlutterFlowTheme.of(context).title3.copyWith(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: getHeight(context, ratio: 0.2),
                ),
                Text(
                  "Code has been send to +${_cubit.dataModel.getDecoratedPhoneNumber()}",
                  style: FlutterFlowTheme.of(context).title3.copyWith(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: getHeight(context, ratio: 0.05),
                ),
                Directionality(
                  textDirection: getTextDirectionLTR(),
                  child: PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    validator: GeneralValidator.requiredValidator,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(6),
                        fieldHeight: 44,
                        fieldWidth: 48,
                        inactiveColor: Colors.black12,
                        selectedColor: Colors.black12,
                        activeFillColor: Colors.white,
                        activeColor: FlutterFlowTheme.of(context).primaryColor,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.white),
                    animationDuration: Duration(milliseconds: 300),
                    enableActiveFill: true,
                    cursorColor: Colors.black26,
                    controller: _code,
                    onCompleted: (v) {},
                    onChanged: (value) {},
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                    appContext: context,
                  ),
                ),
                SizedBox(
                  height: getHeight(context, ratio: 0.05),
                ),
                OtpTimerWidget(),
                SizedBox(
                  height: getHeight(context, ratio: 0.25),
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return CustomButton(
                      text: "Get Started",
                      validationKey: _forKey,
                      loading: state is AuthStateLoading ? state.otpVerify : false,
                      onPressed: () {
                        _cubit.dataModel.otp = _code.text ;
                        _cubit.verifyOtp();
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
