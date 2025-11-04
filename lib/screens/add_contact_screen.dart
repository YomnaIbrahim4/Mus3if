import 'package:flutter/material.dart';
import 'package:mus3if/data/dummy_data.dart';
import 'package:mus3if/models/emergancy_contact.dart';
import 'package:mus3if/local_storage/contact_storage.dart';
import 'package:mus3if/widgets/custom_text_field.dart';
import 'package:mus3if/widgets/custom_dropdown.dart';

class AddContactScreen extends StatefulWidget {
  final VoidCallback? onContactAdded;

  const AddContactScreen({super.key, this.onContactAdded});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _alternatePhoneController = TextEditingController();
  final _relationshipController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _locationController = TextEditingController();
  final _scheduleController = TextEditingController();

  String _selectedType = 'personal';
  bool _isSaving = false;

  final List<Map<String, dynamic>> _contactTypes = [
    {'value': 'personal', 'label': 'Personal Contact'},
    {'value': 'doctor', 'label': 'Doctor'},
    {'value': 'hospital', 'label': 'Hospital'},
  ];

  Future<void> _addContact() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSaving = true;
      });

      try {
        final newContact = EmergencyContact(
          name: _nameController.text.trim(),
          phoneNumber: _phoneController.text.trim(),
          alternatePhone: _alternatePhoneController.text.trim().isEmpty
              ? null
              : _alternatePhoneController.text.trim(),
          relationship: _relationshipController.text.trim().isEmpty
              ? null
              : _relationshipController.text.trim(),
          specialty: _specialtyController.text.trim().isEmpty
              ? null
              : _specialtyController.text.trim(),
          location: _locationController.text.trim().isEmpty
              ? null
              : _locationController.text.trim(),
          schedule: _scheduleController.text.trim().isEmpty
              ? null
              : _scheduleController.text.trim(),
          type: _selectedType,
        );

        contacts.add(newContact);
        await ContactStorage.saveContacts(contacts);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${newContact.name} added successfully!"),
              backgroundColor: Color(0xFF16A34A),
              duration: Duration(seconds: 2),
            ),
          );

          widget.onContactAdded?.call();
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error saving contact: $e"),
              backgroundColor: Color(0xFFDC2626),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSaving = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _alternatePhoneController.dispose();
    _relationshipController.dispose();
    _specialtyController.dispose();
    _locationController.dispose();
    _scheduleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Emergency Contact"),
        backgroundColor: Color(0xFFDC2626),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: _isSaving
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Icon(Icons.save),
            onPressed: _isSaving ? null : _addContact,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomDropdown(
                value: _selectedType,
                items: _contactTypes,
                label: "Contact Type",
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: _nameController,
                label: "Full Name *",
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: _phoneController,
                label: "Phone Number *",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: _alternatePhoneController,
                label: "Alternate Phone",
                icon: Icons.phone_iphone,
                keyboardType: TextInputType.phone,
              ),
              if (_selectedType == 'personal') ...[
                SizedBox(height: 16),
                CustomTextField(
                  controller: _relationshipController,
                  label: "Relationship",
                  icon: Icons.group,
                ),
              ],
              if (_selectedType == 'doctor' || _selectedType == 'hospital') ...[
                SizedBox(height: 16),
                CustomTextField(
                  controller: _specialtyController,
                  label: _selectedType == 'doctor'
                      ? "Specialty"
                      : "Hospital Type",
                  icon: Icons.medical_services,
                ),
              ],
              SizedBox(height: 16),
              CustomTextField(
                controller: _locationController,
                label: "Location/Address",
                icon: Icons.location_on,
                maxLines: 2,
              ),
              if (_selectedType == 'doctor') ...[
                SizedBox(height: 16),
                CustomTextField(
                  controller: _scheduleController,
                  label: "Schedule",
                  icon: Icons.schedule,
                ),
              ],
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _addContact,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFDC2626),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: _isSaving
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          "Add Contact",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
