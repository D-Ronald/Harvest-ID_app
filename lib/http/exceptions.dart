//caso a URL nao seja encontrada
class NotFounsException implements Exception {
  final String mensagem;

  NotFounsException(this.mensagem);
}
