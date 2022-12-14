import 'package:bee_cycle_flutter/common/widgets/rounded_card.dart';
import 'package:bee_cycle_flutter/features/weather_widget/bloc/location/location_bloc.dart';
import 'package:bee_cycle_flutter/features/weather_widget/bloc/weather/weather_bloc.dart';
import 'package:bee_cycle_flutter/features/weather_widget/widgets/weather_card_content.dart';
import 'package:bee_cycle_flutter/features/weather_widget/widgets/weather_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  final LocationBloc _locationBloc = LocationBloc();
  late WeatherBloc _weatherBloc;


  @override
  void initState() {
    _weatherBloc = WeatherBloc(locationBloc: _locationBloc);
    _locationBloc.add(const LocationEvent.getCurrentLocation());
    super.initState();
  }

  @override
  void dispose() {
    _weatherBloc.close();
    _locationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _weatherBloc,
      child: RoundedCard(
        height: 120,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              return state.when(
                weatherInitial: () {
                  return const WeatherLoadingWidget();
                },
                weatherLoading: () {
                  return const WeatherLoadingWidget();
                },
                weatherLoaded: (data) {
                  return WeatherCardContent(data);
                },
                weatherError: () {
                  //TODO show a snackbar
                  return const SizedBox();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
