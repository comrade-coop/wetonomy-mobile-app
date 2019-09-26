import 'package:flutter/material.dart';
import 'package:wetonomy/constants/strings.dart';
import 'package:wetonomy/screens/welcome/components/app_title.dart';

class CreatePasswordSection extends StatefulWidget {
  @override
  _CreatePasswordSectionState createState() => _CreatePasswordSectionState();
}

class _CreatePasswordSectionState extends State<CreatePasswordSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        title: AppTitle(),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildTitle(),
          _buildPasswordInputs(),
          _buildNextButton()
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(Strings.createPasswordLabel,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.display1);
  }

  Widget _buildNextButton() {
    final theme = Theme.of(context);

    return RaisedButton(
      onPressed: () {},
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'Next',
          style: theme.textTheme.button.apply(color: theme.accentColor),
        ),
      ),
    );
  }

  Widget _buildPasswordInputs() {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
              autocorrect: false,
              decoration: InputDecoration(
                  filled: true,
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  helperText: 'Minimum 8 characters',
                  suffixIcon: Icon(Icons.remove_red_eye),
                  hintText: 'Password',
                  alignLabelWithHint: true)),
          SizedBox(height: 24),
          TextFormField(
              autocorrect: false,
              decoration: InputDecoration(
                  filled: true,
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  hintText: 'Confirm Password',
                  alignLabelWithHint: true)),
        ],
      ),
    );
  }
}
