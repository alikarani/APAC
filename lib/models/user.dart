class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String email;
  final String password;
  final String f_name;
  final String l_name;
  final String ph;
  final String atype;
  final String cnic;
  final String card_no;
  final int user_rating;
  final bool account_state;

  UserData({
    this.uid,
    this.email,
    this.password,
    this.f_name,
    this.l_name,
    this.ph,
    this.atype,
    this.cnic,
    this.card_no,
    this.user_rating,
    this.account_state,
  });
}
