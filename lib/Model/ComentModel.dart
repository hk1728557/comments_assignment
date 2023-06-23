class Comment {
  String? title;
  String? url;

  String? thumbnailUrl;
  String? content;

  Comment({this.title, this.url, this.thumbnailUrl,this.content});

  Comment.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
    content = json['content'];
  }
}
