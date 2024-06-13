import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/AddData.dart';
import 'package:firebase_crud/DataBase.dart';
import 'package:flutter/material.dart';

import 'UpdateData.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<QuerySnapshot>? dataStream;

  getDataOnLoad() async {
    try {
      dataStream = await DataBase().getData();
      setState(() {});
    } catch (e) {
      print('Error getting data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getDataOnLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase CRUD'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xffE6913C).withOpacity(0.9),
              const Color(0xff26A7E6).withOpacity(0.9),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: allUserDetails(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddData()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget allUserDetails() {
    return StreamBuilder<QuerySnapshot>(
      stream: dataStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${ds['Name']}',
                            style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Age :${ds['Age']}',
                            style: TextStyle(
                              color: Colors.blue.shade500,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            '${ds['Location']}',
                            style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateData(
                                    id: ds.id,
                                    name: ds['Name'],
                                    age: ds['Age'],
                                    location: ds['Location'],
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit),
                            iconSize: 28,
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () async {
                              await DataBase().deleteUser(ds.id);
                            },
                            icon: const Icon(Icons.delete),
                            iconSize: 28,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
