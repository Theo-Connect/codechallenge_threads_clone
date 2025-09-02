import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  // 카메라 관련 상태 변수들
  CameraController? _cameraController;
  bool _hasPermission = false;
  bool _isFlashOn = false;
  bool _isFrontCamera = false;
  List<CameraDescription> _cameras = [];

  @override
  void initState() {
    super.initState();
    // 앱 생명주기 관찰자 등록
    WidgetsBinding.instance.addObserver(this);
    // 카메라 권한 요청 및 초기화
    _initializeCamera();
  }

  @override
  void dispose() {
    // 리소스 정리
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 앱이 백그라운드로 갔다가 돌아올 때 카메라 재초기화
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  // 카메라 권한 요청 및 초기화
  Future<void> _initializeCamera() async {
    // 카메라 권한 요청
    final permission = await Permission.camera.request();
    if (permission.isGranted) {
      _hasPermission = true;
      await _setupCamera();
    } else {
      setState(() {
        _hasPermission = false;
      });
    }
  }

  // 카메라 설정 및 컨트롤러 초기화
  Future<void> _setupCamera() async {
    try {
      // 사용 가능한 카메라 목록 가져오기
      _cameras = await availableCameras();
      if (_cameras.isEmpty) return;

      // 카메라 컨트롤러 생성 (전면/후면 카메라 선택)
      _cameraController = CameraController(
        _cameras[_isFrontCamera ? 1 : 0],
        ResolutionPreset.high,
      );

      // 카메라 초기화
      await _cameraController!.initialize();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      // 카메라 초기화 실패 시 에러 처리
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Camera initialization failed')),
        );
      }
    }
  }

  // 사진 촬영 기능
  Future<void> _takePicture() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      // 사진 촬영
      final XFile picture = await _cameraController!.takePicture();
      if (mounted) {
        // 촬영된 사진 경로를 반환하며 화면 닫기
        Navigator.pop(context, picture.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to take picture')),
        );
      }
    }
  }

  // 플래시 토글 기능
  Future<void> _toggleFlash() async {
    if (_cameraController == null) return;

    try {
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
      // 플래시 모드 설정
      await _cameraController!.setFlashMode(
        _isFlashOn ? FlashMode.torch : FlashMode.off,
      );
    } catch (e) {
      // 플래시 설정 실패 시 상태 되돌리기
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
    }
  }

  // 전면/후면 카메라 전환
  Future<void> _switchCamera() async {
    if (_cameras.length < 2) return;

    setState(() {
      _isFrontCamera = !_isFrontCamera;
    });
    // 카메라 재설정
    await _cameraController?.dispose();
    await _setupCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 카메라 프리뷰 또는 권한 요청 화면
          if (!_hasPermission)
            // 권한이 없을 때 표시되는 화면
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 64,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Camera permission required',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          else if (_cameraController != null &&
              _cameraController!.value.isInitialized)
            // 카메라 프리뷰 화면
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: CameraPreview(_cameraController!),
            )
          else
            // 카메라 로딩 중 화면
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),

          // 상단 뒤로가기 버튼
          Positioned(
            top: 50,
            left: 16,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          // 하단 컨트롤 버튼들
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 플래시 버튼
                IconButton(
                  onPressed: _toggleFlash,
                  icon: FaIcon(
                    FontAwesomeIcons.bolt,
                    color: _isFlashOn ? Colors.yellow : Colors.white,
                    size: 24,
                  ),
                ),
                // 촬영 버튼
                GestureDetector(
                  onTap: _takePicture,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                // 카메라 전환 버튼
                IconButton(
                  onPressed: _switchCamera,
                  icon: const FaIcon(
                    FontAwesomeIcons.arrowsRotate,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          // 하단 Camera/Library 탭
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Camera',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Library 탭 - 갤러리에서 이미지 선택
                GestureDetector(
                  onTap: () async {
                    try {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (image != null && mounted) {
                        Navigator.pop(context, image.path);
                      }
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to access photo library'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Library',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}