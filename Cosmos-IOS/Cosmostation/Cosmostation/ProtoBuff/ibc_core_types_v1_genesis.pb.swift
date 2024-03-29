// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: ibc/core/types/v1/genesis.proto
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

/// GenesisState defines the ibc module's genesis state.
struct Ibc_Core_Types_V1_GenesisState {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// ICS002 - Clients genesis state
  var clientGenesis: Ibc_Core_Client_V1_GenesisState {
    get {return _clientGenesis ?? Ibc_Core_Client_V1_GenesisState()}
    set {_clientGenesis = newValue}
  }
  /// Returns true if `clientGenesis` has been explicitly set.
  var hasClientGenesis: Bool {return self._clientGenesis != nil}
  /// Clears the value of `clientGenesis`. Subsequent reads from it will return its default value.
  mutating func clearClientGenesis() {self._clientGenesis = nil}

  /// ICS003 - Connections genesis state
  var connectionGenesis: Ibc_Core_Connection_V1_GenesisState {
    get {return _connectionGenesis ?? Ibc_Core_Connection_V1_GenesisState()}
    set {_connectionGenesis = newValue}
  }
  /// Returns true if `connectionGenesis` has been explicitly set.
  var hasConnectionGenesis: Bool {return self._connectionGenesis != nil}
  /// Clears the value of `connectionGenesis`. Subsequent reads from it will return its default value.
  mutating func clearConnectionGenesis() {self._connectionGenesis = nil}

  /// ICS004 - Channel genesis state
  var channelGenesis: Ibc_Core_Channel_V1_GenesisState {
    get {return _channelGenesis ?? Ibc_Core_Channel_V1_GenesisState()}
    set {_channelGenesis = newValue}
  }
  /// Returns true if `channelGenesis` has been explicitly set.
  var hasChannelGenesis: Bool {return self._channelGenesis != nil}
  /// Clears the value of `channelGenesis`. Subsequent reads from it will return its default value.
  mutating func clearChannelGenesis() {self._channelGenesis = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _clientGenesis: Ibc_Core_Client_V1_GenesisState? = nil
  fileprivate var _connectionGenesis: Ibc_Core_Connection_V1_GenesisState? = nil
  fileprivate var _channelGenesis: Ibc_Core_Channel_V1_GenesisState? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "ibc.core.types.v1"

extension Ibc_Core_Types_V1_GenesisState: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GenesisState"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "client_genesis"),
    2: .standard(proto: "connection_genesis"),
    3: .standard(proto: "channel_genesis"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._clientGenesis)
      case 2: try decoder.decodeSingularMessageField(value: &self._connectionGenesis)
      case 3: try decoder.decodeSingularMessageField(value: &self._channelGenesis)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._clientGenesis {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if let v = self._connectionGenesis {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    if let v = self._channelGenesis {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Ibc_Core_Types_V1_GenesisState, rhs: Ibc_Core_Types_V1_GenesisState) -> Bool {
    if lhs._clientGenesis != rhs._clientGenesis {return false}
    if lhs._connectionGenesis != rhs._connectionGenesis {return false}
    if lhs._channelGenesis != rhs._channelGenesis {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
