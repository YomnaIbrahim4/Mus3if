import 'package:flutter/material.dart';
import 'package:mus3if/data/dummy_data.dart';
import 'package:mus3if/screens/emergency_contacts_screen.dart';
import 'package:mus3if/widgets/medical_info_card.dart';
import '../screens/edit_profile_screen.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFFFEE2E2),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Color(0xFFDC2626),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    currentUser.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFFFEE2E2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Blood Type: ${currentUser.bloodType}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFDC2626),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            MedicalInfoCard(user: currentUser),
            SizedBox(height: 16),
            Card(
              margin: EdgeInsets.only(bottom: 16),
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmergencyContactsScreen(),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12.0),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.contacts, color: Color(0xFFDC2626), size: 24),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Emergency Contacts",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Manage your emergency contacts",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF64748B),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
                child: Text("Edit Profile"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
