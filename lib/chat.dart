import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'api.dart';
import 'package:chatkobi/widgets.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();
  bool _isLoading = false;
  final ImagePicker _imagePicker = ImagePicker();
  PickedFile? _image;
  late AnimationController _animationController;
  late Animation<Color?> _colorTween;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _colorTween = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(_animationController);
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _imagePicker.getImage(source: source);

    if (pickedFile != null) {
      print('Gambar berhasil diambil: ${pickedFile.path}');
      setState(() {
        _image = pickedFile;
      });

      if (source == ImageSource.gallery || source == ImageSource.camera) {
        print('Mengunggah gambar ke server...');
        await _uploadImageToServer(_image!.path);

        setState(() {
          _image = null;
        });

        final imageName = _image?.path.split('/').last ?? '';
        _textController.text = imageName;
        _textController.value = const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        );
      }
    }
  }

  void handleError() {
    ChatMessage errorMessage = const ChatMessage(
      text: 'Maaf, terjadi kesalahan.',
      isUserMessage: false,
    );

    setState(() {
      _messages.insert(0, errorMessage);
    });
  }

  Future<void> _uploadImageToServer(String imagePath) async {
    setState(() {
      _messages.insert(
        0,
        const ChatMessage(
          text: 'Mengirim gambar...',
          isUserMessage: true,
          isImageUploading: true,
        ),
      );
    });

    final response = await sendImageToServer(imagePath);

if (response.statusCode == 200) {
  final responseData = jsonDecode(response.body);
  final resultText = responseData['result'];

  setState(() {
    _messages.insert(
      0,
      ChatMessage(
        text: 'Hasil dari server: $resultText',
        isUserMessage: false,
      ),
    );
  });

      setState(() {
        _image = null;
      });
    } else {
      print('Gagal mengunggah gambar ke server: ${response.statusCode}');
      handleError();
    }
  }

  Future<void> _handleSubmitted(String text) async {
  if (_image != null) {
    await _uploadImageToServer(_image!.path).timeout(const Duration(seconds: 10), onTimeout: () {
      const chatErrorMessage = 'Maaf, tidak ada respon dari server.';
      
      setState(() {
        _messages.insert(0, const ChatMessage(
          text: chatErrorMessage,
          isUserMessage: false,
        ));
      });
    });
  } else if (text.isNotEmpty) {
    ChatMessage textMessage = ChatMessage(
      text: text,
      isUserMessage: true,
    );

    setState(() {
      _messages.insert(0, textMessage);
      _startLoading();
    });

    try {
      await _sendMessageToServer(text); 
    } catch (error) {
      final errorMessage = error.toString();
      final chatErrorMessage = 'Maaf, terjadi kesalahan: $errorMessage';
      
      setState(() {
        _messages.insert(0, ChatMessage(
          text: chatErrorMessage,
          isUserMessage: false,
        ));
      });
    }
  }
}

  Future<void> _sendMessageToServer(String userInput) async {
    final response = await sendMessageToServer(userInput);

    _stopLoading();

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final botResponse = data['result'];

      setState(() {
        _messages.insert(0, ChatMessage(text: botResponse, isUserMessage: false));
      });
    } else {
      handleError();
    }
  }

  void _startLoading() {
    setState(() {
      _isLoading = true;
    });
    _animationController.repeat();
  }

  void _stopLoading() {
    setState(() {
      _isLoading = false;
    });
    _animationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          buildTextComposer(
            _textController,
            _isLoading,
            _handleSubmitted,
            _getImage,
            _image,
          ),
          _isLoading
              ? AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return LinearProgressIndicator(
                      valueColor: _colorTween,
                      backgroundColor: Colors.grey[300],
                    );
                  },
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
