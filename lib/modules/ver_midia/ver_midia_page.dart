import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:midia_select/models/item_midia.dart';
import 'package:msk_utils/utils/utils_platform.dart';
import 'package:msk_utils/extensions/string.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';

import 'ver_midia_controller.dart';
import 'ver_midia_module.dart';

class VerMidiaPage extends StatefulWidget {
  final String title;
  const VerMidiaPage({Key key, this.title = ""}) : super(key: key);

  @override
  _VerMidiaPageState createState() => _VerMidiaPageState();
}

class _VerMidiaPageState extends State<VerMidiaPage> {
  final VerMidiaController _controller =
      VerMidiaModule.to.bloc<VerMidiaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.black,
          leading: InkWell(
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Builder(
          builder: (context) {
            final double height = MediaQuery.of(context).size.height;
            return Center(
              child: CarouselSlider.builder(
                  options: CarouselOptions(
                      height: height - 100,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      initialPage: _controller.posicao ?? 0,
                      enableInfiniteScroll: false),
                  itemCount: _controller.itens.length,
                  itemBuilder: (BuildContext context, int itemIndex) {
                    return Center(
                      child: Container(
                          child: InkWell(
                        onTap: () {},
                        child: Hero(
                            tag: itemIndex,
                            child: _getItemMidia(_controller.itens[itemIndex])),
                      )),
                    );
                  }),
            );
          },
        ));
  }

  _getItemMidia(ItemMidia item) {
    switch (item.tipoMidia) {
      case TipoMidiaEnum.IMAGEM:
        if (item.url.isNullOrBlank && item.path.isNullOrBlank) {
          return Text('Falha ao carregar imagem');
        }
        return PinchZoomImage(
          image: item.url.isNullOrBlank
              ? Image.file(File(item.path))
              : (UtilsPlatform.isWeb || UtilsPlatform.isWindows)
                  ? Image.network(item.url)
                  : CachedNetworkImage(
                      imageUrl: item.url,
                      fit: BoxFit.contain,
                      placeholder: (_, url) =>
                          Center(child: CircularProgressIndicator()),
                    ),
        );
      case TipoMidiaEnum.VIDEO:
        return Text(
          'Não implementado',
          style: TextStyle(color: Colors.white),
        );
      case TipoMidiaEnum.AUDIO:
        {
          // //precisa de revisao
          // if (item.controlador == null) {
          //   VideoPlayerController _videoPlayerController1 =
          //       VideoPlayerController.network(item.url);
          //   ChewieAudioController _chewieAudioController =
          //       ChewieAudioController(
          //           videoPlayerController: _videoPlayerController1,
          //           autoPlay: true,
          //           looping: true);
          //   item.controlador = _chewieAudioController;
          // }
          // return Center(
          //   child: ChewieAudio(
          //     controller: item.controlador,
          //   ),
          // );

          return Text(
            'Não implementado',
            style: TextStyle(color: Colors.white),
          );
        }

      default:
        return PinchZoomImage(
          image: item.url.isNullOrBlank
              ? Image.file(File(item.path))
              : UtilsPlatform.isWeb
                  ? Image.network(item.url)
                  : CachedNetworkImage(
                      imageUrl: item.url,
                      fit: BoxFit.contain,
                      placeholder: (_, url) =>
                          Center(child: CircularProgressIndicator()),
                    ),
        );
    }
  }
}
