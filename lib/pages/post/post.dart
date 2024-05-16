import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/post_card.dart';
import '../../model/post_model.dart';
import '../../services/post_service.dart';
import 'package:mobile/services/salon_service.dart';
import 'package:mobile/pages/loading.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<PostModel> posts = [];
  String salonId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();
  }

  Future<void> getPosts() async {
    String salonIdAPI = await SalonsService.isSalon();
    salonId = salonIdAPI;
    if (salonIdAPI == '') {
      return;
    } else {
      List<PostModel> postsAPI = await PostService.getAllPosts();
      posts = postsAPI;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  salonId == ''
                      ? TextButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/create_post');
                          },
                          icon: Icon(Icons.post_add),
                          label: Text('Thêm bài viết'),
                        )
                      : Container(),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/connection');
                    },
                    icon: Icon(Icons.connect_without_contact),
                    label: Text('Quản lý kết nối'),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: posts.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PostCard(post: posts[index]);
                    }),
              ),
            ],
          );
        });
  }
}
