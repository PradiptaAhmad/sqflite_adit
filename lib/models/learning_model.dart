class LearningModel {
  int? id;
  String? title;
  String? instructor;
  int? price;
  double? rating;
  String? images;
  String? lessons;
  String? duration;
  String? description;
  String? createdAt;
  String? updatedAt;

  LearningModel(
      {this.id,
      this.title,
      this.instructor,
      this.price,
      this.rating,
      this.images,
      this.lessons,
      this.duration,
      this.description,
      this.createdAt,
      this.updatedAt});

  LearningModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    instructor = json['instructor'];
    price = json['price'];
    rating = json['rating'];
    images = json['images'];
    lessons = json['lessons'];
    duration = json['duration'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['instructor'] = this.instructor;
    data['price'] = this.price;
    data['rating'] = this.rating;
    data['images'] = this.images;
    data['lessons'] = this.lessons;
    data['duration'] = this.duration;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}