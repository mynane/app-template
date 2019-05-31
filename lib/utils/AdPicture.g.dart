part of adpicture;

AdPicture _$AdPictureFromJson(Map<String, dynamic> json) {
  return AdPicture(imageUrl: json['imageUrl'] as String);
}

Map<String, dynamic> _$AdPictureToJson(AdPicture instance) => <String, dynamic>{
  'imageUrl': instance.imageUrl,
};
