  import 'dart:async';
  import 'dart:io';
  import 'dart:convert';
  import 'package:image/image.dart' as ImageProcess;
  //import 'package:PayFace/component/pin.dart';
  import 'package:camera/camera.dart';
  import 'package:flutter/material.dart';
  import 'package:fluttertoast/fluttertoast.dart';
  import 'package:path_provider/path_provider.dart';
  import 'package:PayFace/bloc/kamera_profil/KameraProfil_bloc.dart';
  import 'package:PayFace/bloc/kamera_profil/KameraProfil_state.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:PayFace/model/facesoft.dart';
	import 'package:shared_preferences/shared_preferences.dart';

  class KameraPage extends StatefulWidget {
    static String tag = 'kamera-page';
    @override
    _KameraPageState createState() => new _KameraPageState();
  }

  

  class _KameraPageState extends State {
    KameraProfilBloc kameraProfilBloc;
    CameraController controller;
    List cameras;
    int selectedCameraIdx;
    String imagePath;
    final GlobalKey _scaffoldKey = GlobalKey();
    String image1;
    var pref;
    String tagID;
    
    loadSharedPref() async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String tag = prefs.getString('tagID');
        if (tag == null ){
          getTags();
        }else{
          print(tag);
        }
        setState(() {
          tagID = tag;
        });
      } catch (Exception) {

      }
    }
  
    @override
    void initState() {
      super.initState();
      loadSharedPref();
       
      // Get the list of available cameras.
      // Then set the first camera as selected.
      availableCameras().then((availableCameras) {
        cameras = availableCameras;
        if (cameras.length > 0) {
          setState(() {
            selectedCameraIdx = 0;
          });
          _onCameraSwitched(cameras[selectedCameraIdx]).then((void v) {});
        }
      }).catchError((err) {
        print('Error: $err.code\nError Message: $err.message');
      });
    }
    @override
    Widget build(BuildContext context) {
    
      kameraProfilBloc = BlocProvider.of<KameraProfilBloc>(context);
      return BlocBuilder<KameraProfilBloc, KameraProfilState>(
        bloc: kameraProfilBloc,
        builder: (context, state){

        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('Scan Wajah'),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _cameraTogglesRowWidget(),
                  SizedBox(width: 10,),
                  _captureControlRowWidget(),
                  SizedBox(width: 10,),
                  _thumbnailWidget(), 
                ],
              ),
            ], 
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                      child: _cameraPreviewWidget(),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.grey,
                      width: 3.0,
                    ),
                  ),
                ),
              ),
              
              /*Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _cameraTogglesRowWidget(),
                    _captureControlRowWidget(),
                    _thumbnailWidget(), 
                  ],
                ),
              ),*/
              
              /*Padding(
                padding: EdgeInsets.all(5),
                child: Text("TagID: " + (tagID ?? ""))
              )*/
            ],
          ),
        );
        });
    }

    /// Display 'Loading' text when the camera is still loading.
    Widget _cameraPreviewWidget() {
      if (controller == null || !controller.value.isInitialized) {
        return const Text(
          'Loading',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
          ),
        );
      }
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }

    /// Display the thumbnail of the captured image
    Widget _thumbnailWidget() {
      return Align(
        child: imagePath == null ? SizedBox() : SizedBox(
            child: Image.file(File(imagePath)),
            width: 64.0,
            height: 64.0,
          ),
      );
    }

    /// Display the control bar with buttons to take pictures
    Widget _captureControlRowWidget() {
      return FloatingActionButton(
          onPressed: controller != null &&
                    controller.value.isInitialized ? _onCapturePressed : null,
          backgroundColor: Colors.orange,
          child: const Icon(Icons.camera_alt),
      );
      /*Expanded(
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                icon: const Icon(Icons.camera_alt),
                color: Colors.blue,
                onPressed: controller != null &&
                    controller.value.isInitialized ? _onCapturePressed : null,
              )
            ],
          ),
        ),
      );*/
    }

    /// Display a row of toggle to select the camera (or a message if no camera is available).
    Widget _cameraTogglesRowWidget() {
      if (cameras == null) {
        return Row();
      }
      CameraDescription selectedCamera = cameras[selectedCameraIdx];
      CameraLensDirection lensDirection = selectedCamera.lensDirection;
      return FloatingActionButton(
          onPressed: _onSwitchCamera,
          //label: Text("${lensDirection.toString().substring(lensDirection.toString().indexOf('.')+1)}"),
          child: Icon(_getCameraLensIcon(lensDirection)),
          backgroundColor: Colors.orange,
      );  
      /*Expanded(
        child: Align(
          alignment: Alignment.centerLeft,
          child: FlatButton.icon(
              onPressed: _onSwitchCamera,
              icon: Icon(
                  _getCameraLensIcon(lensDirection)
              ),
              label: Text("${lensDirection.toString().substring(lensDirection.toString().indexOf('.')+1)}")
          ),
        ),
      );*/
    }

    IconData _getCameraLensIcon(CameraLensDirection direction) {
      switch (direction) {
        case CameraLensDirection.back:
          return Icons.camera_rear;
        case CameraLensDirection.front:
          return Icons.camera_front;
        case CameraLensDirection.external:
          return Icons.camera;
        default:
          return Icons.device_unknown;
      }
    }

    Future _onCameraSwitched(CameraDescription cameraDescription) async {
      if (controller != null) {
        await controller.dispose();
      }
      controller = CameraController(cameraDescription, ResolutionPreset.high);
      // If the controller is updated then update the UI.
      controller.addListener(() {
        if (mounted) {
          setState(() {});
        }
        if (controller.value.hasError) {
          Fluttertoast.showToast(
              msg: 'Camera error ${controller.value.errorDescription}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white
          );
        }
      });

      try {
        await controller.initialize();
      } on CameraException catch (e) {
        _showCameraException(e);
      }

      if (mounted) {
        setState(() {});
      }
    }

    void _onSwitchCamera() {
      selectedCameraIdx = selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1 : 0;
      CameraDescription selectedCamera = cameras[selectedCameraIdx];
      _onCameraSwitched(selectedCamera);
      setState(() {
        selectedCameraIdx = selectedCameraIdx;
      });
    }
	
    Future _takePicture() async {
      if (!controller.value.isInitialized) {
        Fluttertoast.showToast(
            msg: 'Tunggu Sebentar',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white
        );
        return null;
      }

      // Do nothing if a capture is on progress
      if (controller.value.isTakingPicture) {
        return null;
      }
      final Directory appDirectory = await getApplicationDocumentsDirectory();
      final String pictureDirectory = '${appDirectory.path}/.PayFace';
      await Directory(pictureDirectory).create(recursive: true);
      //final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
      final String filePath = '$pictureDirectory/ScanWajah.jpg';
      File checkImage = new File('$pictureDirectory/ScanWajah.jpg');

      if(await checkImage.exists()){
          checkImage.delete();
      }
      try {
        await controller.takePicture(filePath);
        var pref = await SharedPreferences.getInstance();
        final _imageConvert = ImageProcess.decodeImage(checkImage.readAsBytesSync(),);
      
        String base64Image = base64Encode(ImageProcess.encodeJpg(_imageConvert));
        
        image1 = base64Image;
        pref.setString('image1', image1);
        //print(image1);
        
      } on CameraException catch (e) {
        _showCameraException(e);
          
          return null;
      }
      return filePath;
    


    }

    void _onCapturePressed() async {
      
      _takePicture().then((filePath) {
        if (mounted) {
          uploadGambar();
          setState(() {
            imagePath = filePath;
          });
          if (filePath != null) {
            //Fluttertoast.showToast(
              //  msg: '',
                //toastLength: Toast.LENGTH_SHORT,
                //gravity: ToastGravity.CENTER,
                //timeInSecForIos: 1,
                //backgroundColor: Colors.grey,
              //  textColor: Colors.white
            //);
          }
        }
      });
      
      //Navigator.of(context).pushNamed(PinPage.tag);
    }

    void _showCameraException(CameraException e) {
      String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
      print(errorText);
      Fluttertoast.showToast(
          msg: 'Error: ${e.code}\n${e.description}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white
      );
    }

}