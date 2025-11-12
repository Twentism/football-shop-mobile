import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _thumbnailController = TextEditingController();

  String? _category;
  bool _isFeatured = false;

  final List<String> _categories = [
    'Balls',
    'Shoes',
    'Jersey',
    'Armband',
    'Others',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _thumbnailController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      // Prepare display text
      final name = _nameController.text.trim();
      final price = double.parse(_priceController.text.trim());
      final description = _descriptionController.text.trim();
      final thumbnail = _thumbnailController.text.trim();
      final category = _category ?? '';
      final featured = _isFeatured ? 'Yes' : 'No';

      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Product Saved'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Name: $name'),
                Text(
                  'Price: Rp${(price.toInt()).toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}',
                ),
                Text('Description: $description'),
                if (thumbnail.isNotEmpty) Text('Thumbnail: $thumbnail'),
                Text('Category: $category'),
                Text('Featured: $featured'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  String? _validateNotEmpty(String? v, String fieldName) {
    if (v == null || v.trim().isEmpty) return '$fieldName cannot be empty';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (v) {
                    final empty = _validateNotEmpty(v, 'Name');
                    if (empty != null) return empty;
                    if (v!.trim().length < 3)
                      return 'Name must be at least 3 characters';
                    if (v.trim().length > 50)
                      return 'Name must be at most 50 characters';
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    prefixText: 'Rp ',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (v) {
                    final empty = _validateNotEmpty(v, 'Price');
                    if (empty != null) return empty;
                    final parsed = double.tryParse(v!.trim());
                    if (parsed == null) return 'Price must be a number';
                    if (parsed < 0) return 'Price cannot be negative';
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  minLines: 3,
                  maxLines: 6,
                  validator: (v) {
                    final empty = _validateNotEmpty(v, 'Description');
                    if (empty != null) return empty;
                    if (v!.trim().length < 10)
                      return 'Description must be at least 10 characters';
                    if (v.trim().length > 500)
                      return 'Description must be at most 500 characters';
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: _thumbnailController,
                  decoration: const InputDecoration(
                    labelText: 'Thumbnail URL (Optional)',
                  ),
                  keyboardType: TextInputType.url,
                  validator: (v) {
                    // Thumbnail is optional, only validate if provided
                    if (v == null || v.trim().isEmpty) return null;
                    final uri = Uri.tryParse(v.trim());
                    if (uri == null ||
                        !(uri.isAbsolute &&
                            (uri.scheme == 'http' || uri.scheme == 'https'))) {
                      return 'Enter a valid http/https URL';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  initialValue: _category,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: _categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) => setState(() => _category = v),
                  validator: (v) => v == null || v.isEmpty
                      ? 'Category cannot be empty'
                      : null,
                ),

                const SizedBox(height: 12),

                CheckboxListTile(
                  title: const Text('Is Featured'),
                  value: _isFeatured,
                  onChanged: (v) => setState(() => _isFeatured = v ?? false),
                ),

                const SizedBox(height: 20),

                ElevatedButton(onPressed: _save, child: const Text('Save')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
