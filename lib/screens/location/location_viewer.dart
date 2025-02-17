// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/providers/location_viewer_provider.dart';
import 'package:social_media_app/utils/app_styles.dart';

class LocationViewer extends StatelessWidget {
  const LocationViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final locationViewerProvider = Provider.of<LocationViewerProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Location'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                15,
              ),
            ),
            padding: const EdgeInsets.all(
              10,
            ),
            child: OSMFlutter(
              controller: locationViewerProvider.mapController,
              osmOption: OSMOption(
                zoomOption: const ZoomOption(
                  initZoom: 12,
                  minZoomLevel: 3,
                  maxZoomLevel: 19,
                  stepZoom: 1.0,
                ),
                userLocationMarker: UserLocationMaker(
                  personMarker: const MarkerIcon(
                    icon: Icon(
                      Icons.location_pin,
                      color: Colors.blue,
                      size: 60,
                    ),
                  ),
                  directionArrowMarker: const MarkerIcon(
                    icon: Icon(
                      Icons.double_arrow,
                      color: Colors.blue,
                      size: 60,
                    ),
                  ),
                ),
                roadConfiguration: const RoadOption(
                  roadColor: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: InkWell(
              onTap: () async {
                await locationViewerProvider.setCurrentLocation();

                Navigator.of(context).pop();
              },
              child: Text(
                'Set Location',
                style: AppStyle.styleRegular20(context)
                    .copyWith(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
