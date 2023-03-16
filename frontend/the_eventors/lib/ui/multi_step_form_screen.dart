import 'dart:convert';
import 'dart:io';

import 'package:datetime_picker_formfield_new/datetime_picker_formfield_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/models/ImageHelper.dart';
import 'package:the_eventors/providers/EventProvider.dart';
import 'package:the_eventors/ui/home_screen.dart';
import 'package:uuid/uuid.dart';
import '../models/Category.dart';
import '../providers/CategoryProvider.dart';
import '../services/GetLocation.dart';
import '../services/Keys.dart';
import 'package:http/http.dart' as http;

import 'my_search_delegate.dart';

class MultiStepFormPage extends StatefulWidget {
  const MultiStepFormPage({Key? key}) : super(key: key);

  @override
  State<MultiStepFormPage> createState() => _MultiStepFormPageState();
}

class _MultiStepFormPageState extends State<MultiStepFormPage> {
  int currentStep = 0;
  String buttonStep = "Continue";
  bool isLoading = true;
  Category c = Category(id: 0, imageUrl: "", name: "", description: "");
  bool check = false;
  bool checkCoverImage = false;
  final format = DateFormat("yyyy-MM-dd HH:mm");
  String _sessionToken = "122344";
  var uuid = Uuid();
  List<dynamic> _placeList = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController guestController = TextEditingController();
  List<GlobalObjectKey<FormState>> formKeyList = [];

  final galleryController = MultiImagePickerController(
    maxImages: 10,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );
  final coverController = MultiImagePickerController(
    maxImages: 1,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );
  late String? category = "";
  late int idCategory = 0;
  late List categories = [];
  final imageHelper = ImageHelper();
  File? _image;
  @override
  void initState() {
    super.initState();
    formKeyList =
        List.generate(10, (index) => GlobalObjectKey<FormState>(index));
    Provider.of<CategoryProvider>(context, listen: false).getCategories();
    locationController.addListener(() {
      onChanged();
    });
    Future.delayed(const Duration(milliseconds: 1000), () async {
      categories = context.read<CategoryProvider>().categories;

      setState(() {
        isLoading = false;
      });
    });
  }

  void onChanged() {
    setState(() {
      _sessionToken = uuid.v4();
    });

    getSuggestion(locationController.text);
  }

