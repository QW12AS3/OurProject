class CommentsModel {
  late String owner;
  late String ownerImageUrl;
  late String comment;
  late String date;

  CommentsModel(this.owner, this.comment, this.date, this.ownerImageUrl);
  CommentsModel.fromJson(Map<String, dynamic> json) {
    owner = json['owner'];
    comment = json['comment'];
    date = json['date'];
    ownerImageUrl = json['ownerImageUrl'];
  }
}
