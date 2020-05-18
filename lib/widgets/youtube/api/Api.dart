import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../utils/key.dart';
import 'package:tutorial_app/widgets/youtube/model/Video.dart';

const CHANNEL_ID = "UCbcxFkd6B9xUU54InHv4Tig";
const BASE_URL = "https://www.googleapis.com/youtube/v3/";

class Api {

  Future<List<Video>> search(String search) async {
    http.Response response = await http.get(
      BASE_URL + "search"
          "?part=snippet"
          "&type=video"
          "&maxResults=20"
          "&order=date"
          "&key=$YOUTUBE_API_KEY"
          "&q=$search"
    );

    if(response.statusCode == 200) {
      Map<String, dynamic> jsonInformations = json.decode(response.body);

      List<Video> videos = jsonInformations["items"].map<Video>(
          (map) {
            return Video.fromJson(map);
          }
      ).toList();

      return videos;

    } else {

    }
  }
}