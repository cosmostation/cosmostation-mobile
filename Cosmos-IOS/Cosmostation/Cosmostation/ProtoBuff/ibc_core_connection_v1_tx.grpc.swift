//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: ibc/core/connection/v1/tx.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import SwiftProtobuf


/// Msg defines the ibc/connection Msg service.
///
/// Usage: instantiate `Ibc_Core_Connection_V1_MsgClient`, then call methods of this protocol to make API calls.
internal protocol Ibc_Core_Connection_V1_MsgClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Ibc_Core_Connection_V1_MsgClientInterceptorFactoryProtocol? { get }

  func connectionOpenInit(
    _ request: Ibc_Core_Connection_V1_MsgConnectionOpenInit,
    callOptions: CallOptions?
  ) -> UnaryCall<Ibc_Core_Connection_V1_MsgConnectionOpenInit, Ibc_Core_Connection_V1_MsgConnectionOpenInitResponse>

  func connectionOpenTry(
    _ request: Ibc_Core_Connection_V1_MsgConnectionOpenTry,
    callOptions: CallOptions?
  ) -> UnaryCall<Ibc_Core_Connection_V1_MsgConnectionOpenTry, Ibc_Core_Connection_V1_MsgConnectionOpenTryResponse>

  func connectionOpenAck(
    _ request: Ibc_Core_Connection_V1_MsgConnectionOpenAck,
    callOptions: CallOptions?
  ) -> UnaryCall<Ibc_Core_Connection_V1_MsgConnectionOpenAck, Ibc_Core_Connection_V1_MsgConnectionOpenAckResponse>

  func connectionOpenConfirm(
    _ request: Ibc_Core_Connection_V1_MsgConnectionOpenConfirm,
    callOptions: CallOptions?
  ) -> UnaryCall<Ibc_Core_Connection_V1_MsgConnectionOpenConfirm, Ibc_Core_Connection_V1_MsgConnectionOpenConfirmResponse>
}

extension Ibc_Core_Connection_V1_MsgClientProtocol {
  internal var serviceName: String {
    return "ibc.core.connection.v1.Msg"
  }

  /// ConnectionOpenInit defines a rpc handler method for MsgConnectionOpenInit.
  ///
  /// - Parameters:
  ///   - request: Request to send to ConnectionOpenInit.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func connectionOpenInit(
    _ request: Ibc_Core_Connection_V1_MsgConnectionOpenInit,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Ibc_Core_Connection_V1_MsgConnectionOpenInit, Ibc_Core_Connection_V1_MsgConnectionOpenInitResponse> {
    return self.makeUnaryCall(
      path: "/ibc.core.connection.v1.Msg/ConnectionOpenInit",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeConnectionOpenInitInterceptors() ?? []
    )
  }

  /// ConnectionOpenTry defines a rpc handler method for MsgConnectionOpenTry.
  ///
  /// - Parameters:
  ///   - request: Request to send to ConnectionOpenTry.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func connectionOpenTry(
    _ request: Ibc_Core_Connection_V1_MsgConnectionOpenTry,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Ibc_Core_Connection_V1_MsgConnectionOpenTry, Ibc_Core_Connection_V1_MsgConnectionOpenTryResponse> {
    return self.makeUnaryCall(
      path: "/ibc.core.connection.v1.Msg/ConnectionOpenTry",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeConnectionOpenTryInterceptors() ?? []
    )
  }

  /// ConnectionOpenAck defines a rpc handler method for MsgConnectionOpenAck.
  ///
  /// - Parameters:
  ///   - request: Request to send to ConnectionOpenAck.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func connectionOpenAck(
    _ request: Ibc_Core_Connection_V1_MsgConnectionOpenAck,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Ibc_Core_Connection_V1_MsgConnectionOpenAck, Ibc_Core_Connection_V1_MsgConnectionOpenAckResponse> {
    return self.makeUnaryCall(
      path: "/ibc.core.connection.v1.Msg/ConnectionOpenAck",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeConnectionOpenAckInterceptors() ?? []
    )
  }

  /// ConnectionOpenConfirm defines a rpc handler method for MsgConnectionOpenConfirm.
  ///
  /// - Parameters:
  ///   - request: Request to send to ConnectionOpenConfirm.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func connectionOpenConfirm(
    _ request: Ibc_Core_Connection_V1_MsgConnectionOpenConfirm,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Ibc_Core_Connection_V1_MsgConnectionOpenConfirm, Ibc_Core_Connection_V1_MsgConnectionOpenConfirmResponse> {
    return self.makeUnaryCall(
      path: "/ibc.core.connection.v1.Msg/ConnectionOpenConfirm",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeConnectionOpenConfirmInterceptors() ?? []
    )
  }
}

internal protocol Ibc_Core_Connection_V1_MsgClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'connectionOpenInit'.
  func makeConnectionOpenInitInterceptors() -> [ClientInterceptor<Ibc_Core_Connection_V1_MsgConnectionOpenInit, Ibc_Core_Connection_V1_MsgConnectionOpenInitResponse>]

  /// - Returns: Interceptors to use when invoking 'connectionOpenTry'.
  func makeConnectionOpenTryInterceptors() -> [ClientInterceptor<Ibc_Core_Connection_V1_MsgConnectionOpenTry, Ibc_Core_Connection_V1_MsgConnectionOpenTryResponse>]

  /// - Returns: Interceptors to use when invoking 'connectionOpenAck'.
  func makeConnectionOpenAckInterceptors() -> [ClientInterceptor<Ibc_Core_Connection_V1_MsgConnectionOpenAck, Ibc_Core_Connection_V1_MsgConnectionOpenAckResponse>]

  /// - Returns: Interceptors to use when invoking 'connectionOpenConfirm'.
  func makeConnectionOpenConfirmInterceptors() -> [ClientInterceptor<Ibc_Core_Connection_V1_MsgConnectionOpenConfirm, Ibc_Core_Connection_V1_MsgConnectionOpenConfirmResponse>]
}

