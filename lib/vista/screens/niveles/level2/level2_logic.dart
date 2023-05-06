class GameCards {
  final String hiddenCardpath =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhIZ0BeUdFWmKEPuHG8oqYPvKvLKbqVNHuiatUdPUCTvlDPUqsGPOjlf-O0VLFKGn1ThkIRpjtJ1xlKFp0q9SMG0pMtdsERgeKUGmOZCxkdgxr_zbyPhJQofnGHIy3jsYoNjp66DeodhoFnRC66yvzxsI9QsE_9lj2SqinF8T9TEMG7N8SYZ08Sb5w/s320/icon.png';
  List<String>? gameImg;

  final List<String> cards_list_mat = [
    //A continuación se presenta el acceso directo a la dirección de los diferentes tipos de imagenes relacionadas a las tarjetas
    //son valores duplicados ya que estos se guardan en parejas al momento de establecer la lista
    "https://ichef.bbci.co.uk/news/640/cpsprodpb/164EE/production/_109347319_gettyimages-611195980.jpg",
    "https://www.mheducation.es/media/wysiwyg/Spain/Newsletter/Post/las-matematicas-lo-explican-todo-600.jpg",
    "https://img2.rtve.es/i/?w=1600&i=1386350163529.jpg",
    "https://concepto.de/wp-content/uploads/2013/08/matematicas-e1551990322160-800x399.jpg",
    "https://fotos.perfil.com/2022/03/11/trim/950/534/dia-internacional-de-las-matematicas-20220311-1325116.jpg",
    "https://s2.ppllstatics.com/laverdad/www/multimedia/202005/08/media/cortadas/984X608-matematicas-kaQG-U11087194903WZF-984x608@RC.jpg",

    "https://ichef.bbci.co.uk/news/640/cpsprodpb/164EE/production/_109347319_gettyimages-611195980.jpg",
    "https://www.mheducation.es/media/wysiwyg/Spain/Newsletter/Post/las-matematicas-lo-explican-todo-600.jpg",
    "https://img2.rtve.es/i/?w=1600&i=1386350163529.jpg",
    "https://concepto.de/wp-content/uploads/2013/08/matematicas-e1551990322160-800x399.jpg",
    "https://fotos.perfil.com/2022/03/11/trim/950/534/dia-internacional-de-las-matematicas-20220311-1325116.jpg",
    "https://s2.ppllstatics.com/laverdad/www/multimedia/202005/08/media/cortadas/984X608-matematicas-kaQG-U11087194903WZF-984x608@RC.jpg",
  ];

  final List<String> cards_list_ing = [
    "https://www.conmishijos.com/assets/posts/14000/14660-textos-en-ingles-para-ninos-de-primaria.jpg",
    "https://www.britishcouncil.org.mx/sites/default/files/banderas_ingles_britanico_y_americano_.png",
    "https://nosoloidiomas.com/wp-content/uploads/2014/05/UKUSA-e1400771755875.jpg",
    "https://thumbs.dreamstime.com/b/concepto-ingl%C3%A9s-de-la-ense%C3%B1anza-de-idiomas-de-brit%C3%A1nicos-inglaterra-58368527.jpg",
    "https://www.conmishijos.com/assets/posts/14000/14820-40-adivinanzas-para-ninos-en-ingles-con-traduccio.jpg",
    "https://colombianabroad.com/wp-content/uploads/aprender-ingles-online.jpg",
    "https://www.conmishijos.com/assets/posts/14000/14660-textos-en-ingles-para-ninos-de-primaria.jpg",
    "https://www.britishcouncil.org.mx/sites/default/files/banderas_ingles_britanico_y_americano_.png",
    "https://nosoloidiomas.com/wp-content/uploads/2014/05/UKUSA-e1400771755875.jpg",
    "https://thumbs.dreamstime.com/b/concepto-ingl%C3%A9s-de-la-ense%C3%B1anza-de-idiomas-de-brit%C3%A1nicos-inglaterra-58368527.jpg",
    "https://www.conmishijos.com/assets/posts/14000/14820-40-adivinanzas-para-ninos-en-ingles-con-traduccio.jpg",
    "https://colombianabroad.com/wp-content/uploads/aprender-ingles-online.jpg",
  ];

  // en esta lista guardaremos las dos primeras cartas tocadas y validar si son compatibles o no
  List<Map<int, String>> matchCheck = [];

  final int cardCount = 12;

  void initGame() {
    cards_list_mat.shuffle(); // reorganiza la lista de imágenes aleatoriamente
    cards_list_ing.shuffle(); // reorganiza la lista de imágenes aleatoriamente

    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
