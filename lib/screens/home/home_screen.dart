import 'package:cttgfahrer/config/UIFeedback.dart';
import 'package:cttgfahrer/config/constants.dart';
import 'package:cttgfahrer/main.dart';
import 'package:cttgfahrer/model/report_model.dart';
import 'package:cttgfahrer/model/user_model.dart';
import 'package:cttgfahrer/screens/home/bloc/bloc/home_bloc.dart';
import 'package:cttgfahrer/widgets/custom_header.dart';
import 'package:cttgfahrer/widgets/text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeStateLess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) => HomeBloc(),
      child: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController carController = new TextEditingController();
  TextEditingController tourController = new TextEditingController();
  TextEditingController scannerController = new TextEditingController();
  TextEditingController startKMController = new TextEditingController();
  TextEditingController endKMController = new TextEditingController();
  TextEditingController totalKMController = new TextEditingController();

  DateTime dateTimeNow = DateTime.now();
  DateTime dateTimeStart = DateTime.now();

  String _welleNumber;
  var timeDifference = 0;
  HomeBloc _homeBloc;
  String startTime = tr("setStartTime");
  String endTime = tr("setEndTime");
  @override
  Widget build(BuildContext context) {
    _homeBloc = BlocProvider.of<HomeBloc>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: homeBody(),
    );
  }

  SingleChildScrollView homeBody() {
    print(prefs.getString("locale"));
    if (prefs.getString("locale") == "en_US")
      prefs.setString("locale", "de_AT");
    else
      prefs.setString("locale", "en_US");

    if (prefs.getString("car") != null)
      carController.text = prefs.getString("car");
    if (prefs.getString("tour") != null)
      tourController.text = prefs.getString("tour");
    if (prefs.getString("scanner") != null)
      scannerController.text = prefs.getString("scanner");
    if (prefs.getString("endKM") != null)
      startKMController.text = prefs.getString("endKM");
    if (prefs.getString("welle") != null)
      _welleNumber = prefs.getString("welle");

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(25, 60, 25, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomHeader.getMainHeader('timesheet', context),
              Spacer(),
              PopupMenuButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
                onSelected: (value) {
                  switch (Constants.POPUP_MENU.indexOf(value)) {
                    case 0:
                      if (prefs.getString("locale") == "en_US")
                        EasyLocalization.of(context).locale =
                            Locale("de", "AT");
                      else
                        EasyLocalization.of(context).locale =
                            Locale("en", "US");
                      setState(() {});
                      break;
                    case 1:
                      bool isGerman = (prefs.getString("locale") == "en_US");
                      prefs.clear();
                      if (isGerman) prefs.setString('locale', 'de_AT');

                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login', (Route<dynamic> route) => false);
                      break;
                  }
                },
                itemBuilder: (BuildContext context) {
                  return Constants.POPUP_MENU.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice).tr(context: context),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          CustomHeader.getSubHeader('fillYourTimesheet', context),
          Container(
            child: RichText(
              text: TextSpan(
                text: DateFormat('EEEE').format(dateTimeNow) + ", ",
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: DateFormat('dd MMMM yyyy').format(dateTimeNow),
                    style: GoogleFonts.roboto(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text('Select Welle number'),
              value: _welleNumber,
              onChanged: (String number) {
                setState(() {
                  _welleNumber = number;
                });
              },
              items: Constants.WELLE_NUMBER.map((String item) {
                return DropdownMenuItem<String>(
                  child: Text(item),
                  value: item,
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: CustomTextField.getPlainTextFieldWithOutIcon(
                    'car', carController),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: CustomTextField.getPlainTextFieldWithOutIcon(
                    'tour', tourController),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: CustomTextField.getPlainTextFieldWithOutIcon(
                    'scanner', scannerController),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: CustomTextField.getPlainTextFieldWithOutIcon(
                    'startKM', startKMController),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: TextField(
                  onChanged: (s) =>
                      {totalKMController.text = calCulateKmDifference()},
                  controller: endKMController,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: tr('endKM'),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: CustomTextField.getDisabledPlainTextFieldWithOutIcon(
                    'totalKM', totalKMController, false),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    DatePicker.showTimePicker(
                      context,
                      showTitleActions: true,
                      onChanged: (date) {
                        print('change $date');
                      },
                      onConfirm: (date) {
                        setState(() {
                          startTime = DateFormat('HH:mm').format(date);
                          dateTimeStart = date;
                        });
                      },
                      currentTime: dateTimeStart,
                    );
                  },
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green),
                    child: Center(
                      child: Text(startTime,
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    dateTimeNow = DateTime.now();
                    endTime = DateFormat('HH:mm').format(dateTimeNow);

                    timeDifference =
                        dateTimeNow.difference(dateTimeStart).inMinutes;
                    print(' diff = $timeDifference');

                    if (validateInputs()) {
                      var breakHr = 0;
                      if (timeDifference <= 360) {
                        breakHr = 0;
                      } else if (timeDifference > 360 &&
                          timeDifference <= 480) {
                        breakHr = 30;
                      } else if (timeDifference > 480) {
                        breakHr = 45;
                      }
                      _homeBloc.add(
                        UpdateTimesheetEvent(
                          ReportModel(
                            breakHour: breakHr,
                            car: carController.text,
                            currentDate: dateTimeNow,
                            endKM: double.parse(endKMController.text),
                            endTime: dateTimeNow,
                            scanner: scannerController.text,
                            startKM: double.parse(startKMController.text),
                            startTime: dateTimeStart,
                            totalHour: timeDifference,
                            totalKM: double.parse(totalKMController.text),
                            tour: tourController.text,
                            welle: _welleNumber,
                            workingHour: (timeDifference - breakHr),
                            user: UserModel(
                                email: prefs.getString('email'),
                                id: prefs.getString('id'),
                                name: prefs.getString('name'),
                                status: 1,
                                password: '***'),
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    child: Center(
                      child: Text(
                        endTime,
                        style: GoogleFonts.roboto(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          BlocListener<HomeBloc, HomeState>(
            bloc: _homeBloc,
            listener: (context, state) {
              if (state is HomeFailed) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.response.responseMessage),
                ));
              } else if (state is HomeSuccess) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.getResponse.responseMessage),
                ));
              }
            },
            child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              print(state.toString());
              if (state is HomeProcessing) {
                return LinearProgressIndicator();
              }
              return Container();
            }),
          ),
          SizedBox(
            height: 350,
          ),
        ],
      ),
    );
  }

  bool validateInputs() {
    if (carController.text.isEmpty) {
      UIFeedback.showToast(tr("carNotEnter"));
      return false;
    }
    if (tourController.text.isEmpty) {
      UIFeedback.showToast(tr("tourNotEnter"));
      return false;
    }
    if (scannerController.text.isEmpty) {
      UIFeedback.showToast(tr("scannerNotEnter"));
      return false;
    }
    if (startKMController.text.isEmpty) {
      UIFeedback.showToast(tr("startKMNotEnter"));
      return false;
    }
    if (endKMController.text.isEmpty) {
      UIFeedback.showToast(tr("endKMNotEnter"));
      return false;
    }

    if (_welleNumber == null) {
      UIFeedback.showToast("Select welle");
      return false;
    }

    if (startTime.contains("time") || startTime.contains("einstellen")) {
      UIFeedback.showToast(tr("startTimeNotEnter"));
      return false;
    }
    if (endTime.contains("time")) {
      UIFeedback.showToast(tr("startTimeNotEnter"));
      return false;
    }
    double start = 0.0;
    double end = 0.0;
    try {
      start = double.parse(startKMController.text);
      end = double.parse(endKMController.text);
    } on Exception catch (e) {
      UIFeedback.showToast(tr("invalidStartEndKMReading"));
      return false;
    }

    if (start >= end) {
      UIFeedback.showToast(tr("startKmIsLess"));
      return false;
    }

    if (timeDifference < 1) {
      UIFeedback.showToast(tr("invalidStartAndEndTime"));
      return false;
    }
    return true;
  }

  String calCulateKmDifference() {
    double start = 0.0;
    double end = 0.0;
    try {
      start = double.parse(startKMController.text);
      end = double.parse(endKMController.text);
      return (end - start).toString();
    } on Exception catch (e) {
      return "";
    }
  }
}
