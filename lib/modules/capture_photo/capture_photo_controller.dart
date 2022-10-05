import 'package:mobx/mobx.dart';
part 'capture_photo_controller.g.dart';

class CaptureCameraController = _CaptureCameraControllerBase
    with _$CaptureCameraController;

abstract class _CaptureCameraControllerBase with Store {}
