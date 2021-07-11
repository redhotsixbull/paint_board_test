import 'package:flutter/material.dart';
import 'package:paint_board_test/models/save_board.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveListPage extends StatefulWidget {
  const SaveListPage({Key key}) : super(key: key);

  @override
  _SaveListPageState createState() => _SaveListPageState();
}

class _SaveListPageState extends State<SaveListPage> {
  Future<SaveBoardList> _future;

  @override
  void initState() {
    super.initState();
    _future = loadJsonData();
  }

  Future<SaveBoardList> loadJsonData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SaveBoardList saveBoardList;
    List<String> indexList;

    indexList = setIndexInIndexList(prefs);

    saveBoardList = setSaveBoardListInSaveBoard(indexList, prefs);

    return saveBoardList;
  }

  setIndexInIndexList(SharedPreferences prefs) {
    List<String> indexList = List<String>();
    indexList = prefs.getStringList("index");
    return indexList;
  }

  setSaveBoardListInSaveBoard(List<String> indexList, SharedPreferences prefs) {
    SaveBoardList saveBoardList = SaveBoardList(List<SaveBoard>());
    for (var index in indexList) {
      String boardName = prefs.getString(indexList[int.parse(index)]);
      saveBoardList.list.add(SaveBoard(index, boardName));
    }
    return saveBoardList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<SaveBoardList>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.list.length,
                  itemBuilder: (BuildContext context, index) {
                    String indexTitle = snapshot.data.list[index].index;
                    String boardName = snapshot.data.list[index].boardName;

                    if (indexTitle == null) indexTitle = "";
                    if (boardName == null) boardName = "";

                    return ListTile(
                      onTap: () {
                        Navigator.of(context).pop(boardName);
                      },
                      title: Text(indexTitle),
                      subtitle: Text(boardName),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
