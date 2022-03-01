import 'package:flutter/material.dart';
import 'package:greetings/view/provider/greetings_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  FocusNode? _focusNameNode;

  @override
  void initState() {
    super.initState();
    _focusNameNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNameNode?.dispose();
    super.dispose();
  }

  Future<void> _submit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final model = context.read<GreetingsProvider>();
      await model.greet(_name);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${model.salutation}, ${model.name}'),
      ));

      _focusNameNode?.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Greetings!'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                autofocus: true,
                focusNode: _focusNameNode,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name...',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _submit(context),
                onSaved: (input) => _name = input,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () => _submit(context),
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
