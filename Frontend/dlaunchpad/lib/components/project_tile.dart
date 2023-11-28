import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectTile extends StatelessWidget {
  final String publicAddress;
  final String imgId;
  final String heading;
  final String pitch;
  const ProjectTile({
    super.key,
    required this.publicAddress,
    required this.imgId,
    required this.heading,
    required this.pitch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(width: 0.1),
      ),
      child: Column(
        children: [
          Image.asset("lib/assets/img$imgId.jpg"),
          const SizedBox(
            height: 5,
          ),
          Text(
            heading,
            style: GoogleFonts.abel(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              pitch,
              style: TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 0.6,
            color: Colors.grey,
            width: double.infinity,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.heat_pump_rounded),
                label: const Text("Give Feedback"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
