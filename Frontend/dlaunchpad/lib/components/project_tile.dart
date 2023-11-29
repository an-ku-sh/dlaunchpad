import 'package:dlaunchpad/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectTile extends StatefulWidget {
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
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {
  TextEditingController textEditingController = TextEditingController();
  int trstAmount = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(width: 0.1),
      ),
      child: Column(
        children: [
          Image.asset("lib/assets/img${widget.imgId}.jpg"),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.heading,
            style: GoogleFonts.abel(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.pitch,
              style: const TextStyle(fontSize: 12),
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
          const SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Enter TRST Amount'),
                        content: TextField(
                          controller: textEditingController,
                          decoration: const InputDecoration(
                              hintText: 'Enter your amount here'),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              setState(() {});
                              trstAmount +=
                                  int.parse(textEditingController.text);
                              trstCount -=
                                  int.parse(textEditingController.text);
                              textEditingController.clear();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.heat_pump_rounded),
                label: const Text("Invest your TRST"),
              ),
              const SizedBox(height: 14),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.verified),
                label: Text("TRST count $trstAmount"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
