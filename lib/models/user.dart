class User{
  final int albumid;
  final int id ;
  String title;
  String url;
  String thumbnailUrl;

  User({
    required this.albumid,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });
    
  factory User.fromJson(Map<String, dynamic> json){
    return User(
      albumid: json['albumid']?? 0, 
      id: json['id']?? 0, 
      title: json ['title']?? 0, 
      url: json ['url']?? 0, 
      thumbnailUrl: json ['thumbnailUrl']?? 0);
  }
}