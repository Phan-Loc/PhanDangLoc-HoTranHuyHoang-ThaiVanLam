import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_edmt_quiz_app/database/category_provider.dart';
import 'package:flutter_edmt_quiz_app/database/db_helper.dart';
import '../edit_profile.dart';
import '../login_signup.dart';
import '../settings.dart';
import 'file:///C:/Users/Admin/AndroidStudioProjects/flutter_edmt_quiz_app/lib/new_page.dart';
import 'package:flutter_edmt_quiz_app/state/state_manager.dart';
import 'package:flutter_riverpod/all.dart';

class MyCategoryPage extends StatefulWidget {
  MyCategoryPage({Key key, this.title}) : super(key: key);
  final String title;


  @override
  State<StatefulWidget> createState() => _MyCategoryPageState();
}


class _MyCategoryPageState extends State<MyCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text("Phan Dang Loc"),
                accountEmail: new Text("pdloc.17it3@vku.udn.vn"),
                currentAccountPicture: new Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage( "images/dog.jpg"),
                          fit: BoxFit.fill
                      )
                  ),
                ),
                otherAccountsPictures: <Widget>[
                  new Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/que.png"),
                              fit: BoxFit.fill
                          )
                      ),
                    )
                ],
              ),
              new ListTile(
                title: new Text("Trang chủ"),
                trailing: new Icon(Icons.home_outlined),
                onTap: () => Navigator.of(context).pop(),
                  ),
                  new ListTile(
                  title: new Text("Tài khoản"),
                  trailing: new Icon(Icons.supervised_user_circle_outlined),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => NewPage("Tài khoản"),
                      ));
                    },
                  ),
                  new ListTile(
                  title: new Text("Cài đặt"),
                  trailing: new Icon(Icons.settings),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SettingsPage("Cài Đặt"),
                      ));
                    },
                  ),
                  new ListTile(
                  title: new Text("Trợ giúp"),
                  trailing: new Icon(Icons.question_answer),
                  ),
                  new Divider(),
                  new ListTile(

                title: new Text("Thoát"),
                trailing: new Icon(Icons.close),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => LoginSignupScreen(),
                      ));
                    },
              ),
            ],
          )
        ),
        body: FutureBuilder<List<Category>>(
          future: getCategoryes(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(
                child: Text('${snapshot.error}'),
              );
            else if (snapshot.hasData) {
              Category category = new Category();
              category.ID = -1;
              category.name = "Làm bài";
              snapshot.data.add(category);
              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                padding: const EdgeInsets.all(4.0),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                children: snapshot.data.map((category) {
                  return GestureDetector(
                    child: Card(
                      elevation: 2,
                      color: category.ID == -1 ? Colors.green : Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: AutoSizeText(
                              '${category.name}',
                              style: TextStyle(
                                  color: category.ID == -1
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      context.read(questionCategoryState).state = category;
                      if (category.ID != -1) // if not equal 'Examp'
                      {
                        context.read(isTestMode).state = false;
                        Navigator.pushNamed(context, "/readMode");
                      }
                      else
                        {
                          context.read(isTestMode).state = true;
                          Navigator.pushNamed(context, "/testMode");
                        }
                    },
                  );
                }).toList(),
              );
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          },
        ));
  }

  Future<List<Category>> getCategoryes() async {
    var db = await copyDB();
    var result = await CategoryProvider().getCategories(db);
    context.read(categoryListProvider).state = result;
    return result;
  }
}
