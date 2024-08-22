import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class ActionTab extends StatefulWidget {
  final String actUserid;
  const ActionTab({super.key, required this.actUserid});

  @override
  State<ActionTab> createState() => _ActionTabState();
}

class _ActionTabState extends State<ActionTab> {
  var jobList;
  var length = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      var response = await Dio().get(
          '${widget.actUserid}', //Add jobs list url
          options: Options(headers: {
            "Content-Type": "application/json",
            "ChannelId": "2",
            "ClientSecret": ""
          }));
      if (response.statusCode == 200) {
        setState(() {
          jobList = response.data as List;
          length = jobList.length;
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Showing ${length.toString()} Jobs",
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  height: 38,
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.blue),
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Icon(Icons.bolt),
                        Text("Filter"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                //padding: const EdgeInsets.only(top: 10),
                itemCount: jobList == null ? 0 : jobList.length,
                itemBuilder: (BuildContext context, int index) {
                  DateTime dateTime =
                      DateTime.parse(jobList[index]["postedDateTime"]);
                  String formattedDate =
                      DateFormat('dd MMMM yyyy').format(dateTime);

                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            jobList[index]["title"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(jobList[index]["address"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              const SizedBox(width: 8),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.green[200]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  child: Text("#${jobList[index]["jobNumber"]}",
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  child: Text(
                                      "By: ${jobList[index]["postedBy"]}",
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blue[200]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  child: Text(jobList[index]["primaryJobType"],
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (jobList[index]["urgencyTypeId"] == 2)
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.red[100]),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4.0),
                                    child: Text("Urgently",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red)),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 8.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Posted on $formattedDate",
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic),
                              )),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}