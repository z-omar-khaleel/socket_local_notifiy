import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task1_implemention/socket.dart';
import 'package:web_socket_channel/io.dart';

import 'get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialBinding: IntinalBinding(),
        debugShowCheckedModeBanner: false,
        home: new MyHomePage(
          channel: new IOWebSocketChannel.connect(
              Uri.parse('wss://jawali-api.herokuapp.com')),
        ));
  }
}

class Home extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  final startController = TextEditingController();
  final endController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task 1'),
      ),
      body: OtherClass(),
    );
  }
}

class Universty extends StatelessWidget {
  Universty({
    @required this.startController,
    @required this.endController,
    @required this.key,
  });

  final TextEditingController startController;
  final TextEditingController endController;
  final GlobalKey<FormState> key;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Course ',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Course Name',
                              hintText: 'Enter Course Name'),
                          validator: (val) {
                            if (val.isEmpty) return 'Enter Course Name';
                            return null;
                          },
                          keyboardType: TextInputType.text,
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                                labelText: 'course Instructor',
                                hintText: 'Enter Course Instructor'),
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Enter Course Instructor';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text),
                        TextFormField(
                            controller: startController,
                            decoration: InputDecoration(
                                labelText: 'Start Date',
                                hintText: 'Enter Start Date'),
                            validator: (val) {
                              if (val.isEmpty) return 'Enter Start Date';
                              return null;
                            },
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2021-12-03'),
                              ).then((value) {
                                startController.text =
                                    DateFormat.yMMMd().format(value);
                              });
                            },
                            keyboardType: TextInputType.datetime),
                        TextFormField(
                            controller: endController,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2021-12-03'),
                              ).then((value) {
                                endController.text =
                                    DateFormat.yMMMd().format(value);
                              });
                            },
                            decoration: InputDecoration(
                                labelText: ' End Date',
                                hintText: 'Enter End Date'),
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Enter End Date';
                              }
                              if (val.isNotEmpty) {
                                print('/*/*/**/*/');
                                final DateTime start = DateFormat.yMMMd()
                                    .parse(startController.text);
                                print(start);
                                final DateTime end = DateFormat.yMMMd()
                                    .parse(endController.text);
                                print(end);

                                if (start.isAfter(end))
                                  return 'Enter End Date after Start';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.datetime),
                        TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Course Duration',
                                hintText: 'Enter Course Duration'),
                            validator: (val) {
                              if (val.isEmpty) return 'Enter Course Duration';
                              return null;
                            },
                            keyboardType: TextInputType.number),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Maximum number of Students',
                              hintText: 'Enter Maximum number of Students'),
                          validator: (val) {
                            if (val.isEmpty)
                              return 'Enter Maximum number of Students';
                            return null;
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: () {
                      if (key.currentState.validate()) {}
                    },
                    child: Text('Submit'),
                  )
                ],
              ),
              key: key,
            )
          ],
        ),
      ),
    );
  }
}

class OtherClass extends GetView<Controller> {
  @override
  // TODO: implement controller

  @override
  Widget build(BuildContext context) {
    controller.change(User('zeco', 'title'), status: RxStatus.error('Error'));
    return Scaffold(
      body: controller.obx(
        (state) => Center(child: Text(state.title)),

        // here you can put your custom loading indicator, but
        // by default would be Center(child:CircularProgressIndicator())
        onLoading: CircularProgressIndicator(),
        onEmpty: Text('No data found'),

        // here also you can set your own error widget, but by
        // default will be an Center(child:Text(error))
        onError: (error) => Text(error),
      ),
    );
  }
}
