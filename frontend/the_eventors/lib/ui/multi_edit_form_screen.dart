import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:datetime_picker_formfield_new/datetime_picker_formfield_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/models/ImageHelper.dart';
import 'package:the_eventors/package/multi_image/multi_image_picker_controller.dart';
import 'package:the_eventors/package/multi_image/multi_image_picker_view.dart';
import 'package:the_eventors/providers/EventProvider.dart';
import 'package:the_eventors/ui/detail_event_screen.dart';
import 'package:the_eventors/ui/home_screen.dart';
import 'package:uuid/uuid.dart';
import '../models/Category.dart';
import '../models/Events.dart';
import '../package/multi_image/image_file.dart';
import '../providers/CategoryProvider.dart';
import '../services/GetLocation.dart';
import '../services/Keys.dart';
import 'package:http/http.dart' as http;

import 'my_search_delegate.dart';

class MultiEditFormScreen extends StatefulWidget {
  final Events event;

  const MultiEditFormScreen({Key? key, required this.event}) : super(key: key);

  @override
  State<MultiEditFormScreen> createState() => _MultiEditFormScreenState();
}

class _MultiEditFormScreenState extends State<MultiEditFormScreen> {
  int currentStep = 0;
  String buttonStep = "Continue";
  bool isLoading = true;
  Category c = Category(id: 0, imageUrl: "", name: "", description: "");
  bool check = false;
  bool checkCoverImage = false;
  final format = DateFormat("yyyy-MM-dd HH:mm");
  List<String> imagesGallery = [];
  String _sessionToken = "122344";
  var uuid = Uuid();
  List<dynamic> _placeList = [];
  late TextEditingController titleController =
      TextEditingController(text: widget.event.title);
  late TextEditingController descriptionController =
      TextEditingController(text: widget.event.description);
  late TextEditingController locationController =
      TextEditingController(text: widget.event.location);
  late TextEditingController startTimeController =
      TextEditingController(text: widget.event.startDateTime);
  late TextEditingController durationController =
      TextEditingController(text: widget.event.duration);
  late TextEditingController guestController =
      TextEditingController(text: widget.event.guest.join(","));

  late var galleryController = MultiImagePickerController();
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
    Provider.of<CategoryProvider>(context, listen: false).getCategories();
    locationController.addListener(() {
      onChanged();
    });
    Future.delayed(const Duration(milliseconds: 1000), () async {
      categories = context.read<CategoryProvider>().categories;
      print(widget.event.duration);
      imagesGallery = widget.event.images;
      galleryController = MultiImagePickerController(
        maxImages: 10 - imagesGallery.length,
        allowedImageTypes: ['png', 'jpg', 'jpeg'],
      );
      category = widget.event.category;
      idCategory = widget.event.categoryId;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  Future<String> createFileFromString(String str) async {
    Uint8List bytes = base64.decode(str);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File(
        "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".jpg");
    await file.writeAsBytes(bytes);
    return file.path;
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
            TextForm(
              context,
              titleController,
              "Title",
              false,
            ),
            TextForm(
              context,
              descriptionController,
              "Description",
              false,
            ),
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
            if (category!.isEmpty)
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
                      child: TextFormField(
                    controller: locationController,
                    focusNode: FocusNode(),
                    onTap: () {
                      final result = showSearch(
                          context: context, delegate: MySearchDelegate());

                      setState(() async {
                        await result
                            .then((value) => locationController.text = value);
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
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
                    child: DateTimeField(
                  focusNode: FocusNode(),
                  style: const TextStyle(color: Color(0xFF12232E)),
                  cursorColor: const Color(0xFF12232E),
                  controller: startTimeController,
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
              context,
              durationController,
              "Duration",
              false,
            )
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
            TextForm(
              context,
              guestController,
              "Guest",
              false,
            ),
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
                    },
                    child: Center(
                        child: Row(
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
                                color: Color.fromARGB(255, 250, 250, 250)),
                          )),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.add_a_photo,
                              color: Color.fromARGB(255, 250, 250, 250))
                        ])))),
            if (widget.event.coverImage.isNotEmpty)
              Center(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: ClipRRect(
                    child: Container(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      height: 150,
                      width: 150,
                      child: _image == null
                          ? Image.memory(base64Decode(widget.event.coverImage))
                          : Image.memory(_image!.readAsBytesSync()),
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
                              "Add more images",
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
            GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                padding: const EdgeInsets.all(4.0),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                children: widget.event.images.map((String url) {
                  return GridTile(
                      header: Container(
                          height: 50,
                          width: 50,
                          padding: EdgeInsets.only(
                            top: 5,
                            bottom: 20,
                            left: 90.w,
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                imagesGallery.remove(url);
                              });
                              print(galleryController.maxImages);
                            },
                            child: Image.asset(
                              'assets/close-48.png',
                              height: 10,
                              width: 10,
                            ),
                          )),
                      child:
                          Image.memory(base64Decode(url), fit: BoxFit.cover));
                }).toList()),
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
                            return Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
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
                                            borderRadius:
                                                const BorderRadius.all(
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
                                              checkStep() ? "Continue" : "Save",
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
                                          style: TextStyle(
                                              color: Color(0xFFEEFBFB)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                          },
                          onStepCancel: () => currentStep == 0
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
                          onStepContinue: () {
                            bool isLastStep =
                                (currentStep == getSteps().length - 1);

                            if (isLastStep) {
                              List<File> listImages = [];
                              final images = galleryController
                                  .images; // return Iterable<ImageFile>
                              for (final image in images) {
                                if (image.hasPath) {
                                  listImages.add(File(image.path!));
                                } else {
                                  listImages
                                      .add(File.fromRawPath(image.bytes!));
                                }
                              }
                              List<File> files = [];
                              for (int i = 0; i < listImages.length; i++) {
                                imagesGallery.add(base64Encode(
                                    listImages[i].readAsBytesSync()));
                              }
                              //Edit event duhet me qu edhe files ne backend e tani me i kshyr nese ka te ngjajshme
                              //me i fshi edhe nfund me testu

                              //Do something with this information.
                              if (checkFirstStep()) {
                                print("CREATED");
                                Provider.of<EventProvider>(context,
                                        listen: false)
                                    .updateEvent(
                                        widget.event.id,
                                        titleController.text,
                                        descriptionController.text,
                                        locationController.text,
                                        _image != null
                                            ? base64Encode(
                                                _image!.readAsBytesSync())
                                            : widget.event.coverImage,
                                        imagesGallery,
                                        guestController.text,
                                        startTimeController.text,
                                        durationController.text,
                                        idCategory.toString());
                                Future.delayed(Duration(seconds: 1), () {
                                  deactivate();
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                    return HomeScreen();
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
                              setState(() {
                                currentStep += 1;
                              });
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
    return titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        startTimeController.text.isNotEmpty &&
        durationController.text.isNotEmpty &&
        guestController.text.isNotEmpty &&
        idCategory != 0;
  }
}

Widget TextForm(BuildContext context, TextEditingController controller,
    String hint, bool flag) {
  return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Form(
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
          errorText: controller.text.isEmpty
              ? "Please enter your " + hint.toLowerCase()
              : null,
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
