import 'package:flutter/material.dart';
import 'package:mus3if/data/dummy_data.dart';
import 'package:mus3if/model/emergancy_contact.dart';
import 'package:mus3if/local_storage/contact_storage.dart';
import 'package:mus3if/widgets/contact_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'add_contact_screen.dart';
import 'contact_detail_screen.dart';

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  State<EmergencyContactsScreen> createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _callNumber(String phone) async {
    if (phone == "N/A" || phone.isEmpty) return;

    String cleanedPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');
    final Uri url = Uri(scheme: "tel", path: cleanedPhone);

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        _showErrorSnackbar('Cannot make call to $cleanedPhone');
      }
    } catch (e) {
      _showErrorSnackbar('Error making call: $e');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFDC2626),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _deleteContact(EmergencyContact contact) async {
    try {
      contacts.removeWhere(
        (c) => c.name == contact.name && c.phoneNumber == contact.phoneNumber,
      );

      await ContactStorage.saveContacts(contacts);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${contact.name} deleted successfully!"),
            backgroundColor: const Color(0xFF16A34A),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'UNDO',
              textColor: Colors.white,
              onPressed: () async {
                contacts.add(contact);
                await ContactStorage.saveContacts(contacts);
                setState(() {});
              },
            ),
          ),
        );

        setState(() {});
      }
    } catch (e) {
      if (mounted) {
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

  List<EmergencyContact> _getContactsByType(String type) {
    return contacts.where((c) => c.type == type).toList();
  }

  void _refreshContacts() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Contacts"),
        backgroundColor: const Color(0xFFDC2626),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          tabs: const [
            Tab(text: "Personal"),
            Tab(text: "Doctors"),
            Tab(text: "Hospitals"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildContactsList('personal'),
          _buildContactsList('doctor'),
          _buildContactsList('hospital'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(context),
        backgroundColor: const Color(0xFFDC2626),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildContactsList(String type) {
    final contactsList = _getContactsByType(type);

    if (contactsList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIconForType(type),
              size: 64,
              color: const Color(0xFF64748B).withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              "No ${type == 'personal' ? 'contacts' : '${type}s'} added yet",
              style: const TextStyle(fontSize: 16, color: Color(0xFF64748B)),
            ),
            const SizedBox(height: 8),
            Text(
              "Tap the + button to add a contact",
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF64748B).withOpacity(0.6),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: contactsList.length,
      itemBuilder: (context, index) {
        final contact = contactsList[index];
        return ContactCard(
          contact: contact,
          onTap: () async {
            final deleted = await Navigator.push<bool>(
              context,
              MaterialPageRoute(
                builder: (context) => ContactDetailScreen(contact: contact),
              ),
            );

            if (deleted == true) {
              _refreshContacts();
            }
          },
          onCall: () => _callNumber(contact.phoneNumber),
          onDelete: () => _deleteContact(contact),
        );
      },
    );
  }

  void _showAddContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Contact"),
          content: const Text("Choose how you want to add a contact:"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddContactScreen(onContactAdded: _refreshContacts),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                foregroundColor: Colors.white,
              ),
              child: const Text("Add New Contact"),
            ),
          ],
        );
      },
    );
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
}
