import 'package:get/get.dart';

class SignUpController extends GetxController {
// Contoh variabel buat nyimpen form value
var name = ''.obs;
var email = ''.obs;
var password = ''.obs;

// Misal validasi basic doang
bool get isFormValid => name.isNotEmpty && email.isNotEmpty && password.isNotEmpty;

void onSignUpPressed() {
if (!isFormValid) {
Get.snackbar("Oops", "Lengkapi semua field dulu ya!");
return;
}
// Simulasi signup sukses
print("Nama: $name, Email: $email, Password: $password");

// Navigate ke home (ganti '/home' sesuai route kamu)
Get.offAllNamed('/home');
}

void onNameChanged(String value) {
  name.value = value;
}

void onEmailChanged(String value) {
  email.value = value;
}

void onPasswordChanged(String value) {
  password.value = value;
}

}