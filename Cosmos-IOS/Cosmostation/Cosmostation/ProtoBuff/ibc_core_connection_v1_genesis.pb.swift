// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: ibc/core/connection/v1/genesis.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

/// GenesisState defines the ibc connection submodule's genesis state.
struct Ibc_Core_Connection_V1_GenesisState {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var connections: [Ibc_Core_Connection_V1_IdentifiedConnection] = []

  var clientConnectionPaths: [Ibc_Core_Connection_V1_ConnectionPaths] = []

  /// the sequence for the next generated connection identifier
  var nextConnectionSequence: UInt64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "ibc.core.connection.v1"

extension Ibc_Core_Connection_V1_GenesisState: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GenesisState"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "connections"),
    2: .standard(proto: "client_connection_paths"),
    3: .standard(proto: "next_connection_sequence"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedMessageField(value: &self.connections)
      case 2: try decoder.decodeRepeatedMessageField(value: &self.clientConnectionPaths)
      case 3: try decoder.decodeSingularUInt64Field(value: &self.nextConnectionSequence)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.connections.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.connections, fieldNumber: 1)
    }
    if !self.clientConnectionPaths.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.clientConnectionPaths, fieldNumber: 2)
    }
    if self.nextConnectionSequence != 0 {
      try visitor.visitSingularUInt64Field(value: self.nextConnectionSequence, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Ibc_Core_Connection_V1_GenesisState, rhs: Ibc_Core_Connection_V1_GenesisState) -> Bool {
    if lhs.connections != rhs.connections {return false}
    if lhs.clientConnectionPaths != rhs.clientConnectionPaths {return false}
    if lhs.nextConnectionSequence != rhs.nextConnectionSequence {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
