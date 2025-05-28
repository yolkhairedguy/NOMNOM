import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../../../widgets/custom_nav_bar.dart';

class ProfileView extends StatelessWidget {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildOption(Icons.edit, "Edit profile", _editProfilePopup),
            _buildOption(Icons.credit_card, "Payment methods", _paymentPopup),
            _buildOption(Icons.notifications, "Notification", _notifPopup),
            _buildOption(Icons.manage_accounts, "Manage account", _managePopup),
            const SizedBox(height: 16),
            _buildLogoutOption(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFC83D),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: const AssetImage('assets/images/avatar3.jpg'),
          ),
          const SizedBox(height: 16),
          Obx(() => Text(
            controller.name.value, 
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black87,
            )
          )),
          const SizedBox(height: 4),
          Obx(() => Text(
            controller.email.value,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
            )
          )),
        ],
      ),
    );
  }

  Widget _buildOption(IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(icon, color: Colors.black87),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLogoutOption() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red[200]!, width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: const Icon(Icons.logout, color: Colors.red),
        title: const Text(
          "Log out",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.red,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.red),
        onTap: _logoutPopup,
      ),
    );
  }

  void _editProfilePopup() {
    final nameController = TextEditingController(text: controller.name.value);
    final emailController = TextEditingController(text: controller.email.value);

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Edit Profile",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.edit,
                  size: 40,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.changeName(nameController.text);
                        controller.changeEmail(emailController.text);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC83D),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _paymentPopup() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Payment Methods",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              _radioOption("Cash"),
              _radioOption("Gopay"),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Add payment method logic
                  },
                  icon: const Icon(Icons.add, color: Colors.blue),
                  label: const Text(
                    "Add Payment",
                    style: TextStyle(color: Colors.blue),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: const BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("Close"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _radioOption(String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(() => RadioListTile(
        title: Text(value),
        value: value,
        groupValue: controller.selectedPaymentMethod.value,
        onChanged: (val) => controller.changePaymentMethod(val!),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      )),
    );
  }

  void _notifPopup() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Notification Settings",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Obx(() => SwitchListTile(
                  title: const Text("Reminder before break"),
                  value: controller.reminderNotif.value,
                  onChanged: controller.toggleReminderNotif,
                  contentPadding: EdgeInsets.zero,
                )),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Obx(() => SwitchListTile(
                  title: const Text("Notify when favorite merchant opens"),
                  value: controller.favoriteOpenNotif.value,
                  onChanged: controller.toggleFavoriteOpenNotif,
                  contentPadding: EdgeInsets.zero,
                )),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("Close"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _managePopup() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Manage Account",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Change password logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Change Password",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _confirmDelete,
                  child: const Text(
                    "Delete Account",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("Close"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete() {
    Get.back(); // close current
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.warning,
                  size: 40,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Delete Account",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Are you sure you want to delete your account? This action cannot be undone.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.deleteAccount,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logoutPopup() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.logout,
                  size: 40,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Log Out",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Are you sure you want to log out?",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Log Out",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}