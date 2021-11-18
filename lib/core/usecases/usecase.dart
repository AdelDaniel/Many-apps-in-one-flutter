import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

/// what is the params
/// >> Parameters have to be put into a container object so that they can be
/// Every UseCase extending class will define the parameters
/// which get passed into the call method as a separate class inside the same file.
///
// included in this abstract base class method definition.
abstract class UseCase<Type, Params> {
  const UseCase();
  Future<Either<Failure, Type>> call(Params params);
}

// an example of params >> This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters.
class NoParams extends Equatable {
  const NoParams();
  @override
  List<Object?> get props => const [];
}
