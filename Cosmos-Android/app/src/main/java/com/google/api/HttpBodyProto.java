// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: google/api/httpbody.proto

package com.google.api;

public final class HttpBodyProto {
  private HttpBodyProto() {}
  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistryLite registry) {
  }

  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistry registry) {
    registerAllExtensions(
        (com.google.protobuf.ExtensionRegistryLite) registry);
  }
  static final com.google.protobuf.Descriptors.Descriptor
    internal_static_google_api_HttpBody_descriptor;
  static final 
    com.google.protobuf.GeneratedMessageV3.FieldAccessorTable
      internal_static_google_api_HttpBody_fieldAccessorTable;

  public static com.google.protobuf.Descriptors.FileDescriptor
      getDescriptor() {
    return descriptor;
  }
  private static  com.google.protobuf.Descriptors.FileDescriptor
      descriptor;
  static {
    java.lang.String[] descriptorData = {
      "\n\031google/api/httpbody.proto\022\ngoogle.api\032" +
      "\032google/protobuf2/any.proto\"Y\n\010HttpBody\022" +
      "\024\n\014content_type\030\001 \001(\t\022\014\n\004data\030\002 \001(\014\022)\n\ne" +
      "xtensions\030\003 \003(\0132\025.google.protobuf2.AnyBh" +
      "\n\016com.google.apiB\rHttpBodyProtoP\001Z;googl" +
      "e.golang.org/genproto/googleapis/api/htt" +
      "pbody;httpbody\370\001\001\242\002\004GAPIb\006proto3"
    };
    descriptor = com.google.protobuf.Descriptors.FileDescriptor
      .internalBuildGeneratedFileFrom(descriptorData,
        new com.google.protobuf.Descriptors.FileDescriptor[] {
          com.google.protobuf2.AnyProto.getDescriptor(),
        });
    internal_static_google_api_HttpBody_descriptor =
      getDescriptor().getMessageTypes().get(0);
    internal_static_google_api_HttpBody_fieldAccessorTable = new
      com.google.protobuf.GeneratedMessageV3.FieldAccessorTable(
        internal_static_google_api_HttpBody_descriptor,
        new java.lang.String[] { "ContentType", "Data", "Extensions", });
    com.google.protobuf2.AnyProto.getDescriptor();
  }

  // @@protoc_insertion_point(outer_class_scope)
}