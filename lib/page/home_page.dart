import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:galaxy_lite/model/chat_model.dart';
import 'package:lottie/lottie.dart';

import '../bloc/chat_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ChatBloc chatBloc = ChatBloc();
    TextEditingController messageController = TextEditingController();
    FocusNode focusNode = FocusNode();
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {},
        builder: (context, state) {
          List<ChatMessageModel> messages =
              (state as ChatMessageSuccess).message;
          switch (state.runtimeType) {
            case ChatMessageSuccess:
              return Container(
                height: double.maxFinite,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        opacity: 0.8,
                        image: AssetImage("assets/bg_image.jpg"),
                        fit: BoxFit.cover)),
                child: Column(
                  children: [
                    Container(
                      height: 80.h,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Galaxy Lite AI",
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.bold,fontFamily: 'Sixtyfour'),
                            ),
                            const Icon(
                              Icons.image_search_rounded,
                            )
                          ]),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.amber.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      messages[index].role == "user"
                                          ? Text(
                                              "User",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color:
                                                      Colors.deepPurpleAccent),
                                            )
                                          : Text("Model",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.amber)),
                                      Text(
                                        "${messages[index].parts?.first.text}",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ));
                            })),
                    if (chatBloc.isGenerated)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 100,
                              width: 100,
                              child: Lottie.asset("assets/loader.json")),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "Loading ...",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    Container(
                      height: 100.h,
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 20),
                      child: Row(children: [
                        Expanded(
                            child: TextField(
                          controller: messageController,
                          focusNode: focusNode,
                          cursorColor: Theme.of(context).primaryColor,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 10, bottom: 0, right: 0, top: 0),
                              hintText: 'How can I help you...',
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 16.sp),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.r),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor))),
                        )),
                        SizedBox(
                          width: 5.w,
                        ),
                        InkWell(
                          onTap: () {
                            if (messageController.text.isNotEmpty) {
                              FocusScope.of(context).unfocus();
                              chatBloc.add(ChatGenerateTextEvent(
                                  message: messageController.text));
                              messageController.clear();

                              // BlocProvider.of<ChatBloc>(context).add(
                              //   ChatGenerateTextEvent(
                              //       message: messageController.text));
                            }
                          },
                          child: CircleAvatar(
                            radius: 32.r,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 28.r,
                              backgroundColor: Colors.black,
                              child: const Icon(
                                Icons.send_rounded,
                              ),
                            ),
                          ),
                        )
                      ]),
                    )
                  ],
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
