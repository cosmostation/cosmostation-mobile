//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: akash/cert/v1beta1/query.proto
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


/// Query defines the gRPC querier service
///
/// Usage: instantiate `Akash_Cert_V1beta1_QueryClient`, then call methods of this protocol to make API calls.
internal protocol Akash_Cert_V1beta1_QueryClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Akash_Cert_V1beta1_QueryClientInterceptorFactoryProtocol? { get }

  func certificates(
    _ request: Akash_Cert_V1beta1_QueryCertificatesRequest,
    callOptions: CallOptions?
  ) -> UnaryCall<Akash_Cert_V1beta1_QueryCertificatesRequest, Akash_Cert_V1beta1_QueryCertificatesResponse>
}

extension Akash_Cert_V1beta1_QueryClientProtocol {
  internal var serviceName: String {
    return "akash.cert.v1beta1.Query"
  }

  /// Certificates queries certificates
  ///
  /// - Parameters:
  ///   - request: Request to send to Certificates.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func certificates(
    _ request: Akash_Cert_V1beta1_QueryCertificatesRequest,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Akash_Cert_V1beta1_QueryCertificatesRequest, Akash_Cert_V1beta1_QueryCertificatesResponse> {
    return self.makeUnaryCall(
      path: "/akash.cert.v1beta1.Query/Certificates",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeCertificatesInterceptors() ?? []
    )
  }
}

internal protocol Akash_Cert_V1beta1_QueryClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'certificates'.
  func makeCertificatesInterceptors() -> [ClientInterceptor<Akash_Cert_V1beta1_QueryCertificatesRequest, Akash_Cert_V1beta1_QueryCertificatesResponse>]
}

internal final class Akash_Cert_V1beta1_QueryClient: Akash_Cert_V1beta1_QueryClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Akash_Cert_V1beta1_QueryClientInterceptorFactoryProtocol?

  /// Creates a client for the akash.cert.v1beta1.Query service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Akash_Cert_V1beta1_QueryClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// Query defines the gRPC querier service
///
/// To build a server, implement a class that conforms to this protocol.
internal protocol Akash_Cert_V1beta1_QueryProvider: CallHandlerProvider {
  var interceptors: Akash_Cert_V1beta1_QueryServerInterceptorFactoryProtocol? { get }

  /// Certificates queries certificates
  func certificates(request: Akash_Cert_V1beta1_QueryCertificatesRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Akash_Cert_V1beta1_QueryCertificatesResponse>
}

extension Akash_Cert_V1beta1_QueryProvider {
  internal var serviceName: Substring { return "akash.cert.v1beta1.Query" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "Certificates":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Akash_Cert_V1beta1_QueryCertificatesRequest>(),
        responseSerializer: ProtobufSerializer<Akash_Cert_V1beta1_QueryCertificatesResponse>(),
        interceptors: self.interceptors?.makeCertificatesInterceptors() ?? [],
        userFunction: self.certificates(request:context:)
      )

    default:
      return nil
    }
  }
}

internal protocol Akash_Cert_V1beta1_QueryServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'certificates'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeCertificatesInterceptors() -> [ServerInterceptor<Akash_Cert_V1beta1_QueryCertificatesRequest, Akash_Cert_V1beta1_QueryCertificatesResponse>]
}
