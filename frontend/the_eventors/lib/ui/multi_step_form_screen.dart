import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/models/ImageHelper.dart';
import 'package:the_eventors/providers/EventProvider.dart';
import 'package:the_eventors/ui/home_screen.dart';

import '../providers/CategoryProvider.dart';

class MultiStepFormPage extends StatefulWidget {
  const MultiStepFormPage({Key? key}) : super(key: key);

  @override
  State<MultiStepFormPage> createState() => _MultiStepFormPageState();
}

class _MultiStepFormPageState extends State<MultiStepFormPage> {
  int currentStep = 0;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController guestController = TextEditingController();
  final galleryController = MultiImagePickerController(
    maxImages: 10,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );
  final coverController = MultiImagePickerController(
    maxImages: 1,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );
  late String category = "";
  late int idCategory = 0;
  late List categories = [];
  final imageHelper = ImageHelper();
  File? _image;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      Provider.of<CategoryProvider>(context, listen: false).getCategories();
    });
    categories =
        Provider.of<CategoryProvider>(context, listen: false).categories;
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Details"),
        content: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Info details',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextForm(context, titleController, "Title", false),
            TextForm(context, descriptionController, "Description", true),
            TextForm(context, locationController, "Location", false),
            DropdownButtonFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                hintText: "Select category",
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
              items: categories.map((e) {
                return DropdownMenuItem(
                  child: Text(e.name),
                  value: e,
                  onTap: () {
                    setState(() {
                      idCategory = e.id;
                    });
                  },
                );
              }).toList(),
              onChanged: (value) {
                /*print(value!.name);
                setState(() {
                  category = value!.name;
                });*/
              },
              isExpanded: false,
              iconSize: 24.0,
              hint: category != ""
                  ? Text(category)
                  : const Text('Select category'),
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Time"),
        content: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Event times',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextForm(context, startTimeController, "Start time", false),
            TextForm(context, durationController, "Duration", false)
          ],
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("More details"),
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
                ),
              ),
            ),
            TextForm(context, guestController, "Guest", false),
            Container(
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
                    final files = await imageHelper.pickImage();
                    setState(() {
                      _image = File(files.first.path);
                    });
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
            )
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
            body: Container(
                padding: const EdgeInsets.all(15),
                child: Stepper(
                  elevation: 0.0,
                  type: StepperType.vertical,
                  currentStep: currentStep,
                  onStepCancel: () => currentStep == 0
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomeScreen()))
                      : setState(() {
                          currentStep -= 1;
                        }),
                  onStepContinue: () {
                    bool isLastStep = (currentStep == getSteps().length - 1);
                    if (isLastStep) {
                      List<File> listImages = [];
                      final images = galleryController
                          .images; // return Iterable<ImageFile>
                      for (final image in images) {
                        if (image.hasPath) {
                          listImages.add(File(image.path!));
                        } else {
                          listImages.add(File.fromRawPath(image.bytes!));
                        }
                      }
                      //Do something with this information.
                      Provider.of<EventProvider>(context, listen: false)
                          .addEvent(
                              titleController.text,
                              descriptionController.text,
                              locationController.text,
                              _image!,
                              listImages,
                              guestController.text,
                              startTimeController.text,
                              durationController.text,
                              idCategory.toString());
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
                )),
          ),
        ));
  }
}

Widget TextForm(BuildContext context, TextEditingController controller,
    String hint, bool flag) {
  return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: TextField(
        clipBehavior: Clip.hardEdge,
        focusNode: FocusNode(),
        minLines: 1,
        maxLines: flag ? 10 : 1,
        keyboardType: flag ? TextInputType.multiline : TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: hint,
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
      ));
}
