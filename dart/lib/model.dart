import 'package:json_annotation/json_annotation.dart';

class ActivityModel{

  ActivityModel({
    required this.activity
  });
  final activity;

  factory ActivityModel.fromJson(Map<String, dynamic> data) {
    final activity = data["data"] as List<dynamic>;
    return ActivityModel(activity: activity);
  }
}

class Activity{

  Activity({
    required this.data
  });
  final List<Dados> data;

  factory Activity.fromJson(Map<String, dynamic> data2) {
    final data = data2["data"] as List<Dados>;
    return Activity(data: data);
  }
}

class Dados{

  Dados({
    required this.id,
    required this.start,
    required this.end,
    required this.title,
    required this.description,
    required this.locations,
    required this.type,
    required this.people,
    required this.status,
    required this.event,
  });

  final int id;
  final String start;
  final String end;
  final Title title;
  final Description description;
  final List<Locations> locations;
  final Tipo type;
  final List<People> people;
  final int status;
  final String event;

  factory Dados.fromJson(Map<String, dynamic> data) {
    final id = data["id"] as int;
    final start = data["start"] as String;
    final end = data["end"] as String;
    final title = data["title"] as Title;
    final description = data["description"] as Description;
    final locations = data["locations"] as List<Locations>;
    final type = data["type"] as Tipo;
    final people = data["people"] as List<People>;
    final status = data["status"] as int;
    final event = data["event"] as String;
    return Dados(
      id: id, 
      start: start, 
      end: end, 
      title: title, 
      description: description, 
      locations: locations, 
      type: type, 
      people: people, 
      status: status, 
      event: event
      );
  }
}

//classe do titulo
class Title{
  Title({
    required this.ptBr
  });

  @JsonKey(name: "pt-br")
  final String ptBr;

  factory Title.fromJson(Map<String, dynamic> data){
    final ptBr = data["pt-bt"] as String;
    return Title(ptBr: ptBr);
  }
}

//classe da descricao
class Description{

  Description({
    required this.ptBr
  });
  @JsonKey(name: "pt-br")
  final String ptBr;

  factory Description.fromJson(Map<String, dynamic> data){
    final ptBr = data["pt-br"] as String;
    return Description(ptBr: ptBr);
  }
}

//classe da localizacao
class Locations{

  Locations({
    required this.title
  });
  final TitleLoc title;

  factory Locations.fromJson(Map<String, dynamic> data){
    final title = data["title"] as TitleLoc;
    return Locations(title: title);
  }
}

    class TitleLoc{
      TitleLoc({
      required this.ptBr
    });

    @JsonKey(name: "pt-br")
    final String ptBr;

    factory TitleLoc.fromJson(Map<String, dynamic> data){
      final ptBr = data["pt-br"] as String;
      return TitleLoc(ptBr: ptBr);
    }
    }

//classe do tipo
class Tipo{
  Tipo({
    required this.title
  });
  final TitleType title;

  factory Tipo.fromJson(Map<String, dynamic> data){
    final title = data["title"] as TitleType;
    return Tipo(title: title);
  }
}

    class TitleType{
      TitleType({
      required this.ptBr
    });

    @JsonKey(name: "pt-br")
    final String ptBr;

    factory TitleType.fromJson(Map<String, dynamic> data){
      final ptBr = data["pt-br"] as String;
      return TitleType(ptBr: ptBr);
    }
    }

//classe das pessoas
class People{

  People({
    required this.title,
    required this.name,
    required this.institution,
    required this.bio,
    required this.picture,
    required this.role,
  });
  final String title;
  final String name;
  final String institution;
  final Bio bio;
  final String picture;
  final Role role;
  
  factory People.fromJson(Map<String, dynamic> data){
    final title = data["title"] as String;
    final name = data["name"] as String;
    final institution = data["institution"] as String;
    final bio = data["bio"] as Bio;
    final picture = data["picture"] as String;
    final role = data["role"] as Role;
    return People(
      title: title,
      name: name,
      institution: institution,
      bio: bio,
      picture: picture,
      role: role
    );
  }
}

    class Bio{

      Bio({required this.ptBr
    });

    @JsonKey(name: "pt-br")
    final String ptBr;

    factory Bio.fromJson(Map<String, dynamic> data){
      final ptBr = data["pt-br"] as String;
      return Bio(ptBr: ptBr);
    }
    }

    class Role{

      Role({
        required this.label
      });
      @JsonKey(name: "label")
      final Label label;

      factory Role.fromJson(Map<String, dynamic> data){
      final label = data["label"] as Label;
      return Role(label: label);
    }
    }

        class Label{

          Label({required this.ptBr
          });

          @JsonKey(name: "pt-br")
          final String ptBr;

          factory Label.fromJson(Map<String, dynamic> data){
            final ptBr = data["pt-br"] as String;
            return Label(ptBr: ptBr);
          }
        }