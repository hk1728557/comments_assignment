import 'dart:convert';

import 'package:add_comments/Model/ComentModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataContainer extends StatefulWidget {
  const DataContainer({Key? key});

  @override
  State<DataContainer> createState() => _DataContainerState();
}

class _DataContainerState extends State<DataContainer> {
  List<Comment> comments = []; // List to store comments
  bool isLoading = true;

  String DUrl = "https://jsonplaceholder.typicode.com/photos";
  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse(DUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        // comments = data.map((item) => Comment.fromJson(item)).toList();
        comments = [Comment.fromJson(data.first)];
        isLoading = false; // set isloading to false data is fetched
        // print(comments);
      });
    } else {
      //print Error
      print("No Data found!!");
      setState(() {
        isLoading = false; // set isloading to false when error
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  List<bool> commentAdded = [false]; // List to track if comment is added

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return _buildCommentListTile(index);
              },
            ),
    );
  }

  Container _buildCommentListTile(int index) {
    Comment comment = comments[index];

    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(221, 249, 247, 247),
        border: Border.all(color: Color(0xffC7C7D0), width: 2),
      ),
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl:
              comment.thumbnailUrl ?? "https://via.placeholder.com/150/771796",
          imageBuilder: (context, imageProvider) => CircleAvatar(
            radius: 20,
            backgroundImage: imageProvider,
          ),
          placeholder: (context, url) => const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        title: Text(comment.title ?? ''),
        subtitle: Text(comment.content ?? ''),
        trailing: commentAdded[index]
            ? Icon(Icons.check, color: Colors.green) // Show success icon
            : IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // Show AlertDialog Box
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialogBox(context, index);
                    },
                  );
                },
              ),
      ),
    );
  }

  AlertDialog AlertDialogBox(BuildContext context, int index) {
    TextEditingController commentController = TextEditingController();

    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: Text("Type below"),
      content: Card(
        elevation: 3,
        color: Color.fromARGB(255, 251, 248, 248),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 10),
          child: TextField(
            controller: commentController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Comment",
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Background color
          ),
          onPressed: () {
            // Add comment to the list
            String commentText = commentController.text;
            Comment newComment = Comment(
              title: "Comment Title",
              content: commentText,
            );
            setState(() {
              comments.insert(
                  0, newComment); // Insert new comment at the beginning
              commentAdded.insert(0, true);
            });
            Navigator.pop(context);

            // Show Snackbar message
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('New comment was added!'),
                  Icon(Icons.check_circle_rounded),
                ],
              ),
              shape: StadiumBorder(),
              backgroundColor: Color.fromARGB(255, 175, 173, 173),
            ));
          },
          child: Text("Add"),
        ),
      ],
    );
  }
}