internal final class Ibc_Core_Connection_V1_MsgClient: Ibc_Core_Connection_V1_MsgClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Ibc_Core_Connection_V1_MsgClientInterceptorFactoryProtocol?

  /// Creates a client for the ibc.core.connection.v1.Msg service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Ibc_Core_Connection_V1_MsgClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// Msg defines the ibc/connection Msg service.
///
/// To build a server, implement a class that conforms to this protocol.
internal protocol Ibc_Core_Connection_V1_MsgProvider: CallHandlerProvider {
  var interceptors: Ibc_Core_Connection_V1_MsgServerInterceptorFactoryProtocol? { get }

  /// ConnectionOpenInit defines a rpc handler method for MsgConnectionOpenInit.
  func connectionOpenInit(request: Ibc_Core_Connection_V1_MsgConnectionOpenInit, context: StatusOnlyCallContext) -> EventLoopFuture<Ibc_Core_Connection_V1_MsgConnectionOpenInitResponse>

  /// ConnectionOpenTry defines a rpc handler method for MsgConnectionOpenTry.
  func connectionOpenTry(request: Ibc_Core_Connection_V1_MsgConnectionOpenTry, context: StatusOnlyCallContext) -> EventLoopFuture<Ibc_Core_Connection_V1_MsgConnectionOpenTryResponse>

  /// ConnectionOpenAck defines a rpc handler method for MsgConnectionOpenAck.
  func connectionOpenAck(request: Ibc_Core_Connection_V1_MsgConnectionOpenAck, context: StatusOnlyCallContext) -> EventLoopFuture<Ibc_Core_Connection_V1_MsgConnectionOpenAckResponse>

  /// ConnectionOpenConfirm defines a rpc handler method for MsgConnectionOpenConfirm.
  func connectionOpenConfirm(request: Ibc_Core_Connection_V1_MsgConnectionOpenConfirm, context: StatusOnlyCallContext) -> EventLoopFuture<Ibc_Core_Connection_V1_MsgConnectionOpenConfirmResponse>
}

extension Ibc_Core_Connection_V1_MsgProvider {
  internal var serviceName: Substring { return "ibc.core.connection.v1.Msg" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "ConnectionOpenInit":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Ibc_Core_Connection_V1_MsgConnectionOpenInit>(),
        responseSerializer: ProtobufSerializer<Ibc_Core_Connection_V1_MsgConnectionOpenInitResponse>(),
        interceptors: self.interceptors?.makeConnectionOpenInitInterceptors() ?? [],
        userFunction: self.connectionOpenInit(request:context:)
      )

    case "ConnectionOpenTry":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Ibc_Core_Connection_V1_MsgConnectionOpenTry>(),
        responseSerializer: ProtobufSerializer<Ibc_Core_Connection_V1_MsgConnectionOpenTryResponse>(),
        interceptors: self.interceptors?.makeConnectionOpenTryInterceptors() ?? [],
        userFunction: self.connectionOpenTry(request:context:)
      )

    case "ConnectionOpenAck":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Ibc_Core_Connection_V1_MsgConnectionOpenAck>(),
        responseSerializer: ProtobufSerializer<Ibc_Core_Connection_V1_MsgConnectionOpenAckResponse>(),
        interceptors: self.interceptors?.makeConnectionOpenAckInterceptors() ?? [],
        userFunction: self.connectionOpenAck(request:context:)
      )

    case "ConnectionOpenConfirm":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Ibc_Core_Connection_V1_MsgConnectionOpenConfirm>(),
        responseSerializer: ProtobufSerializer<Ibc_Core_Connection_V1_MsgConnectionOpenConfirmResponse>(),
        interceptors: self.interceptors?.makeConnectionOpenConfirmInterceptors() ?? [],
        userFunction: self.connectionOpenConfirm(request:context:)
      )

    default:
      return nil
    }
  }
}

internal protocol Ibc_Core_Connection_V1_MsgServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'connectionOpenInit'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeConnectionOpenInitInterceptors() -> [ServerInterceptor<Ibc_Core_Connection_V1_MsgConnectionOpenInit, Ibc_Core_Connection_V1_MsgConnectionOpenInitResponse>]

  /// - Returns: Interceptors to use when handling 'connectionOpenTry'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeConnectionOpenTryInterceptors() -> [ServerInterceptor<Ibc_Core_Connection_V1_MsgConnectionOpenTry, Ibc_Core_Connection_V1_MsgConnectionOpenTryResponse>]

  /// - Returns: Interceptors to use when handling 'connectionOpenAck'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeConnectionOpenAckInterceptors() -> [ServerInterceptor<Ibc_Core_Connection_V1_MsgConnectionOpenAck, Ibc_Core_Connection_V1_MsgConnectionOpenAckResponse>]

  /// - Returns: Interceptors to use when handling 'connectionOpenConfirm'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeConnectionOpenConfirmInterceptors() -> [ServerInterceptor<Ibc_Core_Connection_V1_MsgConnectionOpenConfirm, Ibc_Core_Connection_V1_MsgConnectionOpenConfirmResponse>]
}
