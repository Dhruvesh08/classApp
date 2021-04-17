import 'package:classapp/modals/user.dart';
import 'package:flutter/material.dart';

class CreateUserAccount extends StatefulWidget {
  @override
  _CreateUserAccountState createState() => _CreateUserAccountState();
}

class _CreateUserAccountState extends State<CreateUserAccount> {
  static const _padding = const EdgeInsets.all(10.0);
  final _formKey = GlobalKey<FormState>();

  User _user = User(
    id: "",
    name: "",
    middleName: "",
    lastName: "",
    mobileNo: "",
    department: "",
    address: "",
    city: "",
    pincode: "",
    state: "",
    country: "",
  );

  void saveForm() {
    _formKey.currentState.save();
    Navigator.pop(context, _user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  height: 150,
                  width: 150,
                  child: Image.asset(
                    "assets/images/user_details.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                "Faculty Registration Form",
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  Padding(
                    padding: _padding,
                    child: TextFormField(
                      onSaved: (val) => _user.name = val,
                      decoration: InputDecoration(labelText: "Enter Your Name"),
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: TextFormField(
                      onSaved: (val) => _user.middleName = val,
                      decoration:
                          InputDecoration(labelText: "Enter Middle Name"),
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: TextFormField(
                      onSaved: (val) => _user.lastName = val,
                      decoration: InputDecoration(labelText: "Enter Last Name"),
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: TextFormField(
                      onSaved: (val) => _user.department = val,
                      decoration:
                          InputDecoration(labelText: "Enter Your Department"),
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: TextFormField(
                      onSaved: (val) => _user.mobileNo = val,
                      decoration:
                          InputDecoration(labelText: "Enter Mobile No."),
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: TextFormField(
                      onSaved: (val) => _user.address = val,
                      decoration: InputDecoration(labelText: "Address"),
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: TextFormField(
                      onSaved: (val) => _user.pincode = val,
                      decoration: InputDecoration(labelText: "Pincode"),
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: TextFormField(
                      onSaved: (val) => _user.city = val,
                      decoration: InputDecoration(labelText: "City"),
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: TextFormField(
                      onSaved: (val) => _user.state = val,
                      decoration: InputDecoration(labelText: "State"),
                    ),
                  ),
                  Padding(
                    padding: _padding,
                    child: TextFormField(
                      onSaved: (val) => _user.country = val,
                      decoration: InputDecoration(labelText: "Country"),
                    ),
                  ),
                  Container(
                    padding: _padding,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => saveForm(),
                            child: Text("Submit"),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
