// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_sync_flutter_libs/objectbox_sync_flutter_libs.dart';

import 'model/item_model.dart';
import 'model/order_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 9190354020282180762),
      name: 'OrderModel',
      lastPropertyId: const IdUid(3, 499343269968855219),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4227816079674536007),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5385051339956728661),
            name: 'ordered',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[
        ModelBacklink(name: 'items', srcEntity: 'ItemModel', srcField: '')
      ]),
  ModelEntity(
      id: const IdUid(2, 7462262003180827668),
      name: 'ItemModel',
      lastPropertyId: const IdUid(4, 6421092094816906421),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6108253272188760063),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7530017266584839107),
            name: 'itemName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 2550601136076503650),
            name: 'itemCount',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6421092094816906421),
            name: 'orderModelId',
            type: 11,
            flags: 520,
            indexId: const IdUid(2, 7895846162517459628),
            relationTarget: 'OrderModel')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 7462262003180827668),
      lastIndexId: const IdUid(2, 7895846162517459628),
      lastRelationId: const IdUid(1, 2890203085051585658),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [5753645013015600077],
      retiredPropertyUids: const [499343269968855219],
      retiredRelationUids: const [2890203085051585658],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    OrderModel: EntityDefinition<OrderModel>(
        model: _entities[0],
        toOneRelations: (OrderModel object) => [],
        toManyRelations: (OrderModel object) => {
              RelInfo<ItemModel>.toOneBacklink(4, object.id,
                  (ItemModel srcObject) => srcObject.orderModel): object.items
            },
        getId: (OrderModel object) => object.id,
        setId: (OrderModel object, int id) {
          object.id = id;
        },
        objectToFB: (OrderModel object, fb.Builder fbb) {
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addBool(1, object.ordered);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = OrderModel()
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0)
            ..ordered =
                const fb.BoolReader().vTableGet(buffer, rootOffset, 6, false);
          InternalToManyAccess.setRelInfo(
              object.items,
              store,
              RelInfo<ItemModel>.toOneBacklink(
                  4, object.id, (ItemModel srcObject) => srcObject.orderModel),
              store.box<OrderModel>());
          return object;
        }),
    ItemModel: EntityDefinition<ItemModel>(
        model: _entities[1],
        toOneRelations: (ItemModel object) => [object.orderModel],
        toManyRelations: (ItemModel object) => {},
        getId: (ItemModel object) => object.id,
        setId: (ItemModel object, int id) {
          object.id = id;
        },
        objectToFB: (ItemModel object, fb.Builder fbb) {
          final itemNameOffset = fbb.writeString(object.itemName);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, itemNameOffset);
          fbb.addInt64(2, object.itemCount);
          fbb.addInt64(3, object.orderModel.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = ItemModel(
              itemCount:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0),
              itemName:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          object.orderModel.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
          object.orderModel.attach(store);
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [OrderModel] entity fields to define ObjectBox queries.
class OrderModel_ {
  /// see [OrderModel.id]
  static final id =
      QueryIntegerProperty<OrderModel>(_entities[0].properties[0]);

  /// see [OrderModel.ordered]
  static final ordered =
      QueryBooleanProperty<OrderModel>(_entities[0].properties[1]);
}

/// [ItemModel] entity fields to define ObjectBox queries.
class ItemModel_ {
  /// see [ItemModel.id]
  static final id = QueryIntegerProperty<ItemModel>(_entities[1].properties[0]);

  /// see [ItemModel.itemName]
  static final itemName =
      QueryStringProperty<ItemModel>(_entities[1].properties[1]);

  /// see [ItemModel.itemCount]
  static final itemCount =
      QueryIntegerProperty<ItemModel>(_entities[1].properties[2]);

  /// see [ItemModel.orderModel]
  static final orderModel =
      QueryRelationToOne<ItemModel, OrderModel>(_entities[1].properties[3]);
}
