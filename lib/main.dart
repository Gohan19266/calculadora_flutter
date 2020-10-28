import 'package:flutter/material.dart';
import 'package:flutter_vscode/btns.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //operations

  var userQuestion= '';
  var userAnswer = '';

  //datos calculator
  final List<String> btns=[
    'C','DEL','%','/',
    '9','8','7','x',
    '6','5','4','-',
    '3','2','1','+',
    '0','.','ANS','=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.deepPurple[100],
      body:Column(
        children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:<Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(userQuestion, style: TextStyle(fontSize:20),),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(userAnswer,style: TextStyle(fontSize:20),),
                    ),
                  ]
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                  itemCount: btns.length,
                  
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2
                  ), 
                  itemBuilder: (BuildContext context, int index){
                    if(index ==0){
                      return MyBtns(
                      btnTapped: (){
                         setState((){
                           userQuestion = '';
                         });
                      },
                      btnText:btns[index],
                      color:Colors.green,
                      textColor: Colors.white,
                      );
                    }else if(index==1){
                      //Delete fka1
                      return MyBtns(
                      btnTapped: (){
                        setState((){
                          userQuestion = userQuestion.substring(0,userQuestion.length-1);
                        });
                      },
                      btnText:btns[index],
                      color:Colors.red,
                      textColor: Colors.white,);
                    }
                    //Equeal button
                    else if(index==btns.length-1){
                      //Delete fka1
                      return MyBtns(
                      btnTapped: (){
                        setState((){
                          operation();
                        });
                      },
                      btnText:btns[index],
                      color:Colors.red,
                      textColor: Colors.white,);
                    }
                    
                    else{
                      return MyBtns(
                      btnTapped: (){
                        setState((){
                          userQuestion +=  btns[index];
                        });
                      },
                      btnText:btns[index],
                      color:isOperate(btns[index]) ? Colors.blue:Colors.blue[100],
                      textColor: isOperate(btns[index]) ? Colors.white:Colors.deepPurple,
                      );
                    }
                  }),
              ),
            ),
          ],
      )
    );
  }
  bool isOperate(String x){
    if(x =='%'||x =='/'||x =='x'||x =='-'||x =='+'||x =='='){
      return true;
    }
    return false;
  }
  void operation(){
    String finalQuestion = userQuestion;
    finalQuestion =finalQuestion.replaceAll('x','*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);

    ContextModel cm = ContextModel();
    double eva = exp.evaluate(EvaluationType.REAL,cm);
    userAnswer = eva.toString();
  }
}
