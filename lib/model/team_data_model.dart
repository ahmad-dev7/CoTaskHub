class TeamData {
  String? adminName;
  String? teamName;
  List<Members>? members;
  String? projectDescription;
  String? teamCode;
  String? projectName;
  String? adminEmail;

  TeamData({
    this.adminName,
    this.teamName,
    this.members,
    this.projectDescription,
    this.teamCode,
    this.projectName,
    this.adminEmail,
  });

  TeamData.fromJson(Map<String, dynamic> json) {
    adminName = json['adminName'];
    teamName = json['teamName'];
    members = <Members>[];
    json['members'].forEach((member) {
      members!.add(Members.fromJson(member));
    });
    projectDescription = json['projectDescription'];
    teamCode = json['teamCode'];
    projectName = json['projectName'];
    adminEmail = json['adminEmail'];
  }
}

class Members {
  String? name;
  String? email;

  Members({required this.name, required this.email});

  Members.fromJson(Map<String, dynamic> json) {
    name = json['name']!;
    email = json['email']!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}
