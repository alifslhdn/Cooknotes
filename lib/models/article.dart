class Article {
  String title;
  String image;
  String author;
  String content;

  Article({this.title, this.image, this.author, this.content});

  Article.copy(Article from)
      : this(
            title: from.title,
            image: from.image,
            author: from.author,
            content: from.content);
  Article.fromJson(Map<String, dynamic> json)
      : this(
            title: json['title'],
            image: json['image'],
            author: json['author'],
            content: json['content']);

  Map<String, dynamic> toJson() =>
      {'title': title, 'image': image, 'author': author, 'content': content};
}
