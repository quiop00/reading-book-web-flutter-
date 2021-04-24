class Chapter{
  String id;
  final String title;
  final String content;
  int numberOfChapter;
  int timeStamp;
  Chapter({this.id,this.title,this.content,this.numberOfChapter,this.timeStamp});
  factory Chapter.fromJson(Map<String,dynamic> json){
    return Chapter(
      title: json['title'],
      content: json['content'],
      numberOfChapter: json['numberOfChapter'],
      id: json['id'],
      timeStamp: json['timeStamp']
    );
  }
  Map<String,dynamic> toJson() =>
      <String,dynamic>{
        'title': this.title,
        'content':this.content,
        'numberOfChapter': this.numberOfChapter,
        'id': this.id,
        'timeStamp': this.timeStamp
      };

}