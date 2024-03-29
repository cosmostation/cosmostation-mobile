//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: token/query.proto
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


/// Query creates service with token as RPC
///
/// Usage: instantiate `Irismod_Token_QueryClient`, then call methods of this protocol to make API calls.
internal protocol Irismod_Token_QueryClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Irismod_Token_QueryClientInterceptorFactoryProtocol? { get }

  func token(
    _ request: Irismod_Token_QueryTokenRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Irismod_Token_QueryTokenRequest, Irismod_Token_QueryTokenResponse>

  func tokens(
    _ request: Irismod_Token_QueryTokensRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Irismod_Token_QueryTokensRequest, Irismod_Token_QueryTokensResponse>

  func fees(
    _ request: Irismod_Token_QueryFeesRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Irismod_Token_QueryFeesRequest, Irismod_Token_QueryFeesResponse>

  func params(
    _ request: Irismod_Token_QueryParamsRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Irismod_Token_QueryParamsRequest, Irismod_Token_QueryParamsResponse>

  func totalBurn(
    _ request: Irismod_Token_QueryTotalBurnRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Irismod_Token_QueryTotalBurnRequest, Irismod_Token_QueryTotalBurnResponse>
}

extension Irismod_Token_QueryClientProtocol {
  internal var serviceName: String {
    return "irismod.token.Query"
  }

  /// Token returns token with token name
  ///
  /// - Parameters:
  ///   - request: Request to send to Token.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func token(
    _ request: Irismod_Token_QueryTokenRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Irismod_Token_QueryTokenRequest, Irismod_Token_QueryTokenResponse> {
    return self.makeUnaryCall(
      path: "/irismod.token.Query/Token",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeTokenInterceptors() ?? []
    )
  }

  /// Tokens returns the token list
  ///
  /// - Parameters:
  ///   - request: Request to send to Tokens.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func tokens(
    _ request: Irismod_Token_QueryTokensRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Irismod_Token_QueryTokensRequest, Irismod_Token_QueryTokensResponse> {
    return self.makeUnaryCall(
      path: "/irismod.token.Query/Tokens",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeTokensInterceptors() ?? []
    )
  }

  /// Fees returns the fees to issue or mint a token
  ///
  /// - Parameters:
  ///   - request: Request to send to Fees.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func fees(
    _ request: Irismod_Token_QueryFeesRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Irismod_Token_QueryFeesRequest, Irismod_Token_QueryFeesResponse> {
    return self.makeUnaryCall(
      path: "/irismod.token.Query/Fees",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeFeesInterceptors() ?? []
    )
  }

  /// Params queries the token parameters
  ///
  /// - Parameters:
  ///   - request: Request to send to Params.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func params(
    _ request: Irismod_Token_QueryParamsRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Irismod_Token_QueryParamsRequest, Irismod_Token_QueryParamsResponse> {
    return self.makeUnaryCall(
      path: "/irismod.token.Query/Params",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeParamsInterceptors() ?? []
    )
  }

  /// TotalBurn queries all the burnt coins
  ///
  /// - Parameters:
  ///   - request: Request to send to TotalBurn.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func totalBurn(
    _ request: Irismod_Token_QueryTotalBurnRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Irismod_Token_QueryTotalBurnRequest, Irismod_Token_QueryTotalBurnResponse> {
    return self.makeUnaryCall(
      path: "/irismod.token.Query/TotalBurn",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeTotalBurnInterceptors() ?? []
    )
  }
}

internal protocol Irismod_Token_QueryClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'token'.
  func makeTokenInterceptors() -> [ClientInterceptor<Irismod_Token_QueryTokenRequest, Irismod_Token_QueryTokenResponse>]

  /// - Returns: Interceptors to use when invoking 'tokens'.
  func makeTokensInterceptors() -> [ClientInterceptor<Irismod_Token_QueryTokensRequest, Irismod_Token_QueryTokensResponse>]

  /// - Returns: Interceptors to use when invoking 'fees'.
  func makeFeesInterceptors() -> [ClientInterceptor<Irismod_Token_QueryFeesRequest, Irismod_Token_QueryFeesResponse>]

  /// - Returns: Interceptors to use when invoking 'params'.
  func makeParamsInterceptors() -> [ClientInterceptor<Irismod_Token_QueryParamsRequest, Irismod_Token_QueryParamsResponse>]

  /// - Returns: Interceptors to use when invoking 'totalBurn'.
  func makeTotalBurnInterceptors() -> [ClientInterceptor<Irismod_Token_QueryTotalBurnRequest, Irismod_Token_QueryTotalBurnResponse>]
}

internal final class Irismod_Token_QueryClient: Irismod_Token_QueryClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Irismod_Token_QueryClientInterceptorFactoryProtocol?

  /// Creates a client for the irismod.token.Query service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Irismod_Token_QueryClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// Query creates service with token as RPC
///
/// To build a server, implement a class that conforms to this protocol.
internal protocol Irismod_Token_QueryProvider: CallHandlerProvider {
  var interceptors: Irismod_Token_QueryServerInterceptorFactoryProtocol? { get }

  /// Token returns token with token name
  func token(request: Irismod_Token_QueryTokenRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Irismod_Token_QueryTokenResponse>

  /// Tokens returns the token list
  func tokens(request: Irismod_Token_QueryTokensRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Irismod_Token_QueryTokensResponse>

  /// Fees returns the fees to issue or mint a token
  func fees(request: Irismod_Token_QueryFeesRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Irismod_Token_QueryFeesResponse>

  /// Params queries the token parameters
  func params(request: Irismod_Token_QueryParamsRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Irismod_Token_QueryParamsResponse>

  /// TotalBurn queries all the burnt coins
  func totalBurn(request: Irismod_Token_QueryTotalBurnRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Irismod_Token_QueryTotalBurnResponse>
}

extension Irismod_Token_QueryProvider {
  internal var serviceName: Substring { return "irismod.token.Query" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "Token":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Irismod_Token_QueryTokenRequest>(),
        responseSerializer: ProtobufSerializer<Irismod_Token_QueryTokenResponse>(),
        interceptors: self.interceptors?.makeTokenInterceptors() ?? [],
        userFunction: self.token(request:context:)
      )

    case "Tokens":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Irismod_Token_QueryTokensRequest>(),
        responseSerializer: ProtobufSerializer<Irismod_Token_QueryTokensResponse>(),
        interceptors: self.interceptors?.makeTokensInterceptors() ?? [],
        userFunction: self.tokens(request:context:)
      )

    case "Fees":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Irismod_Token_QueryFeesRequest>(),
        responseSerializer: ProtobufSerializer<Irismod_Token_QueryFeesResponse>(),
        interceptors: self.interceptors?.makeFeesInterceptors() ?? [],
        userFunction: self.fees(request:context:)
      )

    case "Params":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Irismod_Token_QueryParamsRequest>(),
        responseSerializer: ProtobufSerializer<Irismod_Token_QueryParamsResponse>(),
        interceptors: self.interceptors?.makeParamsInterceptors() ?? [],
        userFunction: self.params(request:context:)
      )

    case "TotalBurn":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Irismod_Token_QueryTotalBurnRequest>(),
        responseSerializer: ProtobufSerializer<Irismod_Token_QueryTotalBurnResponse>(),
        interceptors: self.interceptors?.makeTotalBurnInterceptors() ?? [],
        userFunction: self.totalBurn(request:context:)
      )

    default:
      return nil
    }
  }
}

internal protocol Irismod_Token_QueryServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'token'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeTokenInterceptors() -> [ServerInterceptor<Irismod_Token_QueryTokenRequest, Irismod_Token_QueryTokenResponse>]

  /// - Returns: Interceptors to use when handling 'tokens'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeTokensInterceptors() -> [ServerInterceptor<Irismod_Token_QueryTokensRequest, Irismod_Token_QueryTokensResponse>]

  /// - Returns: Interceptors to use when handling 'fees'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeFeesInterceptors() -> [ServerInterceptor<Irismod_Token_QueryFeesRequest, Irismod_Token_QueryFeesResponse>]

  /// - Returns: Interceptors to use when handling 'params'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeParamsInterceptors() -> [ServerInterceptor<Irismod_Token_QueryParamsRequest, Irismod_Token_QueryParamsResponse>]

  /// - Returns: Interceptors to use when handling 'totalBurn'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeTotalBurnInterceptors() -> [ServerInterceptor<Irismod_Token_QueryTotalBurnRequest, Irismod_Token_QueryTotalBurnResponse>]
}
