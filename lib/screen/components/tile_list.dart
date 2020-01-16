import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
 
 Widget buildCard(BuildContext context, title, String phone, Function function, String link){
    return Dismissible(
      onDismissed: (direction){
        function();
      },
      direction: DismissDirection.startToEnd,
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
         decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8.00), 
         ),
         margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete_outline, color: Colors.white,),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0.00,2.00),
                        color: Color(0xff000000).withOpacity(0.16),
                        blurRadius: 3,
                     ),
                  ],
               borderRadius: BorderRadius.circular(8.00), 
                ),
              padding: EdgeInsets.only(top: 4, bottom: 4, left: 8),
              child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(title,
                            maxLines: 1,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(phone ?? "+00 00000000000",
                            maxLines: 1,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.share, color: Colors.grey,),
                          onPressed: (){
                            Share.share(link.replaceAll(' ', '%20'), subject: 'Meu número');
                          })
                    ],
                  ),
            ),
        ],
      ),
    );
}