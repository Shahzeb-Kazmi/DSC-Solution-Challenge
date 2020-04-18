class JobModel {
  final String description, iconUrl, location, salary, title, hours, company, type;
  final List<String> photos;

  JobModel(
      {this.photos,
        this.description,
        this.iconUrl,
        this.location,
        this.salary,
        this.title,
        this.company,
        this.hours,
        this.type});
}

class FeaturedJobModel {
  final String description, image, location, salary, title, hours, company, type;
  final List<String> photos;

  FeaturedJobModel(
      { this.photos,
        this.description,
        this.image,
        this.location,
        this.salary,
        this.title,
        this.company,
        this.hours,
        this.type});
}