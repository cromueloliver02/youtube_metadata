import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youtube_metadata/src/open_graph.dart';
part 'model.dart';

class YoutubeMetaData {
  const YoutubeMetaData();

  ///
  /// Get data from a youtube link
  Future<MetaDataModel> getData(String link) async {
    final Uri uri =
        Uri.parse("https://www.youtube.com/oembed?url=$link&format=json");

    http.Response result;

    /// Throw https error
    try {
      result = await http.get(uri);
    } catch (e) {
      throw e;
    }

    ///
    final Map<String, dynamic> resultJson = json.decode(result.body);

    /// Add the following after fetching information
    /// Fetch description and url
    final ogData = await OpenGraphRepository.openGraphData(link);
    resultJson.addAll(ogData);
    //
    return MetaDataModel.fromMap(resultJson);
  }
}
