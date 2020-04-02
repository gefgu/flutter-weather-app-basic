import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = "9426f14f9c66ae5af9513a6760935f0f";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.list),
              tooltip: "Menu",
              iconSize: 32.0,
              padding: const EdgeInsets.all(8.0),
              onPressed: null,
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                tooltip: "Search",
                iconSize: 32.0,
                padding: const EdgeInsets.all(8.0),
                onPressed: null,
              )
            ],
          ),
          body: Container(
              padding: EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "Weather",
                        style: TextStyle(
                          fontSize: 48.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          child: Text("Today"),
                          onPressed: () {},
                          color: Colors.white,
                          textColor: Colors.grey,
                          splashColor: Colors.white10,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(18),
                                bottomLeft: Radius.circular(18),
                              ),
                              side: BorderSide(color: Colors.white)),
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          child: Text("Tommorrow"),
                          onPressed: () {},
                          color: Colors.white,
                          textColor: Colors.grey,
                          splashColor: Colors.white10,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.only(
                                topRight: Radius.circular(18),
                                bottomRight: Radius.circular(18),
                              ),
                              side: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildCityTile("https://images.unsplash.com/photo-1505761671935-60b3a7427bad?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
                      "London"),
                  _buildCityTile("https://images.unsplash.com/photo-1485738422979-f5c462d49f74?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1075&q=80",
                      "New York"),
                  _buildCityTile("https://images.unsplash.com/photo-1549144511-f099e773c147?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80",
                      "Paris"),
                  _buildCityTile("https://images.unsplash.com/photo-1501594907352-04cda38ebc29?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=889&q=80",
                      "San Francisco"),
                  _buildCityTile("https://images.unsplash.com/photo-1554797589-7241bb691973?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=976&q=80",
                      "Tokyo"),
                  _buildCityTile("https://images.unsplash.com/photo-1570069254812-a248c878dcc1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=664&q=80",
                      "Roma"),
                  _buildCityTile("https://images.unsplash.com/photo-1460881680858-30d872d5b530?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1051&q=80",
                      "Los Angeles"),
                ],
              ))),
    );
  }

  Widget _buildCityTile(String pathImg, String cityName) {
    return new CityRow(
      pathImg: pathImg,
      cityName: cityName,
      currentWeather: getCurrentWeather(cityName),
      weekWeather: getWeekWeather(cityName),
    );
  }
}

class CityRow extends StatelessWidget {
  final String pathImg;
  final String cityName;
  final Future<CurrentWeatherCity> currentWeather;
  final Future<WeekWeatherCity> weekWeather;

  CityRow({this.pathImg, this.cityName, this.currentWeather, this.weekWeather});

