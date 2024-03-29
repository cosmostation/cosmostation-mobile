//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: guardian/query.proto
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


/// Query creates service with guardian as RPC
///
/// Usage: instantiate `Irishub_Guardian_QueryClient`, then call methods of this protocol to make API calls.
internal protocol Irishub_Guardian_QueryClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Irishub_Guardian_QueryClientInterceptorFactoryProtocol? { get }

  func supers(
    _ request: Irishub_Guardian_QuerySupersRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Irishub_Guardian_QuerySupersRequest, Irishub_Guardian_QuerySupersResponse>
}

extension Irishub_Guardian_QueryClientProtocol {
  internal var serviceName: String {
    return "irishub.guardian.Query"
  }

  /// Supers returns all Supers
  ///
  /// - Parameters:
  ///   - request: Request to send to Supers.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func supers(
    _ request: Irishub_Guardian_QuerySupersRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Irishub_Guardian_QuerySupersRequest, Irishub_Guardian_QuerySupersResponse> {
    return self.makeUnaryCall(
      path: "/irishub.guardian.Query/Supers",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSupersInterceptors() ?? []
    )
  }
}

internal protocol Irishub_Guardian_QueryClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'supers'.
  func makeSupersInterceptors() -> [ClientInterceptor<Irishub_Guardian_QuerySupersRequest, Irishub_Guardian_QuerySupersResponse>]
}

internal final class Irishub_Guardian_QueryClient: Irishub_Guardian_QueryClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Irishub_Guardian_QueryClientInterceptorFactoryProtocol?

  /// Creates a client for the irishub.guardian.Query service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Irishub_Guardian_QueryClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// Query creates service with guardian as RPC
///
/// To build a server, implement a class that conforms to this protocol.
internal protocol Irishub_Guardian_QueryProvider: CallHandlerProvider {
  var interceptors: Irishub_Guardian_QueryServerInterceptorFactoryProtocol? { get }

  /// Supers returns all Supers
  func supers(request: Irishub_Guardian_QuerySupersRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Irishub_Guardian_QuerySupersResponse>
}

extension Irishub_Guardian_QueryProvider {
  internal var serviceName: Substring { return "irishub.guardian.Query" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "Supers":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Irishub_Guardian_QuerySupersRequest>(),
        responseSerializer: ProtobufSerializer<Irishub_Guardian_QuerySupersResponse>(),
        interceptors: self.interceptors?.makeSupersInterceptors() ?? [],
        userFunction: self.supers(request:context:)
      )

    default:
      return nil
    }
  }
}

internal protocol Irishub_Guardian_QueryServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'supers'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeSupersInterceptors() -> [ServerInterceptor<Irishub_Guardian_QuerySupersRequest, Irishub_Guardian_QuerySupersResponse>]
}
