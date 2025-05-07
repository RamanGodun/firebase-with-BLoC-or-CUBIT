🔧 Приклади використання:

// Класичний варіант:
final result = await getUserUseCase();
result.fold(
  (f) => emit(Failed(f)),
  (u) => emit(Loaded(u)),
);







// DSL-подібна альтернатива 1 (без ResultHandler):
await getUserUseCase().matchAsync(
  onFailure: (f) => emit(Failed(f)),
  onSuccess: (u) => emit(Loaded(u)),
);

// DSL-подібна альтернатива 2 (через ResultHandler):
await getUserUseCase().then((r) => ResultHandler(r)
  .onFailure((f) => emit(Failed(f)))
  .onSuccess((u) => emit(Loaded(u))));



// Advanced:
await getUserUseCase()
  .flatMapAsync((u) => checkAccess(u))
  .recover((f) => getGuestUser())
  .mapRightAsync((u) => saveLocally(u))
  .then((r) => ResultHandler(r).log());