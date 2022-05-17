abstract class UseCaseAbstract<Input, Output> {
  Future<Output> execute(Input input);
}
