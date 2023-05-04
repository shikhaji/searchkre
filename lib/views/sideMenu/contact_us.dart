import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:search_kare/utils/validation_mixin.dart';
import 'package:search_kare/widget/app_bars.dart';
import 'package:search_kare/widget/app_button.dart';
import 'package:search_kare/widget/app_text_field.dart';
import 'package:search_kare/widget/custom_sized_box.dart';
import 'package:search_kare/widget/scrollview.dart';

import '../../services/api_services.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen>
    with ValidationMixin {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _sub = TextEditingController();
  final TextEditingController _msg = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BackAppBar(
          context,
          title: 'Contact Us',
        ),
        body: Form(
          key: _formKey,
          child: CustomScroll(
            children: [
              SizedBoxH20(),
              AppTextField(
                title: "Name",
                controller: _name,
                hintText: "Enter your name",
                validator: nameValidator,
              ),
              AppTextField(
                title: "Email ID",
                controller: _email,
                hintText: "Enter your email-id",
                validator: emailValidator,
              ),
              AppTextField(
                title: "Subject",
                controller: _sub,
                hintText: "Enter your Subject",
                validator: msgValidator,
              ),
              AppTextField(
                title: "Message",
                controller: _msg,
                hintText: "Enter your message",
                validator: msgValidator,
              ),
              SizedBoxH8(),
              AppButton(
                  title: "Submit",
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      FormData data() {
                        return FormData.fromMap({
                          "name": _name.text.trim(),
                          'email': _email.text.trim(),
                          'subject': _sub.text.trim(),
                          "msg": _msg.text.trim(),
                        });
                      }

                      ApiService().contactUs(context, data: data());
                      Navigator.pop(context);
                    }
                  }),
            ],
          ),
        ));
  }
}
