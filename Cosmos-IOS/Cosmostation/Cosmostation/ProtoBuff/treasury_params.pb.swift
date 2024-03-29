// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: treasury/params.proto
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

/// Params defines the parameters for the treasury module
struct Rizonworld_Rizon_Treasury_Params {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// mintable indicates whether every currencie of treasury module are able to mint or not
  var mintable: Bool = false

  /// sequence of currency state
  var sequence: Int64 = 0

  /// currency_list is the list of supported currencies
  var currencyList: [Rizonworld_Rizon_Treasury_Currency] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "rizonworld.rizon.treasury"

extension Rizonworld_Rizon_Treasury_Params: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Params"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "mintable"),
    2: .same(proto: "sequence"),
    3: .standard(proto: "currency_list"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularBoolField(value: &self.mintable)
      case 2: try decoder.decodeSingularInt64Field(value: &self.sequence)
      case 3: try decoder.decodeRepeatedMessageField(value: &self.currencyList)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.mintable != false {
      try visitor.visitSingularBoolField(value: self.mintable, fieldNumber: 1)
    }
    if self.sequence != 0 {
      try visitor.visitSingularInt64Field(value: self.sequence, fieldNumber: 2)
    }
    if !self.currencyList.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.currencyList, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Rizonworld_Rizon_Treasury_Params, rhs: Rizonworld_Rizon_Treasury_Params) -> Bool {
    if lhs.mintable != rhs.mintable {return false}
    if lhs.sequence != rhs.sequence {return false}
    if lhs.currencyList != rhs.currencyList {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