  void getSuggestion(String input) async {
    String api = "AIzaSyCJL6U_VH51jknp-Vs3ciddmoPX2_kH5Ak";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$api&swssiontoke=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _placeList = jsonDecode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  checkStep() {
    return (!(currentStep == getSteps().length - 1));
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    coverController.dispose();
    locationController.dispose();
    startTimeController.dispose();
    durationController.dispose();
    guestController.dispose();
    formKeyList = [];
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text(
          "Details",
          style: TextStyle(
            color: Color(0xFFEEFBFB),
          ),
        ),
        content: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Info details',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFEEFBFB),
                ),
              ),
            ),
            TextForm(context, titleController, "Title", false, formKeyList[0]),
            TextForm(context, descriptionController, "Description", false,
                formKeyList[1]),
            DropdownButtonFormField(
              style: TextStyle(color: Color(0xFF12232E)),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFEEFBFB),
                hintText: "Select category",
                hintStyle: TextStyle(color: Color(0xFF12232E)),
                labelStyle: TextStyle(color: Color(0xFF12232E)),
                errorStyle: TextStyle(fontSize: 16),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 10,
                    color: idCategory == 0 ? Colors.red : Color(0xFF12232E),
                    style: BorderStyle.none,
                  ),
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                ),
              ),
              items: categories.map((e) {
                return DropdownMenuItem(
                  child: Text(
                    e.name,
                  ),
                  value: e,
                  onTap: () {
                    setState(() {
                      idCategory = e.id;
                    });
                  },
                );
              }).toList(),
              onChanged: (value) {
                c = value as Category;
              },
              isExpanded: true,
              iconSize: 24.0,
              hint: category != ""
                  ? Text(
                      category!,
                      style: TextStyle(color: Color(0xFF12232E)),
                    )
                  : const Text('Select category',
                      style: TextStyle(color: Color(0xFF12232E))),
            ),
            if (check)
              Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.3),
                  child: Text(
                    "Please select category",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w400),
                  )),
            Column(children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Form(
                      key: formKeyList[2],
                      child: TextFormField(
                        controller: locationController,
                        focusNode: FocusNode(),
                        onTap: () {
                          final result = showSearch(
                              context: context, delegate: MySearchDelegate());

                          setState(() async {
                            await result.then(
                                (value) => locationController.text = value);
                          });
                        },
                        style: const TextStyle(color: Color(0xFF12232E)),
                        cursorColor: const Color(0xFF12232E),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter your location";
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFEEFBFB),
                          hintText: "Location",
                          suffixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color(0xFFEEFBFB),
                                        Color(0xFFEEFBFB),
                                      ],
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF1C1C1C)
                                            .withOpacity(0.2),
                                        spreadRadius: 3,
                                        blurRadius: 4,
                                        offset: const Offset(0, 3),
                                      )
                                    ]),
                                child: IconButton(
                                    onPressed: () async {
                                      String location =
                                          await GetLocation.getAddres();
                                      setState(() {
                                        locationController.text = location;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.location_searching,
                                      color: Color(0xFF1C1C1C),
                                      size: 20,
                                    )),
                              )),
                          errorStyle: const TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 10,
                              color: Colors.white,
                              style: BorderStyle.none,
                            ),
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ),
                          ),
                        ),
                      ))),
            ]),
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text(
          "Time",
          style: TextStyle(
            color: Color(0xFFEEFBFB),
          ),
        ),
        content: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Event times',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFEEFBFB),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Form(
                    key: formKeyList[3],
                    child: DateTimeField(
                      focusNode: FocusNode(),
                      style: const TextStyle(color: Color(0xFF12232E)),
                      cursorColor: const Color(0xFF12232E),
                      format: DateFormat("yyyy-MM-dd HH:mm"),
                      onShowPicker: (context, currentValue) async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );
                          setState(() {
                            startTimeController.text =
                                DateTimeField.combine(date, time).toString();
                          });

                          return DateTimeField.combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFEEFBFB),
                        hintText: "Start date-time",
                        errorStyle: TextStyle(fontSize: 16),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 10,
                            color: Colors.white,
                            style: BorderStyle.none,
                          ),
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                        ),
                      ),
                    ))),
            /*TextForm(context, startTimeController, "Start time", false,
                formKeyList[3]),*/
            TextForm(
                context, durationController, "Duration", false, formKeyList[4])
          ],
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text(
          "More details",
          style: TextStyle(
            color: Color(0xFFEEFBFB),
          ),
        ),
        content: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, bottom: 20.0, top: 5.0),
              child: Text(
                'More details',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFEEFBFB),
                ),
              ),
            ),
            TextForm(context, guestController, "Guest", false, formKeyList[5]),
            Container(
                height: 55,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xff4DA8DA),
                        Color(0xff007CC7),
                      ],
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1C1C1C).withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      )
                    ]),
                child: MaterialButton(
                  onPressed: () async {
                    final files = await imageHelper.pickImage();
                    setState(() {
                      _image = File(files.first.path);
                    });

                    if (_image != null) {
                      setState(() {
                        checkCoverImage = false;
                      });
                    } else {
                      setState(() {
                        checkCoverImage = true;
                      });
                    }
                  },
                  child: Center(
                      child: _image != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                  Flexible(
                                      child: Text(
                                    "Change your cover image",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 250, 250, 250)),
                                  )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.add_a_photo,
                                      color: Color.fromARGB(255, 250, 250, 250))
                                ])
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                  Flexible(
                                      child: Text(
                                    "Cover image",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 250, 250, 250)),
                                  )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.add_a_photo,
                                      color: Color.fromARGB(255, 250, 250, 250))
                                ])),
                )),
            if (checkCoverImage)
              Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.3),
                  child: Text(
                    "Please select cover image",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w400),
                  )),
            if (_image != null)
              Center(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: ClipRRect(
                    child: Container(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      height: 150,
                      width: 150,
                      child: Image.memory(_image!.readAsBytesSync()),
                    ),
                  ),
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            MultiImagePickerView(
              controller: galleryController,
              addButtonTitle: "Add image for gallery",
              draggable: true,
              onDragBoxDecoration: const BoxDecoration(color: Colors.blue),
              initialContainerBuilder: (context, deleteCallback) {
                return Container(
                    height: 55,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xff4DA8DA),
                            Color(0xff007CC7),
                          ],
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1C1C1C).withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          )
                        ]),
                    child: MaterialButton(
                      onPressed: () async {
                        galleryController.pickImages();
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              "Gallery images",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 250, 250, 250)),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.add_a_photo,
                                color: Color.fromARGB(255, 250, 250, 250))
                          ]),
                    ));
              },
              addMoreBuilder: (context, pickerCallback) {
                return Container(
                    height: 55,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 57, 129, 236),
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1C1C1C).withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          )
                        ]),
                    child: MaterialButton(
                      onPressed: () async {
                        galleryController.pickImages();
                      },
                      child: const Center(child: Icon(Icons.add_a_photo)),
                    ));
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: const Color(0xFF203647),
            appBar: AppBar(
              backgroundColor: const Color(0xFF203647),
              title: IconButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                icon: const Icon(Icons.arrow_back),
                iconSize: 30,
                color: const Color(0xFFEEFBFB),
              ),
            ),
            body: isLoading
                ? Container()
                : Container(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Theme(
                        data: ThemeData(
                          canvasColor: const Color(0xFF007CC7),
                          textTheme: Theme.of(context).textTheme.apply(
                              bodyColor: Colors.white,
                              displayColor: Colors.white,
                              decorationColor: Colors.white),
                          colorScheme: Theme.of(context).colorScheme.copyWith(
                                primary: const Color(0xFF007CC7),
                                background: const Color(0xFF007CC7),
                                secondary: const Color(0xFF007CC7),
                              ),
                        ),
                        child: Stepper(
                          elevation: 0.0,
                          type: StepperType.vertical,
                          currentStep: currentStep,
                          controlsBuilder: (context, details) {
                            return ListView(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 5),
                              children: [
                                Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Color(0xff4DA8DA),
                                            Color(0xff007CC7),
                                          ],
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF1C1C1C)
                                                .withOpacity(0.2),
                                            spreadRadius: 3,
                                            blurRadius: 4,
                                            offset: const Offset(0, 3),
                                          )
                                        ]),
                                    child: MaterialButton(
                                        onPressed: details.onStepContinue,
                                        child: Center(
                                            child: Text(
                                          checkStep() ? "Continue" : "Create",
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFEEFBFB)),
                                        )))),
                                Container(
                                  height: 30,
                                  child: TextButton(
                                    onPressed: details.onStepCancel,
                                    child: const Text(
                                      "Back",
                                      style:
                                          TextStyle(color: Color(0xFFEEFBFB)),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          onStepCancel: () async => currentStep == 0
                              ? Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => const HomeScreen()))
                                  .then((value) => setState(() {
                                        isLoading = true;
                                        initState();
                                      }))
                              : setState(() {
                                  currentStep -= 1;
                                }),
                          onStepContinue: () async {
                            bool isLastStep =
                                (currentStep == getSteps().length - 1);

                            if (isLastStep && _image == null) {
                              setState(() {
                                checkCoverImage = true;
                              });
                            }

                            if (isLastStep &&
                                formKeyList[5].currentState!.validate() &&
                                _image != null) {
                              List<File> listImages = [];
                              final images = galleryController
                                  .images; // return Iterable<ImageFile>
                              for (final image in images) {
                                if (image.hasPath) {
                                  listImages.add(
                                      await FlutterNativeImage.compressImage(
                                    image.path!,
                                    quality: 50,
                                  ));
                                } else {
                                  listImages
                                      .add(File.fromRawPath(image.bytes!));
                                }
                              }
                              //Do something with this information.
                              if (checkFirstStep() &&
                                  checkSecondStep() &&
                                  formKeyList[5].currentState!.validate() &&
                                  _image != null) {
                                Provider.of<EventProvider>(context,
                                        listen: false)
                                    .addEvent(
                                        titleController.text,
                                        descriptionController.text,
                                        locationController.text,
                                        await FlutterNativeImage.compressImage(
                                          _image!.path,
                                          quality: 50,
                                        ),
                                        listImages,
                                        guestController.text,
                                        startTimeController.text,
                                        durationController.text,
                                        idCategory.toString());
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  // Your code HERE
                                  // Flutter will wait until the current build is completed before executing this code.
                                  if (mounted) {
                                    setState(() {});
                                  }
                                  deactivate();
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return HomeScreen(
                                      key: UniqueKey(),
                                    );
                                  }));
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        "You need to complete all the requirements",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            } else {
                              if (currentStep == 0) {
                                if (idCategory == 0) {
                                  setState(() {
                                    check = true;
                                  });
                                } else {
                                  setState(() {
                                    check = false;
                                  });
                                }
                                if (checkFirstStep()) {
                                  setState(() {
                                    currentStep += 1;
                                  });
                                }
                              } else if (currentStep > 0) {
                                setState(() {
                                  currentStep += 1;
                                });
                              }
                            }
                          },
                          onStepTapped: (step) => setState(() {
                            currentStep = step;
                          }),
                          steps: getSteps(),
                        ))),
          ),
        ));
  }

  checkFirstStep() {
    return formKeyList[0].currentState!.validate() &&
        formKeyList[1].currentState!.validate() &&
        formKeyList[2].currentState!.validate() &&
        idCategory != 0;
  }

  checkSecondStep() {
    return formKeyList[4].currentState!.validate() &&
        formKeyList[5].currentState!.validate();
  }
}

Widget TextForm(BuildContext context, TextEditingController controller,
    String hint, bool flag, final key) {
  return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Form(
          key: key,
          child: TextFormField(
            focusNode: FocusNode(),
            style: const TextStyle(color: Color(0xFF12232E)),
            cursorColor: const Color(0xFF12232E),
            minLines: 1,
            maxLines: flag ? 10 : 1,
            keyboardType: flag ? TextInputType.multiline : TextInputType.text,
            controller: controller,
            validator: (String? value) {
              if (value!.isEmpty) {
                return "Please enter your " + hint.toLowerCase();
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFEEFBFB),
              hintText: hint,
              errorStyle: TextStyle(fontSize: 16),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 10,
                  color: Colors.white,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
              ),
            ),
          )));
}
