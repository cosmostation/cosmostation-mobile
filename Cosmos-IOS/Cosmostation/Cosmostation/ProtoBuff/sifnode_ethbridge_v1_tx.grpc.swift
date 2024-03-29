//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: sifnode/ethbridge/v1/tx.proto
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


/// Msg service for messages
///
/// Usage: instantiate `Sifnode_Ethbridge_V1_MsgClient`, then call methods of this protocol to make API calls.
internal protocol Sifnode_Ethbridge_V1_MsgClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Sifnode_Ethbridge_V1_MsgClientInterceptorFactoryProtocol? { get }

  func lock(
    _ request: Sifnode_Ethbridge_V1_MsgLock,
    callOptions: CallOptions?
  ) -> UnaryCall<Sifnode_Ethbridge_V1_MsgLock, Sifnode_Ethbridge_V1_MsgLockResponse>

  func burn(
    _ request: Sifnode_Ethbridge_V1_MsgBurn,
    callOptions: CallOptions?
  ) -> UnaryCall<Sifnode_Ethbridge_V1_MsgBurn, Sifnode_Ethbridge_V1_MsgBurnResponse>

  func createEthBridgeClaim(
    _ request: Sifnode_Ethbridge_V1_MsgCreateEthBridgeClaim,
    callOptions: CallOptions?
  ) -> UnaryCall<Sifnode_Ethbridge_V1_MsgCreateEthBridgeClaim, Sifnode_Ethbridge_V1_MsgCreateEthBridgeClaimResponse>

  func updateWhiteListValidator(
    _ request: Sifnode_Ethbridge_V1_MsgUpdateWhiteListValidator,
    callOptions: CallOptions?
  ) -> UnaryCall<Sifnode_Ethbridge_V1_MsgUpdateWhiteListValidator, Sifnode_Ethbridge_V1_MsgUpdateWhiteListValidatorResponse>

  func updateCethReceiverAccount(
    _ request: Sifnode_Ethbridge_V1_MsgUpdateCethReceiverAccount,
    callOptions: CallOptions?
  ) -> UnaryCall<Sifnode_Ethbridge_V1_MsgUpdateCethReceiverAccount, Sifnode_Ethbridge_V1_MsgUpdateCethReceiverAccountResponse>

  func rescueCeth(
    _ request: Sifnode_Ethbridge_V1_MsgRescueCeth,
    callOptions: CallOptions?
  ) -> UnaryCall<Sifnode_Ethbridge_V1_MsgRescueCeth, Sifnode_Ethbridge_V1_MsgRescueCethResponse>
}

extension Sifnode_Ethbridge_V1_MsgClientProtocol {
  internal var serviceName: String {
    return "sifnode.ethbridge.v1.Msg"
  }

  /// Unary call to Lock
  ///
  /// - Parameters:
  ///   - request: Request to send to Lock.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func lock(
    _ request: Sifnode_Ethbridge_V1_MsgLock,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sifnode_Ethbridge_V1_MsgLock, Sifnode_Ethbridge_V1_MsgLockResponse> {
    return self.makeUnaryCall(
      path: "/sifnode.ethbridge.v1.Msg/Lock",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeLockInterceptors() ?? []
    )
  }

  /// Unary call to Burn
  ///
  /// - Parameters:
  ///   - request: Request to send to Burn.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func burn(
    _ request: Sifnode_Ethbridge_V1_MsgBurn,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sifnode_Ethbridge_V1_MsgBurn, Sifnode_Ethbridge_V1_MsgBurnResponse> {
    return self.makeUnaryCall(
      path: "/sifnode.ethbridge.v1.Msg/Burn",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeBurnInterceptors() ?? []
    )
  }

  /// Unary call to CreateEthBridgeClaim
  ///
  /// - Parameters:
  ///   - request: Request to send to CreateEthBridgeClaim.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func createEthBridgeClaim(
    _ request: Sifnode_Ethbridge_V1_MsgCreateEthBridgeClaim,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sifnode_Ethbridge_V1_MsgCreateEthBridgeClaim, Sifnode_Ethbridge_V1_MsgCreateEthBridgeClaimResponse> {
    return self.makeUnaryCall(
      path: "/sifnode.ethbridge.v1.Msg/CreateEthBridgeClaim",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeCreateEthBridgeClaimInterceptors() ?? []
    )
  }

  /// Unary call to UpdateWhiteListValidator
  ///
  /// - Parameters:
  ///   - request: Request to send to UpdateWhiteListValidator.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func updateWhiteListValidator(
    _ request: Sifnode_Ethbridge_V1_MsgUpdateWhiteListValidator,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sifnode_Ethbridge_V1_MsgUpdateWhiteListValidator, Sifnode_Ethbridge_V1_MsgUpdateWhiteListValidatorResponse> {
    return self.makeUnaryCall(
      path: "/sifnode.ethbridge.v1.Msg/UpdateWhiteListValidator",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeUpdateWhiteListValidatorInterceptors() ?? []
    )
  }

