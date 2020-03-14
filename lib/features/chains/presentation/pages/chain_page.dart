import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcanner_app/features/chains/domain/usecases/get_chain_list.dart';
import 'package:xcanner_app/features/chains/presentation/bloc/bloc.dart';
import 'package:xcanner_app/features/chains/presentation/widgets/widgets.dart';
import 'package:xcanner_app/injection_container.dart';

class ChainPage extends StatefulWidget {
  const ChainPage({Key key}) : super(key: key);

  @override
  _ChainPageState createState() => _ChainPageState();
}

class _ChainPageState extends State<ChainPage> {
  ChainsBloc _bloc;
  String inputStr;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = sl<ChainsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Xcanner'),
      ),
      body: buildBlocProvider(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _bloc.add(GetChainsEvent());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  BlocProvider<ChainsBloc> buildBlocProvider(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Input a number',
                ),
                onChanged: (value) {
                  inputStr = value;
                },
                onSubmitted: (_) {
                   _bloc.add(GetChainByIdEvent(inputStr));
                },
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                      child: RaisedButton(
                    child: Text('Search'),
                    color: Theme.of(context).accentColor,
                    textTheme: ButtonTextTheme.primary,
                    onPressed: () {
                      _bloc.add(GetChainByIdEvent(inputStr));
                    },
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: RaisedButton(
                    child: Text('Buscar'),
                    onPressed: () {
                      // dispatchRandom();
                    },
                  ))
                ],
              )
            ],
          ),
          Center(
            child:
                BlocBuilder<ChainsBloc, ChainsState>(builder: (context, state) {
              if (state is InitialChainsState) {
                return MessageDisplay(
                  message: 'Start searching!',
                );
              } else if (state is ChainErrorState) {
                return MessageDisplay(
                  message: state.errorMessage,
                );
              } else if (state is ChainsLoadingState) {
                return LoadingWidget();
              } else if (state is ChainsLoadedState) {
                if (state.chainList == null) return Container();
                return Text(
                  state.chainList[0].chainName,
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1.0,
                    color: Colors.black87,
                  ),
                );
              } else if (state is ChainLoadedState) {

                if (state.chain == null) return Text(
                  'Sin resultado',
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1.0,
                    color: Colors.black87,
                  ),
                );
                return Text(
                  state.chain.chainName,
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1.0,
                    color: Colors.black87,
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
