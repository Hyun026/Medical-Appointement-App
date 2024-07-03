import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy/constants/colors/colors.dart';
import 'package:healthy/search/resultPage.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
   List allResults = [];

    
   List resultList =[];
   final TextEditingController searchController = TextEditingController();
 
  @override
  void initState() {
   
    searchController.addListener(onSearchChanged);
    super.initState();
  }
 
   onSearchChanged(){
    print(searchController);
    searchResultList();
   }

   searchResultList(){
    List<Map<String, dynamic>> showResults = [];
    if (searchController.text != ""){
       for (var clientSnapShot in allResults){
        var name = clientSnapShot['name'].toString().toLowerCase();
        if(name.contains(searchController.text.toLowerCase())){
          showResults.add(clientSnapShot);
        }
       }
    }else{
      showResults = List.from(allResults);
    }
    setState(() {
      resultList = showResults;
    });
   }

  getDoctorList() async {
    var data = await FirebaseFirestore.instance.collection("doctors").orderBy('name').get();
    List<Map<String, dynamic>> docs = data.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    setState(() {
      allResults = docs;
    });

    searchResultList();
  }

  @override
  void dispose() {
    searchController.removeListener(onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
   getDoctorList();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
           title: CupertinoSearchTextField(
            controller: searchController,
                 
           ),
      ),
      body:ListView.builder(
        itemCount: resultList.length,
        itemBuilder:(context,index){
          return ListTile(
               title: Text(resultList[index]['name']),
               subtitle: Text(resultList[index]['field']),
               leading: CircleAvatar(
                 backgroundImage: NetworkImage(resultList[index]['imageLink']),
               ),
               onTap: () {
                
                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyResult(doctorDetails: resultList[index],),
                                ),
                              );
               },
          );
        }
         ) ,
    );
  }
}