import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/models/message_model.dart';
import 'package:shamo/models/product_model.dart';
import 'package:shamo/providers/auth_provider.dart';
import 'package:shamo/services/message_service.dart';
import 'package:shamo/theme.dart';
import 'package:shamo/widget/chat_buble.dart';

// ignore: must_be_immutable
class DetailChatPage extends StatefulWidget {
  DetailChatPage({super.key, required this.product});

  late ProductModel product;

  @override
  State<DetailChatPage> createState() => _DetailChatPageState();
}

class _DetailChatPageState extends State<DetailChatPage> {
  TextEditingController messageController = TextEditingController(text: '');

  PreferredSizeWidget header() {
    return PreferredSize(
      // ignore: sort_child_properties_last
      child: AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: false,
        title: Row(
          children: [
            Image.asset(
              'assets/image_store_online.png',
              width: 50,
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shoe Store',
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Online',
                  style: secondaryTextStyle.copyWith(
                    fontWeight: light,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      preferredSize: const Size.fromHeight(70),
    );
  }

  Widget productPreview() {
    return Container(
      width: 225,
      height: 74,
      padding: const EdgeInsets.all(
        10,
      ),
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: backgroundColor5,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              12,
            ),
            child: Image.network(
              widget.product.galleries[0].url,
              width: 54,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  overflow: TextOverflow.ellipsis,
                  style: primaryTextStyle,
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  '\$${widget.product.price}',
                  style: priceTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.product = UninitializedProductModel();
              });
            },
            child: Image.asset(
              'assets/button_close.png',
              width: 22,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleAddMessage() async {
      await MessageService().addMessage(
          user: authProvider.user,
          isFromUser: true,
          message: messageController.text,
          product: widget.product);

      setState(() {
        widget.product = UninitializedProductModel();
        messageController.text = '';
      });
    }

    Widget chatInput() {
      return Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.product is UninitializedProductModel
                ? const SizedBox()
                : productPreview(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: backgroundColor4,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: messageController,
                        style: primaryTextStyle,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Type Message...',
                          hintStyle: subTitleTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: handleAddMessage,
                  child: Image.asset(
                    'assets/button_send.png',
                    width: 45,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget content() {
      return StreamBuilder<List<MessageModel>>(
          stream: MessageService()
              .getMessagesByUserId(userId: authProvider.user.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                  ),
                  children: snapshot.data!
                      .map((MessageModel message) => ChatBuble(
                            text: message.message,
                            isSender: message.isFromUser,
                            product: message.product,
                          ))
                      .toList());
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      bottomNavigationBar: chatInput(),
      body: content(),
    );
  }
}
