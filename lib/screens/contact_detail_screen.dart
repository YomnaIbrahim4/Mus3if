import 'package:flutter/material.dart';
import 'package:mus3if/data/dummy_data.dart';
import 'package:mus3if/model/emergancy_contact.dart';
import 'package:mus3if/local_storage/contact_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetailScreen extends StatelessWidget {
  final EmergencyContact contact;

  const ContactDetailScreen({super.key, required this.contact});

  Future<void> _callNumber(String phone) async {
    if (phone == "N/A" || phone.isEmpty) return;

    String cleanedPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    final Uri url = Uri(scheme: "tel", path: cleanedPhone);

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _openUrl(String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _deleteContact(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Contact"),
          content: Text("Are you sure you want to delete ${contact.name}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                foregroundColor: Colors.white,
              ),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      try {
        contacts.removeWhere(
          (c) => c.name == contact.name && c.phoneNumber == contact.phoneNumber,
        );

        await ContactStorage.saveContacts(contacts);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${contact.name} deleted successfully!"),
              backgroundColor: const Color(0xFF16A34A),
              duration: const Duration(seconds: 2),
            ),
          );

          Navigator.of(context).pop(true);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error deleting contact: $e"),
              backgroundColor: const Color(0xFFDC2626),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Details"),
        backgroundColor: const Color(0xFFDC2626),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteContact(context),
            tooltip: "Delete Contact",
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: _getColorForType(contact.type).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getIconForType(contact.type),
                        color: _getColorForType(contact.type),
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contact.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (contact.specialty != null)
                            Text(
                              contact.specialty!,
                              style: TextStyle(
                                fontSize: 14,
                                color: _getColorForType(contact.type),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          if (contact.relationship != null)
                            Text(
                              contact.relationship!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF64748B),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            if (contact.phoneNumber != "N/A") ...[
              _buildPhoneSection("Primary Phone", contact.phoneNumber),
              const SizedBox(height: 16),
            ],

            if (contact.alternatePhone != null) ...[
              _buildPhoneSection("Alternate Phone", contact.alternatePhone!),
              const SizedBox(height: 16),
            ],

            if (contact.location != null) ...[
              _buildInfoSection(
                Icons.location_on,
                "Location",
                contact.location!,
              ),
              const SizedBox(height: 16),
            ],

            if (contact.schedule != null) ...[
              _buildInfoSection(Icons.schedule, "Schedule", contact.schedule!),
              const SizedBox(height: 16),
            ],

            if (contact.scheduleUrl != null) ...[
              _buildUrlSection("General Schedule", contact.scheduleUrl!),
              const SizedBox(height: 16),
            ],

            if (contact.studentScheduleUrl != null) ...[
              _buildUrlSection("Student Schedule", contact.studentScheduleUrl!),
              const SizedBox(height: 16),
            ],

            // SizedBox(
            //   width: double.infinity,
            //   child: OutlinedButton.icon(
            //     onPressed: () => _deleteContact(context),
            //     icon: const Icon(Icons.delete),
            //     label: const Text("Delete Contact"),
            //     style: OutlinedButton.styleFrom(
            //       foregroundColor: const Color(0xFFDC2626),
            //       side: const BorderSide(color: Color(0xFFDC2626)),
            //       padding: const EdgeInsets.symmetric(vertical: 16),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12.0),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneSection(String title, String phoneNumber) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              phoneNumber,
              style: const TextStyle(fontSize: 16, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _callNumber(phoneNumber),
                icon: const Icon(Icons.call, size: 20),
                label: const Text("Call"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16A34A),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(IconData icon, String title, String content) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 24, color: const Color(0xFFDC2626)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUrlSection(String title, String url) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _openUrl(url),
                icon: const Icon(Icons.open_in_new),
                label: const Text("View Schedule"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFDC2626),
                  side: const BorderSide(color: Color(0xFFDC2626)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _getColorForType(String type) {
  switch (type) {
    case 'doctor':
      return const Color(0xFF2563EB);
    case 'hospital':
      return const Color(0xFFDC2626);
    default:
      return const Color(0xFF16A34A);
  }
}

IconData _getIconForType(String type) {
  switch (type) {
    case 'doctor':
      return Icons.medical_services;
    case 'hospital':
      return Icons.local_hospital;
    default:
      return Icons.person;
  }
}
