import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'home_screen.dart';

class ResultScreen extends StatefulWidget {
  final String ocrText;

  const ResultScreen({super.key, required this.ocrText});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late FlutterTts flutterTts;
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    initTts();
  }

  @override
  void dispose() {
    _disposed = true;
    flutterTts.stop();
    super.dispose();
  }

  Future<void> initTts() async {
    flutterTts = FlutterTts();

    // Opsional: tunggu sampai selesai tiap segmen
    await flutterTts.awaitSpeakCompletion(true);

    // Listener error (opsional, membantu debug)
    flutterTts.setErrorHandler((msg) {
      debugPrint('TTS Error: $msg');
    });

    // Konfigurasi suara
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);

    // Pastikan bahasa Indonesia tersedia, jika tidak fallback ke default engine language
    await _ensureIndonesianLanguage();
  }

  Future<void> _ensureIndonesianLanguage() async {
    try {
      final langs = await flutterTts.getLanguages;
      final List<dynamic> list = langs is List ? langs : <dynamic>[];
      // Cari variasi bahasa Indonesia yang umum
      final candidate = list.cast<String?>().firstWhere(
        (l) => l != null && (l.toLowerCase() == 'id-id' || l.toLowerCase() == 'id_id' || l.toLowerCase().startsWith('id')),
        orElse: () => null,
      );
      if (candidate != null) {
        await flutterTts.setLanguage(candidate);
      } else {
        // Tetap coba 'id-ID', jika gagal engine akan gunakan default language
        await flutterTts.setLanguage('id-ID');
      }
    } catch (e) {
      // Abaikan jika tidak didukung, engine akan pakai default
      await flutterTts.setLanguage('id-ID');
    }
  }

  Future<void> _speakText() async {
    final textToSpeak = widget.ocrText.trim();
    if (textToSpeak.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak ada teks untuk dibacakan.')),
        );
      }
      return;
    }

    // Hentikan pembacaan sebelumnya agar tidak tumpang tindih
    await flutterTts.stop();

    try {
      // Beberapa engine memiliki batas panjang teks, pecah menjadi potongan kecil
      const maxLen = 3800; // sedikit di bawah batas umum 4000
      final chunks = _chunkText(textToSpeak, maxLen);

      for (final part in chunks) {
        if (_disposed) break;
        // speak tiap bagian dan tunggu selesai sebelum lanjut
        await flutterTts.speak(part);
        // res bisa berupa int/string tergantung platform, tunggu completion handler
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal membacakan teks: $e')),
      );
    }
  }

  List<String> _chunkText(String text, int maxLen) {
    if (text.length <= maxLen) return [text];
    final parts = <String>[];
    int start = 0;
    while (start < text.length) {
      int end = (start + maxLen < text.length) ? start + maxLen : text.length;
      // Coba putus di akhir kalimat/kalimat baru agar natural
      final period = text.lastIndexOf('.', end);
      final newline = text.lastIndexOf('\n', end);
      final space = text.lastIndexOf(' ', end);
      int cut = [period, newline, space].where((i) => i >= start).fold<int>(-1, (prev, i) => i > prev ? i : prev);
      if (cut == -1 || cut <= start + maxLen ~/ 2) {
        cut = end;
      }
      parts.add(text.substring(start, cut).trim());
      start = cut;
    }
    return parts.where((p) => p.isNotEmpty).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil OCR'),
        actions: [
          IconButton(
            onPressed: _speakText,
            icon: const Icon(Icons.volume_up),
            tooltip: 'Bacakan Teks',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SelectableText(
            widget.ocrText.isEmpty
                ? 'Tidak ada teks ditemukan.'
                : widget.ocrText,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "tts_button",
            onPressed: _speakText,
            backgroundColor: Colors.blue,
            child: const Icon(Icons.volume_up),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: "home_button",
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (route) => false,
              );
            },
            child: const Icon(Icons.home),
          ),
        ],
      ),
    );
  }
}
