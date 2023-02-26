import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';

class ApiService {
  static const baseURL = 'https://webtoon-crawler.nomadcoders.workers.dev';
  static const today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];

    final url = Uri.parse('$baseURL/$today');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);

      for (var webtoon in webtoons) {
        final webtoonInstance = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(webtoonInstance);
      }

      return webtoonInstances;
    }

    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseURL/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var webtoon = jsonDecode(response.body);
      webtoon = WebtoonDetailModel.fromJson(webtoon);

      return webtoon;
    }

    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(String id) async {
    List<WebtoonEpisodeModel> episodeInstances = [];

    final url = Uri.parse('$baseURL/$id/episodes');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var episodes = jsonDecode(response.body);

      for (var episode in episodes) {
        final episodeInstance = WebtoonEpisodeModel.fromJson(episode);
        episodeInstances.add(episodeInstance);
      }

      return episodeInstances;
    }

    throw Error();
  }
}
