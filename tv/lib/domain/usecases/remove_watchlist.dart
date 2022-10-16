import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class RemoveWatchlistTv {
  final TvRepository repository;

  RemoveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