  /// Unary call to UpdateCethReceiverAccount
  ///
  /// - Parameters:
  ///   - request: Request to send to UpdateCethReceiverAccount.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func updateCethReceiverAccount(
    _ request: Sifnode_Ethbridge_V1_MsgUpdateCethReceiverAccount,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sifnode_Ethbridge_V1_MsgUpdateCethReceiverAccount, Sifnode_Ethbridge_V1_MsgUpdateCethReceiverAccountResponse> {
    return self.makeUnaryCall(
      path: "/sifnode.ethbridge.v1.Msg/UpdateCethReceiverAccount",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeUpdateCethReceiverAccountInterceptors() ?? []
    )
  }

  /// Unary call to RescueCeth
  ///
  /// - Parameters:
  ///   - request: Request to send to RescueCeth.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func rescueCeth(
    _ request: Sifnode_Ethbridge_V1_MsgRescueCeth,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Sifnode_Ethbridge_V1_MsgRescueCeth, Sifnode_Ethbridge_V1_MsgRescueCethResponse> {
    return self.makeUnaryCall(
      path: "/sifnode.ethbridge.v1.Msg/RescueCeth",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeRescueCethInterceptors() ?? []
    )
  }
}

internal protocol Sifnode_Ethbridge_V1_MsgClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'lock'.
  func makeLockInterceptors() -> [ClientInterceptor<Sifnode_Ethbridge_V1_MsgLock, Sifnode_Ethbridge_V1_MsgLockResponse>]

  /// - Returns: Interceptors to use when invoking 'burn'.
  func makeBurnInterceptors() -> [ClientInterceptor<Sifnode_Ethbridge_V1_MsgBurn, Sifnode_Ethbridge_V1_MsgBurnResponse>]

  /// - Returns: Interceptors to use when invoking 'createEthBridgeClaim'.
  func makeCreateEthBridgeClaimInterceptors() -> [ClientInterceptor<Sifnode_Ethbridge_V1_MsgCreateEthBridgeClaim, Sifnode_Ethbridge_V1_MsgCreateEthBridgeClaimResponse>]

  /// - Returns: Interceptors to use when invoking 'updateWhiteListValidator'.
  func makeUpdateWhiteListValidatorInterceptors() -> [ClientInterceptor<Sifnode_Ethbridge_V1_MsgUpdateWhiteListValidator, Sifnode_Ethbridge_V1_MsgUpdateWhiteListValidatorResponse>]

  /// - Returns: Interceptors to use when invoking 'updateCethReceiverAccount'.
  func makeUpdateCethReceiverAccountInterceptors() -> [ClientInterceptor<Sifnode_Ethbridge_V1_MsgUpdateCethReceiverAccount, Sifnode_Ethbridge_V1_MsgUpdateCethReceiverAccountResponse>]

  /// - Returns: Interceptors to use when invoking 'rescueCeth'.
  func makeRescueCethInterceptors() -> [ClientInterceptor<Sifnode_Ethbridge_V1_MsgRescueCeth, Sifnode_Ethbridge_V1_MsgRescueCethResponse>]
}

internal final class Sifnode_Ethbridge_V1_MsgClient: Sifnode_Ethbridge_V1_MsgClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Sifnode_Ethbridge_V1_MsgClientInterceptorFactoryProtocol?

  /// Creates a client for the sifnode.ethbridge.v1.Msg service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Sifnode_Ethbridge_V1_MsgClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// Msg service for messages
///
/// To build a server, implement a class that conforms to this protocol.
internal protocol Sifnode_Ethbridge_V1_MsgProvider: CallHandlerProvider {
  var interceptors: Sifnode_Ethbridge_V1_MsgServerInterceptorFactoryProtocol? { get }

  func lock(request: Sifnode_Ethbridge_V1_MsgLock, context: StatusOnlyCallContext) -> EventLoopFuture<Sifnode_Ethbridge_V1_MsgLockResponse>

  func burn(request: Sifnode_Ethbridge_V1_MsgBurn, context: StatusOnlyCallContext) -> EventLoopFuture<Sifnode_Ethbridge_V1_MsgBurnResponse>

  func createEthBridgeClaim(request: Sifnode_Ethbridge_V1_MsgCreateEthBridgeClaim, context: StatusOnlyCallContext) -> EventLoopFuture<Sifnode_Ethbridge_V1_MsgCreateEthBridgeClaimResponse>

  func updateWhiteListValidator(request: Sifnode_Ethbridge_V1_MsgUpdateWhiteListValidator, context: StatusOnlyCallContext) -> EventLoopFuture<Sifnode_Ethbridge_V1_MsgUpdateWhiteListValidatorResponse>

