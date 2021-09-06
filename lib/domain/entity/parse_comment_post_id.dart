// ! Почему-то именно в ответе на comment postId приходит как строка
// ? Это они специально так сделали? ;)
// * Пришлось немного извратиться

dynamic parsePostIdToString(dynamic rawPostId) {
  if (rawPostId is String) return int.tryParse(rawPostId);
  return rawPostId as int;
}
