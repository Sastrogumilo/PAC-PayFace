import 'dart:async';
import 'dart:io';
//import 'package:PayFace/pin.dart';
import 'package:PayFace/component/konfirmasi.dart';
import 'package:PayFace/repository/hasilCariUser.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:PayFace/bloc/kamera_bayar/kameraBayar_bloc.dart';
import 'package:PayFace/bloc/kamera_bayar/kameraBayar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PayFace/model/facesoft.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as ImageProcess;
import 'dart:convert';
import 'package:PayFace/bloc/konfirmasi/konfirmasi_bloc.dart';
import 'package:PayFace/bloc/auth/auth_bloc.dart';

  class KameraBayarPage extends StatefulWidget {
    static String tag = 'kameraBayar-page';
    @override
    _KameraBayarPageState createState() {
      return _KameraBayarPageState();
    }
  }
	
  
	
  class _KameraBayarPageState extends State {
    KameraBayarBloc kameraBayarBloc;
    CameraController controller;
    List cameras;
    int selectedCameraIdx;
    String imagePath;
    final GlobalKey _scaffoldKey = GlobalKey();

    String tagID;
    String imageRecog;

    loadSharedPref() async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String tag = prefs.getString('tagID');
        if(tag == null){
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
      availableCameras().then((availableCameras)
      {
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

    kameraBayarBloc = BlocProvider.of<KameraBayarBloc>(context);
    return BlocBuilder<KameraBayarBloc, KameraBayarState>(
      bloc: kameraBayarBloc,
      builder: (context, state){
	
      return Scaffold(
	
        key: _scaffoldKey,
	
        appBar: AppBar(
	
          title: const Text('Scan Wajah'),
	
        ),
	
        body: Column(
	
          children: [
	
            Expanded(
	
              child: Container(
	
                child: Padding(
	
                  padding: const EdgeInsets.all(1.0),
	
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
	
            Padding(
	
              padding: const EdgeInsets.all(5.0),
	
              child: Row(
	
                mainAxisAlignment: MainAxisAlignment.start,
	
                children: [
	
                  _cameraTogglesRowWidget(),
	
                  _captureControlRowWidget(),
	
                  _thumbnailWidget(),
                  

                ],
                
	
              ),
	
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("TagID: " + (tagID ?? "")),
            )
	
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
	
      return Expanded(
	
        child: Align(
	
          alignment: Alignment.centerRight,
	
          child: imagePath == null
	
            ? SizedBox()
	
            : SizedBox(
	
              child: Image.file(File(imagePath)),
	
              width: 64.0,
	
              height: 64.0,
	
            ),
	
        ),
	
      );
	
    }
	
  
	
    /// Display the control bar with buttons to take pictures
	
    Widget _captureControlRowWidget() {
	
      return Expanded(
	
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
	
                    controller.value.isInitialized
	
                    ? _onCapturePressed
	
                    : null,
	
              )
	
            ],
	
          ),
	
        ),
	
      );
	
    }
	
  
	
    /// Display a row of toggle to select the camera (or a message if no camera is available).
	
    Widget _cameraTogglesRowWidget() {
	
      if (cameras == null) {
	
        return Row();
	
      }
	
      CameraDescription selectedCamera = cameras[selectedCameraIdx];
	
      CameraLensDirection lensDirection = selectedCamera.lensDirection;
	
      return Expanded(
	
        child: Align(
	
          alignment: Alignment.centerLeft,
	
          child: FlatButton.icon(
	
              onPressed: _onSwitchCamera,
	
              icon: Icon(
	
                  _getCameraLensIcon(lensDirection)
	
              ),
	
              label: Text("${lensDirection.toString()
	
                  .substring(lensDirection.toString().indexOf('.')+1)}")
	
          ),
	
        ),
	
      );
	
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
	
      selectedCameraIdx = selectedCameraIdx < cameras.length - 1
	
          ? selectedCameraIdx + 1
	
          : 0;
	
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
	
      final String filePath = '$pictureDirectory/ScanWajahBayar.jpg';
      File checkImage = new File('$pictureDirectory/ScanWajahBayar.jpg');
     
      if(await checkImage.exists()){
          checkImage.delete();
        }

      try {
	
        await controller.takePicture(filePath);
        var pref = await SharedPreferences.getInstance();
        final _imageConvert = ImageProcess.decodeImage(checkImage.readAsBytesSync(),);
      
        String base64Image = base64Encode(ImageProcess.encodeJpg(_imageConvert));
        
        imageRecog = base64Image;
        pref.setString('imageRecog', imageRecog);
        //print(imageRecog);
	
      } on CameraException catch (e) {
	
        _showCameraException(e);
	
        return null;
	
      }
	
        return filePath;
	
    }
	
    void _onCapturePressed() {
	
      _takePicture().then((filePath) {
        
        if (mounted) {
          faceRecognition();
          print('Check Image ...');
          new Future.delayed(Duration(seconds: 5), ()=> hasilCariQuery());
          //hasilCariQuery();
          new Future.delayed(Duration(seconds: 8), ()=> checkWajah());
          
          //_loadKonfirmasiPage();
          setState(() {
	
            imagePath = filePath;
	
          });
	
          if (filePath != null) {
	
            //Fluttertoast.showToast(
	
              //  msg: 'Gambar Disimpan',
	
                //toastLength: Toast.LENGTH_SHORT,
	
                //gravity: ToastGravity.CENTER,
	
                //timeInSecForIos: 1,
	
                //backgroundColor: Colors.grey,
	
                //textColor: Colors.white
	
            //);
	
          }
	
        }
       
	
      });
    //Navigator.of(context).pushNamed(null); //diisis
    
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


     void _loadKonfirmasiPage() {
      Navigator.push(context, 
        MaterialPageRoute(builder: (context){
        return BlocProvider<KonfirmasiBloc>(
          builder: (context) {
            return KonfirmasiBloc(authBloc: BlocProvider.of<AuthBloc>(context),
            userRepo: kameraBayarBloc.userRepo,
            );
          },
          child: KonfirmasiPage(),

        );
      }
      )
      );
    }

    void checkWajah() async {
      int valueRecog;
      final pref = await SharedPreferences.getInstance();
      valueRecog = pref.getInt('valueRecog');
      print("Value = "+"$valueRecog");
      
          if(valueRecog == 0){
            //ERROR
            Fluttertoast.showToast(
	              msg: 'Wajah Tidak Dikenal !, Tunggu Beberapa Saat dan Silahkan Coba Lagi ...',
	              toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white
            );
                pref.remove('valueRecog');
                pref.remove('tagHasil');

                pref.reload();

                print(pref.getInt('valueRecog'));
                print(pref.getInt('tagHasil'));
                //print(pref.getString('objectIdPenerima'));
                  
                  //print("value = "+pref.getString('valueRecog'));

          }else {
          Fluttertoast.showToast(
	              msg: 'User Terdeteksi !, Silahkan Tunggu ...',
	              toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white
            );
          new Future.delayed(const Duration(seconds: 3), ()=> _loadKonfirmasiPage());
          pref.remove('valueRecog');
          pref.remove('tagHasil');

          pref.remove('objectIdPenerima');
          pref.remove('alamatPenerima');
          pref.remove('namaLengkapPenerima');
          pref.remove('emailPenerima');
          pref.remove('usernamePenerima');
          pref.remove('notelpPenerima');

          pref.remove('userRekIdPenerima');
          pref.remove('noRekUserPenerima');
          pref.remove('saldoPenerima');

          pref.reload();
          pref.reload();

          print(pref.getInt('valueRecog'));
          print(pref.getString('tagHasil'));
          print(pref.getString('objectIdPenerima'));
          pref.reload();
          }

    }

  }
   