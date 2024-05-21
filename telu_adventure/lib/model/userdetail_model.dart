class udetail_model {
  final String uid;
  final String gedungk;
  final String gedungnk;
  final String kantin;

  udetail_model({
    required this.uid,
    required this.gedungk,
    required this.gedungnk,
    required this.kantin,
  });

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'gedungk': gedungk,
        'gedungnk': gedungnk,
        'kantin': kantin,
      };
}