  @override
  Widget build(BuildContext context) {
      return FutureBuilder<CurrentWeatherCity>(
        future: currentWeather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
                child: FlatButton(
                  child: Container(
                    decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(pathImg),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10.0,
                              offset: Offset(5.0, 5.0)),
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 10.0,
                              offset: Offset(-5.0, -5.0))
                        ],
                        borderRadius: BorderRadius.circular(16.0)),
                    child: new Stack(
                      children: <Widget>[
                        new Positioned(
                          right: 10.0,
                          bottom: 5.0,
                          child: new Text(
                            cityName,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 32.0,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black,
                                    offset: Offset(5.0, 5.0),
                                  ),
                                  Shadow(
                                    blurRadius: 20.0,
                                    color: Colors.grey,
                                    offset: Offset(-5.0, -5.0),
                                  )
                                ]),
                          ),
                        ),
                        new Positioned(
                          left: 10.0,
                          bottom: 5.0,
                          child: new Text(
                            snapshot.data.currentTemp,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 32.0,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black,
                                    offset: Offset(5.0, 5.0),
                                  ),
                                  Shadow(
                                    blurRadius: 20.0,
                                    color: Colors.grey,
                                    offset: Offset(-5.0, -5.0),
                                  )
                                ]),
                          ),
                        ),
                        new Positioned(
                          left: 12.0,
                          top: 7.5,
                          child: Image.network(snapshot.data.pathImg, color: Colors.black,),
                        ),
                        new Positioned(
                            left: 10.0,
                            top: 5.0,
                            child: Image.network(snapshot.data.pathImg),
                        ),
                      ],
                    ),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.9,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.2,
                    margin: EdgeInsets.fromLTRB(4.0, 16.0, 4.0, 16.0),
                  ),
                  onPressed: () {
                    _pushCityScreen(context, cityName, pathImg);
                  },
                ));
          } else if (snapshot.hasError) {
            return Center(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.error_outline, color: Colors.red,
                    size: 60,),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text("Error: ${snapshot.error}"),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 120,
                  ),
                  const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text("Loading data..."),
                  )
                ],
              ),
            );
          }
        });
  }

  void _pushCityScreen(BuildContext context, String cityName, String pathImg) {
    Navigator.of(context).push(
        new MaterialPageRoute(
            builder: (context) {
              return new Scaffold(
                  appBar: new AppBar(
                    title: new Text(cityName),
                  ),
                  body: ListView(
                    children: <Widget>[
                      new Image.network(
                        pathImg, fit: BoxFit.cover, height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.75,),
                      _buildWeatherTimeList(),
                    ],
                  )
              );
            }
        )
    );
  }

  Widget _buildWeatherTimeList() {
    return new Column(children: <Widget>[
      _buildWeatherTimeTile(0),
      _buildWeatherTimeTile(1),
      _buildWeatherTimeTile(2),
      _buildWeatherTimeTile(3),
      _buildWeatherTimeTile(4),
    ],
    );
  }

  Widget _buildWeatherTimeTile(int index) {
    return FutureBuilder(
      future: weekWeather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return new Container(
            child: ListTile(
              trailing: Text(index.toString() + " days in advance", style: TextStyle(color: Colors.white),),
              title: Text(snapshot.data.daysTempIcon[index][0], style: TextStyle(color: Colors.white,),),
              leading: Image.network(snapshot.data.daysTempIcon[index][1])
            ),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          );
        }else if (snapshot.hasError) {
          return Center(
            child: Container(
              child: Column(
                children: <Widget>[
                  Icon(Icons.error_outline, color: Colors.red,
                    size: 60,),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text("Error: ${snapshot.error}"),
                  )
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 120,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text("Loading data..."),
                )
              ],
            ),
          );
        }
      },
    );
  }
}

class CurrentWeatherCity {
  final String currentTemp;
  final String pathImg;

  CurrentWeatherCity({this.currentTemp, this.pathImg});

  factory CurrentWeatherCity.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherCity(
      currentTemp: (double.parse(json["main"]["temp"].toString()) - 273.15).toStringAsFixed(0) + "°",
      pathImg: "https://openweathermap.org/img/w/" + (json["weather"][0]["icon"].toString()) + ".png"
    );
  }
}

Future<CurrentWeatherCity> getCurrentWeather(String cityName) async {
  final response = await http.get("https://api.openweathermap.org/data/2.5/weather?q=" + cityName +"&appid=" + apiKey);

  if (response.statusCode == 200) {
    return CurrentWeatherCity.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load request from current weather");
  }
}

class WeekWeatherCity {
  final List<dynamic> daysTempIcon;

  WeekWeatherCity({this.daysTempIcon});

  factory WeekWeatherCity.fromJson(Map<String, dynamic> json) {
    var listInfo = [];
    for (var day = 0; day < 40; day += 8) {
      var main = json["list"][day]["main"];
      var weather = json["list"][day]["weather"];
      var valueToAdd = [
        (double.parse(main["temp"].toString()) - 273.15).toStringAsFixed(0) + "°",
        "https://openweathermap.org/img/w/" + (weather[0]["icon"].toString()) + ".png"
      ];
      listInfo.add(valueToAdd);
    }
    return WeekWeatherCity(
        daysTempIcon: listInfo,
    );
  }
}

Future<WeekWeatherCity> getWeekWeather(String cityName) async {
  final response = await http.get("https://api.openweathermap.org/data/2.5/forecast?q=" + cityName +"&appid=" + apiKey);

  if (response.statusCode == 200) {
    return WeekWeatherCity.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to load request from current weather");
  }
}

