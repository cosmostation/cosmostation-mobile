// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: akash/deployment/v1beta1/genesis.proto
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

/// GenesisDeployment defines the basic genesis state used by deployment module
struct Akash_Deployment_V1beta1_GenesisDeployment {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var deployment: Akash_Deployment_V1beta1_Deployment {
    get {return _deployment ?? Akash_Deployment_V1beta1_Deployment()}
    set {_deployment = newValue}
  }
  /// Returns true if `deployment` has been explicitly set.
  var hasDeployment: Bool {return self._deployment != nil}
  /// Clears the value of `deployment`. Subsequent reads from it will return its default value.
  mutating func clearDeployment() {self._deployment = nil}

  var groups: [Akash_Deployment_V1beta1_Group] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _deployment: Akash_Deployment_V1beta1_Deployment? = nil
}

/// GenesisState stores slice of genesis deployment instance
struct Akash_Deployment_V1beta1_GenesisState {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var deployments: [Akash_Deployment_V1beta1_GenesisDeployment] = []

  var params: Akash_Deployment_V1beta1_Params {
    get {return _params ?? Akash_Deployment_V1beta1_Params()}
    set {_params = newValue}
  }
  /// Returns true if `params` has been explicitly set.
  var hasParams: Bool {return self._params != nil}
  /// Clears the value of `params`. Subsequent reads from it will return its default value.
  mutating func clearParams() {self._params = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _params: Akash_Deployment_V1beta1_Params? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "akash.deployment.v1beta1"

extension Akash_Deployment_V1beta1_GenesisDeployment: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GenesisDeployment"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "deployment"),
    2: .same(proto: "groups"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._deployment)
      case 2: try decoder.decodeRepeatedMessageField(value: &self.groups)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._deployment {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if !self.groups.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.groups, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Akash_Deployment_V1beta1_GenesisDeployment, rhs: Akash_Deployment_V1beta1_GenesisDeployment) -> Bool {
    if lhs._deployment != rhs._deployment {return false}
    if lhs.groups != rhs.groups {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Akash_Deployment_V1beta1_GenesisState: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".GenesisState"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "deployments"),
    2: .same(proto: "params"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeRepeatedMessageField(value: &self.deployments)
      case 2: try decoder.decodeSingularMessageField(value: &self._params)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.deployments.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.deployments, fieldNumber: 1)
    }
    if let v = self._params {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Akash_Deployment_V1beta1_GenesisState, rhs: Akash_Deployment_V1beta1_GenesisState) -> Bool {
    if lhs.deployments != rhs.deployments {return false}
    if lhs._params != rhs._params {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