  func updateCethReceiverAccount(request: Sifnode_Ethbridge_V1_MsgUpdateCethReceiverAccount, context: StatusOnlyCallContext) -> EventLoopFuture<Sifnode_Ethbridge_V1_MsgUpdateCethReceiverAccountResponse>

  func rescueCeth(request: Sifnode_Ethbridge_V1_MsgRescueCeth, context: StatusOnlyCallContext) -> EventLoopFuture<Sifnode_Ethbridge_V1_MsgRescueCethResponse>
}

extension Sifnode_Ethbridge_V1_MsgProvider {
  internal var serviceName: Substring { return "sifnode.ethbridge.v1.Msg" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "Lock":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sifnode_Ethbridge_V1_MsgLock>(),
        responseSerializer: ProtobufSerializer<Sifnode_Ethbridge_V1_MsgLockResponse>(),
        interceptors: self.interceptors?.makeLockInterceptors() ?? [],
        userFunction: self.lock(request:context:)
      )

    case "Burn":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sifnode_Ethbridge_V1_MsgBurn>(),
        responseSerializer: ProtobufSerializer<Sifnode_Ethbridge_V1_MsgBurnResponse>(),
        interceptors: self.interceptors?.makeBurnInterceptors() ?? [],
        userFunction: self.burn(request:context:)
      )

    case "CreateEthBridgeClaim":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sifnode_Ethbridge_V1_MsgCreateEthBridgeClaim>(),
        responseSerializer: ProtobufSerializer<Sifnode_Ethbridge_V1_MsgCreateEthBridgeClaimResponse>(),
        interceptors: self.interceptors?.makeCreateEthBridgeClaimInterceptors() ?? [],
        userFunction: self.createEthBridgeClaim(request:context:)
      )

    case "UpdateWhiteListValidator":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sifnode_Ethbridge_V1_MsgUpdateWhiteListValidator>(),
        responseSerializer: ProtobufSerializer<Sifnode_Ethbridge_V1_MsgUpdateWhiteListValidatorResponse>(),
        interceptors: self.interceptors?.makeUpdateWhiteListValidatorInterceptors() ?? [],
        userFunction: self.updateWhiteListValidator(request:context:)
      )

    case "UpdateCethReceiverAccount":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sifnode_Ethbridge_V1_MsgUpdateCethReceiverAccount>(),
        responseSerializer: ProtobufSerializer<Sifnode_Ethbridge_V1_MsgUpdateCethReceiverAccountResponse>(),
        interceptors: self.interceptors?.makeUpdateCethReceiverAccountInterceptors() ?? [],
        userFunction: self.updateCethReceiverAccount(request:context:)
      )

    case "RescueCeth":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Sifnode_Ethbridge_V1_MsgRescueCeth>(),
        responseSerializer: ProtobufSerializer<Sifnode_Ethbridge_V1_MsgRescueCethResponse>(),
        interceptors: self.interceptors?.makeRescueCethInterceptors() ?? [],
        userFunction: self.rescueCeth(request:context:)
      )

    default:
      return nil
    }
  }
}

internal protocol Sifnode_Ethbridge_V1_MsgServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'lock'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeLockInterceptors() -> [ServerInterceptor<Sifnode_Ethbridge_V1_MsgLock, Sifnode_Ethbridge_V1_MsgLockResponse>]

  /// - Returns: Interceptors to use when handling 'burn'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeBurnInterceptors() -> [ServerInterceptor<Sifnode_Ethbridge_V1_MsgBurn, Sifnode_Ethbridge_V1_MsgBurnResponse>]

  /// - Returns: Interceptors to use when handling 'createEthBridgeClaim'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeCreateEthBridgeClaimInterceptors() -> [ServerInterceptor<Sifnode_Ethbridge_V1_MsgCreateEthBridgeClaim, Sifnode_Ethbridge_V1_MsgCreateEthBridgeClaimResponse>]

  /// - Returns: Interceptors to use when handling 'updateWhiteListValidator'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeUpdateWhiteListValidatorInterceptors() -> [ServerInterceptor<Sifnode_Ethbridge_V1_MsgUpdateWhiteListValidator, Sifnode_Ethbridge_V1_MsgUpdateWhiteListValidatorResponse>]

  /// - Returns: Interceptors to use when handling 'updateCethReceiverAccount'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeUpdateCethReceiverAccountInterceptors() -> [ServerInterceptor<Sifnode_Ethbridge_V1_MsgUpdateCethReceiverAccount, Sifnode_Ethbridge_V1_MsgUpdateCethReceiverAccountResponse>]

  /// - Returns: Interceptors to use when handling 'rescueCeth'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeRescueCethInterceptors() -> [ServerInterceptor<Sifnode_Ethbridge_V1_MsgRescueCeth, Sifnode_Ethbridge_V1_MsgRescueCethResponse>]
}
