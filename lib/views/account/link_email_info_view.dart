import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LinkEmailInfoView extends StatefulWidget {
  const LinkEmailInfoView({super.key});

  @override
  State<LinkEmailInfoView> createState() => _LinkEmailInfoViewState();
}

class _LinkEmailInfoViewState extends State<LinkEmailInfoView> {
  final _formKey = GlobalKey<FormState>();
  bool _hidePassword = true;
  String _email = "";
  String _password = "";
  void _saved() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.pop({"email": _email, "password": _password});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text("Email", style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email ...",
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
              ).applyDefaults(Theme.of(context).inputDecorationTheme),
              style: Theme.of(context).textTheme.bodyMedium,
              validator: (value) {
                if (value == null || !value.contains("@")) {
                  return "Bạn phải nhập đúng định dạng email!";
                }
                return null;
              },
              onSaved: (newValue) {
                _email = newValue!;
              },
            ),
            const SizedBox(height: 16),
            Text("Password", style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            TextFormField(
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: "Password ...",
                prefixIcon: Icon(
                  Icons.lock,
                  color: Theme.of(context).iconTheme.color,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                  child: _hidePassword
                      ? Icon(
                          Icons.visibility_off,
                          color: Theme.of(context).iconTheme.color,
                        )
                      : Icon(
                          Icons.visibility,
                          color: Theme.of(context).iconTheme.color,
                        ),
                ),
              ).applyDefaults(Theme.of(context).inputDecorationTheme),

              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Bạn cần điền mật khẩu!";
                }
                if (value.length < 6) {
                  return "Mật khẩu cần tối thiểu 6 kí tự!";
                }
                return null;
              },
              obscureText: _hidePassword,
              onSaved: (newValue) {
                _password = newValue!;
              },
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saved,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("Liên kết"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
