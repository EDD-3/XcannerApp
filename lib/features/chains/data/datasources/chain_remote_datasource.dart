import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:xcanner_app/core/errors/exceptions.dart';
import 'package:xcanner_app/features/chains/data/models/chain_model.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

abstract class ChainRemoteDatasource {
  Future<List<ChainModel>> getChainList();
  Future<ChainModel> getChain(int id);
}

class ChainRemoteDatasourceImpl implements ChainRemoteDatasource {
  final http.Client client;

  ChainRemoteDatasourceImpl({
    @required this.client,
  });

  @override
  Future<List<ChainModel>> getChainList() async {
    final url = Platform.isAndroid
        ? 'http://127.0.0.1:4444/api/categories'
        : 'http://localhost:4444/api/categories';

    final response = await client.get(url);
    switch (response.statusCode) {
      case 200:
        final result = jsonDecode(response.body);
        final Iterable list = result;
        return list.map((model) => ChainModel.fromJson(model)).toList();

      default:
        throw ServerException(
          code: response.statusCode,
          message: response.reasonPhrase,
        );
    }
  }

  @override
  Future<ChainModel> getChain(int id) async {
    final url = Platform.isAndroid
        ? 'http://127.0.0.1:4444/api/category/$id'
        : 'http://localhost:4444/api/category/$id';

    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    switch (response.statusCode) {
      case 200:
        final result = jsonDecode(response.body);
        return ChainModel.fromJson(result);
      default:
        throw ServerException(
          code: response.statusCode,
          message: response.reasonPhrase,
        );
    }
  }
}
