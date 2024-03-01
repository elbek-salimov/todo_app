
class ApiProvider {
  // static Future<MyResponse> getComplexWeatherInfo() async {
  //   Map<String, String> queryParams = {
  //     "lat": "41.2646",
  //     "lon": "69.2163",
  //     "appid": AppConstants.complexApiKey,
  //     "units": "metric",
  //   };
  //
  //   Uri uri = Uri.https(
  //     AppConstants.baseUrl,
  //     "/data/3.0/onecall",
  //     queryParams,
  //   );
  //
  //   try {
  //     http.Response response = await http.get(uri);
  //
  //     if (response.statusCode == 200) {
  //       return MyResponse(
  //           data: OneCallData.fromJson(jsonDecode(response.body)));
  //     } else {
  //       return MyResponse(errorText: "OTHER ERROR:${response.statusCode}");
  //     }
  //   } catch (error) {
  //     return MyResponse(errorText: error.toString());
  //   }
  // }
}
