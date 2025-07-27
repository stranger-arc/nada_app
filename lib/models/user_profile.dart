// lib/models/user_profile.dart

class UserProfile {
  final String uniqueId; // Changed from userId to uniqueId
  final String name;     // Added 'name' directly
  final String gender;
  final String dob;
  final String primaryMobileNo; // Changed from mobile
  final String? secondaryMobileNo; // Made nullable based on common API patterns
  final String address;
  final String? permanentAddress; // Made nullable
  final String state;
  final String city;
  final String? country; // Not in API response, making nullable
  final String? pincode; // Not in API response, making nullable
  final String? profilePic; // Not in API response, making nullable
  final String designation; // Changed from status

  // Fields that were in original profile model but NOT in this API response:
  final String? email; // Not in this API response, making nullable
  final String? firstName; // Derived from 'name' or not directly available
  final String? lastName; // Derived from 'name' or not directly available


  UserProfile({
    required this.uniqueId,
    required this.name,
    required this.gender,
    required this.dob,
    required this.primaryMobileNo,
    this.secondaryMobileNo, // Now optional
    required this.address,
    this.permanentAddress, // Now optional
    required this.state,
    required this.city,
    this.country,      // Now optional
    this.pincode,      // Now optional
    this.profilePic,   // Now optional
    required this.designation, // Changed from status
    this.email,        // Now optional
    this.firstName,    // Now optional
    this.lastName,     // Now optional
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    // Access the nested 'user' map first
    final userJson = json['user'] as Map<String, dynamic>?;

    // Handle case where 'user' might be null (though API returns it)
    if (userJson == null) {
      // This should ideally not happen with your provided API response,
      // but is good for robustness.
      throw Exception('User data is missing from API response');
    }

    // Safely extract values using null-aware access and defaulting to ''
    // For nullable fields in the model, we use the direct null from JSON or provide null.
    return UserProfile(
      uniqueId: userJson['unique_id']?.toString() ?? '',
      name: userJson['name']?.toString() ?? '',
      gender: userJson['gender']?.toString() ?? '',
      dob: userJson['dob']?.toString() ?? '',
      primaryMobileNo: userJson['primary_mobile_no']?.toString() ?? '',
      secondaryMobileNo: userJson['secondary_mobile_no']?.toString(), // Can be null
      address: userJson['address']?.toString() ?? '',
      permanentAddress: userJson['permanent_address']?.toString(), // Can be null
      state: userJson['state']?.toString() ?? '',
      city: userJson['city']?.toString() ?? '',
      country: null, // Not present in this JSON, explicitly set to null
      pincode: null, // Not present in this JSON, explicitly set to null
      profilePic: null, // Not present in this JSON, explicitly set to null
      designation: userJson['designation']?.toString() ?? '', // Corresponds to 'EmployeeType'
      email: userJson['email']?.toString() ?? '', // Not present in this JSON, explicitly set to null
      firstName: null, // Not directly available as 'first_name'
      lastName: null, // Not directly available as 'last_name'
    );
  }
}