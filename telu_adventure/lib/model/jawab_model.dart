class jawab_model {
  final String idpertanyaan;
  final String jawaban;
  final String userid;
  final String nama;
  final String urlimg;
  final String waktu;

  jawab_model({
    required this.idpertanyaan,
    required this.jawaban,
    required this.userid,
    required this.nama,
    required this.urlimg,
    required this.waktu,
  });

  Map<String, dynamic> toMap() => {
        'id': idpertanyaan,
        'jawaban': jawaban,
        'userid': userid,
        'nama': nama,
        'urlimg': urlimg,
        'waktu': waktu,
      };
}
