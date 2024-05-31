import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/model/chat_user_model.dart';
import 'package:mobile/model/post_model.dart';
import '../../model/process_model.dart';
import '../../services/post_service.dart';
import 'package:mobile/pages/loading.dart';
import 'package:mobile/services/process_service.dart';
import 'package:mobile/services/connection_service.dart';
import 'package:mobile/utils/utils.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({super.key});

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  PostModel post = PostModel(text: 'abc');
  List<process> processes = [];
  String? selectedProcess;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      //print('postid' + postId);
      getDetailPost();
      getProcess();
    });
  }

  Future<void> getDetailPost() async {
    String postId = ModalRoute.of(context)!.settings.arguments as String;
    PostModel postAPI = await PostService.getPostDetail(postId);
    post = postAPI;
    //print('cc${post.postId}' ?? '');
  }

  Future<void> getProcess() async {
    List<process> processAPI = await ProcessService.getAll();
    //print(processAPI);
    setState(() {
      processes = processAPI;
    });
  }

  Future<bool> createConnection() async {
    print(post.postId);
    print(selectedProcess);
    bool response = await ConnectionService.createConnection(
        post.postId ?? '', selectedProcess ?? '');
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chi tiết bài kết nối'),
        ),
        body: FractionallySizedBox(
          heightFactor: 0.95,
          child: FutureBuilder(
              future: getDetailPost(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loading();
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        post.image!.isNotEmpty
                            ? CarouselSlider.builder(
                                itemCount: post.image?.length,
                                itemBuilder: (BuildContext context, int index,
                                    int realIndex) {
                                  return Image.network(post.image![index]);
                                },
                                options: CarouselOptions(
                                  autoPlay: true,
                                  aspectRatio: 2.0,
                                  enlargeCenterPage: true,
                                ),
                              )
                            : Container(),
                        Text(post.title ?? '',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(formatCurrency(post.car?.price ?? 0),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                        Text(post.text ?? ''),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(post.user?.avatar ?? ''),
                          ),
                          title: Text(post.user?.fullname ?? 'Chưa cập nhật'),
                        ),
                        ListTile(
                          leading: Icon(Icons.calendar_today),
                          title:
                              Text(post.createAt.toString() ?? 'Chưa cập nhật'),
                        ),
                        ListTile(
                          leading: Icon(Icons.location_pin),
                          title: Text(post.address ?? 'Chưa cập nhật'),
                        ),
                        ListTile(
                          leading: Icon(Icons.star),
                          title: Text((post.user?.avgRating.toString() ?? '0') + ' tỉ lệ hoàn thành'),
                        ),
                        ListTile(
                          leading: Icon(Icons.check_circle),
                          title: Text((post.user?.completedTransactions.toString() ?? '0') + ' giao dịch hoàn thành'),
                        ),
                        Text('Thông tin xe'),
                        ListTile(
                          leading: Text(
                            'Hãng xe',
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Text(post.car?.brand ?? 'Chưa cập nhật',
                              style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          leading: Text(
                            'Dòng xe',
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Text(post.car?.type ?? 'Chưa cập nhật',
                              style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          leading: Text(
                            'Năm sản xuất',
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Text(post.car?.mfg ?? 'Chưa cập nhật',
                              style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          leading: Text(
                            'Phiên bản',
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Text(post.car?.model ?? 'Chưa cập nhật',
                              style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          leading: Text(
                            'Hộp số',
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Text(post.car?.gear ?? 'Chưa cập nhật',
                              style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          leading: Text(
                            'Nhiên liệu',
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Text(post.fuel ?? 'Chưa cập nhật',
                              style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          leading: Text(
                            'Xuất xứ',
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Text(post.car?.origin ?? 'Chưa cập nhật',
                              style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          leading: Text(
                            'Kiểu dáng',
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Text(post.design ?? 'Chưa cập nhật',
                              style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          leading: Text(
                            'Số ghế ngồi',
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Text(
                              post.car?.seat.toString() ?? 'Chưa cập nhật',
                              style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          leading: Text(
                            'Màu sắc',
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Text(post.color ?? 'Chưa cập nhật',
                              style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          leading: Text(
                            'Biển số xe',
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Text(post.licensePlate ?? 'Chưa cập nhật',
                              style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          leading: Text(
                            'Số đời chủ',
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Text(
                              post.ownerNumber.toString() ?? 'Chưa cập nhật',
                              style: TextStyle(fontSize: 16)),
                        ),
                        ListTile(
                          leading: Text(
                            'Số km đã đi',
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Text(
                              post.car?.kilometer.toString() ?? 'Chưa cập nhật',
                              style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
        bottomNavigationBar: Row(
          children: [
            Expanded(
              child: Container(
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: AlertDialog(
                              title:
                                  Text('Chọn quy trình thực hiện với hoa tiêu'),
                              content: StatefulBuilder(
                                  builder: (context, StateSetter setState) {
                                return Column(
                                  children: processes.map((process) {
                                    return RadioListTile<String>(
                                      title: Text(process.name ?? ''),
                                      value: process.id ?? '',
                                      groupValue: selectedProcess,
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedProcess = value;
                                        });
                                      },
                                    );
                                  }).toList(),
                                );
                              }),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () async {
                                    bool response = await createConnection();
                                    if (response) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text('Kết nối thành công')));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text('Kết nối thất bại')));
                                    }
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: Text('Kết nối'),
                ),
              ),
            ),
            Expanded(
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  ChatUserModel chatUser = ChatUserModel(
                      id: post.user?.userId ?? '',
                      name: post.user?.fullname ?? '',
                      image: post.user?.avatar ?? '');
                  Navigator.pushNamed(context, '/chat', arguments: chatUser);
                },
                child: Text('Nhắn tin'),
              ),
            ),
            Expanded(
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () async{
                  print(post.postId ?? '');
                  bool response = await PostService.blockUser(post.postId ?? '');
                  if (response) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Chặn hoa tiêu thành công')));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Chặn hoa tiêu thất bại')));
                  }
                },
                child: Text('Chặn hoa tiêu'),
              ),
            )
          ],
        ));
  }
}
