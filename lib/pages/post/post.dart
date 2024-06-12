import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
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
  int index=1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getPosts();
  }

  Future<void> getPosts() async {
    String salonIdAPI = await SalonsService.isSalon();
    salonId = salonIdAPI;
    if (salonIdAPI == '') {
      return;
    } else {
      List<PostModel> postsAPI = await PostService.getAllPosts(index, 8);
      posts.addAll(postsAPI);
      if (postsAPI.length>0) index++;
      print("index "+index.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bài viết'),
        backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    salonId == ''
                        ? TextButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, '/create_post');
                            },
                            icon: Icon(Icons.post_add),
                            label: Text('Thêm bài viết'),
                          ): Container(),

                  ],
                ),
                Expanded(
                  child: LazyLoadScrollView(
                       onEndOfPage: () { getPosts(); },
                       child: ListView.builder(
                        itemCount: posts.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return PostCard(post: posts[index]);
                        }),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
