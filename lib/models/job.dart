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

class OppModel {
  final String description, imageUrl, type, title, organisation, name, learnmore;
  final List<String> photos;

  OppModel(
      {this.photos,
        this.description,
        this.imageUrl,
        this.organisation,
        this.title,
        this.name,
        this.learnmore,
        this.type});
}

class StoryModel {
  final String story;

  StoryModel(
      {this.story});
}

class JobPostModel {
  final String description, postby, location, salary, title, hours, company, type, website;

  JobPostModel(
      {this.description,
        this.postby,
        this.location,
        this.salary,
        this.title,
        this.company,
        this.hours,
        this.website,
        this.type});
}
