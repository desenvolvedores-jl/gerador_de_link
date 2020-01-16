import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:link_generate/helpers/links_helpers.dart';
import 'package:link_generate/screen/components/components_screen.dart';

import 'components/tile_list.dart';

List<Link> links = List();

LinkHelper helper = LinkHelper();

class GeneratorLink extends StatefulWidget {
  @override
  _GeneratorLinkState createState() => _GeneratorLinkState();
}

class _GeneratorLinkState extends State<GeneratorLink> {

  final _controllerPrefix = TextEditingController();
  final _controllerNumber = TextEditingController();
  final _controllerMessage = TextEditingController();

  String number = "";
  String message = "";
  String prefix = "";
  String url = "";
  String title = "";

  bool _qtdList = false;

    @override
  void initState() {
    super.initState();
    _VerificaLista();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
            Container(
            height: 290,
              padding: EdgeInsets.symmetric(horizontal: 17),
              decoration: BoxDecoration(
                 gradient:  LinearGradient(
                  end: Alignment.topLeft,
                  begin: Alignment.bottomRight,
                  colors: [Color(0xff15A544),
                    Color(0xff046E27)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.00),
                bottomRight: Radius.circular(20.00),
              ),
        ),
          child: Column(
              children: <Widget>[
                SizedBox(height: 40,),
                Text("Link WhatsApp", style: TextStyle(
                  color: Colors.white,
                  fontSize: 20, 
                  fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 35,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                        Container(
                          width:60,
                          child: buidTextForm(_controllerPrefix,  "Prefixo",
                            "+55", TextInputType.phone, TextInputAction.next,),
                        ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: buidTextForm(_controllerNumber, "Número do WhatsApp", "Ex: 11 93344-1122", 
                         TextInputType.phone, TextInputAction.next),
                      ),
                    ],
                  ),
                  buidTextForm(_controllerMessage, "Mensagem (opcional)",  "Escreva o texto",
                   TextInputType.text, TextInputAction.done,),
                  SizedBox(height: 15,),
                  Row(
                    children: <Widget>[
                      Expanded(child: Container(),),
                      FlatButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){
                          _SaveModel();  
                         },
                        child: Text("Gerar Link",
                         style: TextStyle(
                            color: Colors.white,
                            fontSize: 20, 
                            ),
                        ), 
                      ),
                    ],
                  ),
              ],
          ), 
        ),
        _qtdList == false ? 
          listVazia() :
            Expanded(
                child: ListView.builder(
                itemCount: links.length,
                reverse: false,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: buildCard(
                      context,
                      links[index].title,
                      links[index].phone,
                      (){
                        _DeleteModel(index);
                      },
                      links[index].url,
                      ),
                  );
              },
      ),
            ),
      ],
    );
  }
  void _SaveModel(){
    if(_controllerNumber.text == "" || _controllerPrefix.text == ""){
      Clipboard.setData(new ClipboardData());
      final snackBar = SnackBar(
        content: Text("E-mail ou senha invalido!"),
        backgroundColor: Colors.red,
      );
      Scaffold.of(context).showSnackBar(snackBar);
      print("Prefixo ou número");
    }else{
        _GeneratorModel();
        LinkHelper helper = LinkHelper();
        Link l = Link();
        l.phone = "+$prefix $number";
        l.url = url; 
        l.title = title == "" ? "Mensagem em branco" : title;
        helper.saveLink(l);
      _VerificaLista();
    }
  }
  void _GeneratorModel(){
      number = _controllerNumber.text.trim();
      message = _controllerMessage.text;
      prefix = _controllerPrefix.text.trim(); 
      title = _controllerMessage.text.trim();
      FocusScope.of(context).requestFocus(new FocusNode());
      url = "https://api.whatsapp.com/send?phone=$prefix$number&text=$message";

      _controllerMessage.text = "";
      _controllerNumber.text = "";
      _controllerPrefix.text = "";
  }

  void _DeleteModel(int index) async{
  await helper.deleteLink(links[index].id);
  links.removeAt(index);
  _VerificaLista();
}

 void _VerificaLista(){
     helper.getAllLink().then((list){
      setState((){
        if(list.length == 0){
          _qtdList = false; 
        }else{
          _qtdList = true;
          links = list.reversed.toList(); 
        }
    });
  });

 }
 
}


