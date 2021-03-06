import 'package:cookiej/cookiej/config/config.dart';
import 'package:cookiej/cookiej/page/widget/weibo/weibo_list_mixin.dart';
import 'package:cookiej/cookiej/page/widget/weibo/weibo_widget.dart';
import 'package:flutter/material.dart';

class HotPgae extends StatefulWidget {
  @override
  _HotPgaeState createState() => _HotPgaeState();
}

class _HotPgaeState extends State<HotPgae> with WeiboListMixin,AutomaticKeepAliveClientMixin {


  @override
  void initState() {
    weiboListInit(WeiboTimelineType.Public,extraParams: {});
    isStartLoadDataComplete=startLoadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: isStartLoadDataComplete,
      builder: (context,snaphot){
        if(snaphot.hasError){
          return Container(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                SizedBox(height: 16),
                Text(snaphot.error.toString()),
                SizedBox(height: 16),
                RaisedButton(
                  child: Text('刷新试试'),
                  onPressed: (){
                    setState(() {
                      isStartLoadDataComplete=startLoadData();
                    });
                  }
                ),
                SizedBox(height: 16),
              ]
            )
          );
        }
        if(snaphot.data!=WeiboListStatus.complete) return Center(child:CircularProgressIndicator());
        if(weiboList.isEmpty) return Center(child:Text('没有找到微博'));
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: weiboList.length,
          itemBuilder: (context,index){
            return Container(
              //child: Container(height:100,color:Colors.green),
              child:WeiboWidget(weiboList[index]),
              margin: EdgeInsets.only(bottom:12),
            );
          },
        );
      }
    );
    
  }

  @override
  bool get wantKeepAlive => true;
}