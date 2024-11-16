import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/constant/app_color.dart';
import 'package:weather_app/core/constant/image_assets.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/providers/weather_provider.dart';

import '../core/constant/app_strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void updateUi() {
    setState(() {});
  }

  WeatherModel? weatherData;
  @override
  Widget build(BuildContext context) {
    weatherData = Provider.of<WeatherProvider>(context).weatherData;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColor.trans,
        centerTitle: true,
        title: const Text(AppStrings.weatherApp , style:TextStyle(fontWeight: FontWeight.bold ,color: Colors.black54,fontSize: 30),),
      ),
      body: Provider.of<WeatherProvider>(context).weatherData == null
          ? Container(
        height: double.maxFinite,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                image: DecorationImage(image:AssetImage(AppImageAssets.weather),fit: BoxFit.cover
                )
              ),
            child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     const Text(
                      AppStrings.thereIsNo,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        elevation: WidgetStateProperty.all(3),
                        backgroundColor: WidgetStateProperty.all(Colors.teal),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return SearchPage(
                            updateUi: updateUi,
                          );
                        }));
                      },
                      child: const Text(AppStrings.search ,style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),),
                    ),
                  ],
                ),
              ),
          )
          : Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  weatherData!.getThemeColor(),
                  weatherData!.getThemeColor()[300]!,
                  weatherData!.getThemeColor()[100]!,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 3,
                  ),
                  Text(
                    Provider.of<WeatherProvider>(context).cityName!,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'updated at : ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}',
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    //  Image.asset(weatherData!.getImage()),
                      SizedBox.square(
                          dimension: 130,
                          child: Image.network("https:${weatherData!.iconPath.toString()}",fit: BoxFit.cover,),),
                      Text(
                        weatherData!.temp.toInt().toString(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: [
                          Text('maxTemp :${weatherData!.maxTemp.toInt()}'),
                          Text('minTemp : ${weatherData!.minTemp.toInt()}'),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    weatherData!.weatherStateName,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 15)),
                      elevation: WidgetStateProperty.all(3),
                      backgroundColor: WidgetStateProperty.all(weatherData!.getThemeColor()[300]!,),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return SearchPage(
                          updateUi: updateUi,
                        );
                      }));
                    },
                    child: const Text(AppStrings.searchAgain ,style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
    );
  }
}
