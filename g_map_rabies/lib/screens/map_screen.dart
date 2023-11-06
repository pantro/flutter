import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mapas_app/blocs/blocs.dart';
import 'package:mapas_app/views/views.dart';
import 'package:mapas_app/widgets/btn_visited_house_widget.dart';
import 'package:mapas_app/widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();

    locationBloc = BlocProvider.of<LocationBloc>(context);
    //locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if ( locationState.lastKnownLocation == null ) return const Center( child: Text('Espere por favor ...'),);

          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState){
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView(initialLocation: locationState.lastKnownLocation!, markers: mapState.markers.values.toSet()),
                    const ManualMarker(),
                    const BtnVisitedHouse(),
                  ],
                ),
              );
            }
          );
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnSaveLocation(),
          BtnDownload(),
          BtnCurrentLocation()
        ],
      ),
    );
  }
}
