class ViewState<T> {
  Status? status;

  T? data;

  String? message;

  Type? type;

  ViewState.loading() : status = Status.loading;

  ViewState.completed(this.data) : status = Status.completed;

  ViewState.error(this.message, this.type) : status = Status.error;

  ViewState();

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { loading, completed, error }

enum Type { connection, other }
