//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: record/query.proto
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


/// Query defines the gRPC querier service for record module
///
/// Usage: instantiate `Irismod_Record_QueryClient`, then call methods of this protocol to make API calls.
internal protocol Irismod_Record_QueryClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Irismod_Record_QueryClientInterceptorFactoryProtocol? { get }

  func record(
    _ request: Irismod_Record_QueryRecordRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Irismod_Record_QueryRecordRequest, Irismod_Record_QueryRecordResponse>
}

extension Irismod_Record_QueryClientProtocol {
  internal var serviceName: String {
    return "irismod.record.Query"
  }

  /// Record queries the record by the given record ID
  ///
  /// - Parameters:
  ///   - request: Request to send to Record.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func record(
    _ request: Irismod_Record_QueryRecordRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Irismod_Record_QueryRecordRequest, Irismod_Record_QueryRecordResponse> {
    return self.makeUnaryCall(
      path: "/irismod.record.Query/Record",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeRecordInterceptors() ?? []
    )
  }
}

internal protocol Irismod_Record_QueryClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'record'.
  func makeRecordInterceptors() -> [ClientInterceptor<Irismod_Record_QueryRecordRequest, Irismod_Record_QueryRecordResponse>]
}

internal final class Irismod_Record_QueryClient: Irismod_Record_QueryClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Irismod_Record_QueryClientInterceptorFactoryProtocol?

  /// Creates a client for the irismod.record.Query service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Irismod_Record_QueryClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// Query defines the gRPC querier service for record module
///
/// To build a server, implement a class that conforms to this protocol.
internal protocol Irismod_Record_QueryProvider: CallHandlerProvider {
  var interceptors: Irismod_Record_QueryServerInterceptorFactoryProtocol? { get }

  /// Record queries the record by the given record ID
  func record(request: Irismod_Record_QueryRecordRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Irismod_Record_QueryRecordResponse>
}

extension Irismod_Record_QueryProvider {
  internal var serviceName: Substring { return "irismod.record.Query" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "Record":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Irismod_Record_QueryRecordRequest>(),
        responseSerializer: ProtobufSerializer<Irismod_Record_QueryRecordResponse>(),
        interceptors: self.interceptors?.makeRecordInterceptors() ?? [],
        userFunction: self.record(request:context:)
      )

    default:
      return nil
    }
  }
}

internal protocol Irismod_Record_QueryServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'record'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeRecordInterceptors() -> [ServerInterceptor<Irismod_Record_QueryRecordRequest, Irismod_Record_QueryRecordResponse>]
}
