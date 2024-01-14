class UserInitials {
  static String getUserInitials(
      {required String firstName, required String lastName}) {
    String fInitial = firstName.substring(0, 1).toUpperCase();
    String lInitial = lastName.substring(0, 1).toUpperCase();

    return "$fInitial$lInitial";
  }
}
