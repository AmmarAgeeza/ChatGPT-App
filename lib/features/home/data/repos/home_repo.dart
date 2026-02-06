import 'package:chatgpt_app/features/home/data/models/home_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/database/api/api_consumer.dart';
import '../../../../core/database/api/end_points.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/services/service_locator.dart';

class HomeRepo {
  Future<Either<String, HomeModel>> getVendorOrders(String text) async {
    try {
      final res = await sl<ApiConsumer>().post(
        EndPoints.apiKey,
        body: {
          "contents": [
            {
              "parts": [
                {"text": text},
              ],
            },
          ],
        },
      );
      return Right(HomeModel.fromJson(res));
    } on ServerException catch (e) {
      return Left(e.errorMessage);
    }
  }
}
