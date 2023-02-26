import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'producto_record.g.dart';

abstract class ProductoRecord
    implements Built<ProductoRecord, ProductoRecordBuilder> {
  static Serializer<ProductoRecord> get serializer =>
      _$productoRecordSerializer;

  String? get nombew;

  double? get precio;

  int? get cantidad;

  String? get imagen;

  DocumentReference? get categoria;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(ProductoRecordBuilder builder) => builder
    ..nombew = ''
    ..precio = 0.0
    ..cantidad = 0
    ..imagen = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Producto');

  static Stream<ProductoRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<ProductoRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  ProductoRecord._();
  factory ProductoRecord([void Function(ProductoRecordBuilder) updates]) =
      _$ProductoRecord;

  static ProductoRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createProductoRecordData({
  String? nombew,
  double? precio,
  int? cantidad,
  String? imagen,
  DocumentReference? categoria,
}) {
  final firestoreData = serializers.toFirestore(
    ProductoRecord.serializer,
    ProductoRecord(
      (p) => p
        ..nombew = nombew
        ..precio = precio
        ..cantidad = cantidad
        ..imagen = imagen
        ..categoria = categoria,
    ),
  );

  return firestoreData;
}
