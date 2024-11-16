import 'package:handle/handle.dart';
import 'package:healtheye/logging.dart';

void setupHandleJsonModelSerializer() {
  logging.child('setupHandleJsonModelSerializer').fine('adding deserializers');
  JsonModelSerializer.common.addDeserializers({
    // const JsonDeserializerOf<AuthRegisterFormRequest>(
    //   AuthRegisterFormRequest.fromJson,
    // ),
  });
}
