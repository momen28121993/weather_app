import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/class/request_status.dart';
import 'package:weather_app/core/constant/app_color.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';

import '../core/constant/image_assets.dart';
import '../core/functions/custom_dialog.dart';
import '../core/functions/handling_request_status.dart';
import '../core/services/weather_service.dart';

class SearchPage extends StatelessWidget {
  String? cityName;
  final VoidCallback? updateUi;

  SearchPage({Key? key, this.updateUi, this.cityName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    RequestStatus requestStatus = RequestStatus.none;
    TextEditingController controller = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search a City'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16)
                  .add(const EdgeInsets.only(top: 25)),
              child: SizedBox(
                height: 60,
                child: Center(
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    onChanged: (data) {
                      cityName = data;
                    },
                    // onSubmitted: (data) async {
                    //   cityName = data;
                    //
                    //   WeatherService service = WeatherService();
                    //
                    //   WeatherModel? weather =
                    //       await service.getWeather(cityName: cityName!);
                    //
                    //   Provider.of<WeatherProvider>(context, listen: false)
                    //       .weatherData = weather;
                    //   Provider.of<WeatherProvider>(context, listen: false)
                    //       .cityName = cityName;
                    //
                    //   Navigator.pop(context);
                    // },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        label: const Text('search'),
                        suffixIcon: IconButton(
                            onPressed: () async {
                              await getWeatherData(
                                  context, requestStatus, controller.text);
                            },
                            icon: const Icon(Icons.search)),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                        hintText: 'Enter a city name',
                        icon: const Icon(Icons.location_city)),
                  ),
                ),
              ),
            ),
          ),
          Image.asset(AppImageAssets.cityBackground)
        ],
      ),
    );
  }
}

/// ================== functions =====================

getWeatherData(
    BuildContext context, RequestStatus requestStatus, String? cityName) async {
  WeatherService service = WeatherService();
  var response = await service.getWeatherData(cityName!);
  requestStatus = handlingRequestStatus(response);
  if (requestStatus == RequestStatus.success) {
    WeatherModel? weather = WeatherModel.fromJson(response);
    if (weather.weatherStateName.isEmpty) {
      showCustomDialog(
        context,
        'No city with this name',
        'Please try again with another city name',
      );
    }
    Provider.of<WeatherProvider>(context, listen: false).weatherData = weather;
    Provider.of<WeatherProvider>(context, listen: false).cityName = cityName;

    Navigator.pop(context);
  } else if (requestStatus == RequestStatus.offline) {
    showCustomDialog(
      context,
      'no internet',
      'check your internet connection',
    );
  } else {

    showCustomDialog(
      context,
      'no matching city',
      'enter wright city name please',
    );
  }
}
