class PromotionService {

  Future<void> _uploadForm() async {
    if (_formKey.currentState!.validate()) {
      final uri = Uri.parse('https://your-backend-url.com/api/upload'); // Replace with your backend URL

      var request = http.MultipartRequest('POST', uri)
        ..fields['title'] = _titleController.text
        ..fields['description'] = _descriptionController.text
        ..fields['contentHtml'] = _contentHtmlController.text
        ..fields['contentMarkdown'] = _contentMarkdownController.text
        ..fields['startDate'] = _startDate?.toIso8601String() ?? ''
        ..fields['endDate'] = _endDate?.toIso8601String() ?? '';

      if (_bannerImage != null) {
        final mimeTypeData = lookupMimeType(_bannerImage!.path, headerBytes: [0xFF, 0xD8])?.split('/');
        final imageUploadRequest = await http.MultipartFile.fromPath(
          'banner',
          _bannerImage!.path,
          contentType: MediaType(mimeTypeData![0], mimeTypeData[1]),
        );
        request.files.add(imageUploadRequest);
      }

      try {
        final response = await request.send();
        if (response.statusCode == 200) {
          print('Form uploaded successfully');
        } else {
          print('Failed to upload form');
        }
      } catch (e) {
        print('Error uploading form: $e');
      }
    }
  }
}