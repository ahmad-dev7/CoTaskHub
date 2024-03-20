class TeamData {
  final String? adminName;
  final String? teamName;
  final List<Member>? members;
  final String? projectDescription;
  final String? teamCode;
  final String? projectName;
  final List<Task>? tasks;
  final String? adminEmail;

  TeamData({
    this.adminName,
    this.teamName,
    this.members,
    this.projectDescription,
    this.teamCode,
    this.projectName,
    this.tasks,
    this.adminEmail,
  });

  factory TeamData.fromJson(Map<String, dynamic> json) {
    return TeamData(
      adminName: json['adminName'],
      teamName: json['teamName'],
      members: (json['members'] as List<dynamic>?)
          ?.map((member) => Member.fromJson(member))
          .toList(),
      projectDescription: json['projectDescription'],
      teamCode: json['teamCode'],
      projectName: json['projectName'],
      tasks: (json['tasks'] as List<dynamic>?)
          ?.map((task) => Task.fromJson(task))
          .toList(),
      adminEmail: json['adminEmail'],
    );
  }
}

class Member {
  final String? name;
  final String? email;

  Member({
    this.name,
    this.email,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      name: json['name'],
      email: json['email'],
    );
  }
}

class Task {
  final String? taskDesc;
  final String? dueDate;
  final String? taskTitle;
  final String? assignedTo;
  final bool? isCompleted;

  Task({
    this.taskDesc,
    this.dueDate,
    this.taskTitle,
    this.assignedTo,
    this.isCompleted,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskDesc: json['taskDesc'],
      dueDate: json['dueDate'],
      taskTitle: json['taskTitle'],
      assignedTo: json['assignedTo'],
      isCompleted: json['isCompleted'],
    );
  }
}
