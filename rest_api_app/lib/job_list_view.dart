import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './job.dart';

class JobListView extends StatefulWidget {
  const JobListView({super.key});

  @override
  State<JobListView> createState() => _JobListViewState();
}

class _JobListViewState extends State<JobListView> {
  Future<List<Job>> _fetchJobs() async {
    final jobsListUrl = Uri.parse('https://mock-json-service.glitch.me/');
    final response = await http.get(jobsListUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => Job.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _jobsListView(data) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _tile(
          data[index].position,
          data[index].company,
          Icons.work,
        );
      },
      itemCount: data.length,
    );
  }

  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        subtitle: Text(subtitle),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Job>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Job>? data = snapshot.data;
          return _jobsListView(data);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return CircularProgressIndicator();
      },
    );
  }
}
