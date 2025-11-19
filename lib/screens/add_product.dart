import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'menu.dart';

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

  // Local display-only save helper removed in favor of server-backed submission

  String? _validateNotEmpty(String? v, String fieldName) {
    if (v == null || v.trim().isEmpty) return '$fieldName cannot be empty';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

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

                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      // TODO: Replace the URL with your app's URL and don't forget the trailing slash (/).
                      // For Android emulator use: http://10.0.2.2/
                      // For web/chrome use: http://localhost:8000/

                      final name = _nameController.text.trim();
                      final price = int.parse(_priceController.text.trim());
                      final description = _descriptionController.text.trim();
                      final thumbnail = _thumbnailController.text.trim();
                      final category = _category ?? '';

                      final response = await request.postJson(
                        'http://localhost:8000/create-product-flutter/',
                        jsonEncode({
                          'name': name,
                          'price': price,
                          'description': description,
                          'thumbnail': thumbnail,
                          'category': category,
                          'is_featured': _isFeatured,
                        }),
                      );

                      if (!context.mounted) return;

                      if (response != null && response['status'] == 'success') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Product successfully saved!'),
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Something went wrong, please try again.',
                            ),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
