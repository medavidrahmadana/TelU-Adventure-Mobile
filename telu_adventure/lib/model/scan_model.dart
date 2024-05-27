class scan_model {
  final String uid;
  final String isi;
  final String jawab;

  scan_model({
    required this.uid,
    required this.isi,
    required this.jawab,
  });

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'isi': isi,
        'jawab': jawab,
      };
}
