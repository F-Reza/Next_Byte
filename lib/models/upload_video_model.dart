class VideoUploadModel {
  String? userID;
  String? userName;
  String? userProfileImage;
  String? videoID;
  String? artistSongName;
  String? descriptionTags;
  String? videoUrl;
  String? thumbnailUrl;
  List? likesList;
  int? totalComments;
  int? totalShares;
  int? publishedDateTime;

  VideoUploadModel(
      {this.userID,
      this.userName,
      this.userProfileImage,
      this.videoID,
      this.artistSongName,
      this.descriptionTags,
      this.videoUrl,
      this.thumbnailUrl,
      this.likesList,
      this.totalComments,
      this.totalShares,
      this.publishedDateTime});

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'userID' : userID,
      'userName' : userName,
      'userProfileImage' : userProfileImage,
      'videoID' : videoID,
      'artistSongName' : artistSongName,
      'descriptionTags' : descriptionTags,
      'videoUrl' : videoUrl,
      'thumbnailUrl' : thumbnailUrl,
      'likesList' : likesList,
      'totalComments' : totalComments,
      'totalShares' : totalShares,
      'publishedDateTime' : publishedDateTime,
    };
  }

  factory VideoUploadModel.fromMap(Map<String, dynamic> map) => VideoUploadModel(
    userID: map['userID'],
    userName: map['userName'],
    userProfileImage: map['userProfileImage'],
    videoID: map['videoID'],
    artistSongName: map['artistSongName'],
    descriptionTags: map['descriptionTags'],
    videoUrl: map['videoUrl'],
    thumbnailUrl: map['thumbnailUrl'],
    likesList: map['likesList'],
    totalComments: map['totalComments'],
    totalShares: map['totalShares'],
    publishedDateTime: map['publishedDateTime'],
  );


}

