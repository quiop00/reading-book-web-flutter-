class Chapter{
  String id;
  final String title;
  final String content;
  final String numberOfChapter;
  Chapter({this.id,this.title,this.content,this.numberOfChapter});
  factory Chapter.fromJson(Map<String,dynamic> json){
    return Chapter(
      title: json['title'],
      content: json['content'],
      numberOfChapter: json['numberOfChapter'],
      id: json['id']
    );
  }
  Map<String,dynamic> toJson() =>
      <String,dynamic>{
        'title': this.title,
        'content':this.content,
        'numberOfChapter': this.numberOfChapter,
        'id': this.id
      };

}