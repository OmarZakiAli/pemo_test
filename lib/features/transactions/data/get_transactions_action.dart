import 'package:api_request/api_request.dart';
import 'package:test_repo/features/transactions/data/dto/transaction_dto.dart';

class GetTransactionsAction extends ApiRequestAction<List<TransactionDto>> {
  @override
  RequestMethod get method => RequestMethod.GET;

  @override
  String get path => "transaction";

  @override
  ResponseBuilder<List<TransactionDto>> get responseBuilder => (json) {
        return List<TransactionDto>.from(
            json.map((item) => TransactionDto.fromMap(item)));
      };
}
