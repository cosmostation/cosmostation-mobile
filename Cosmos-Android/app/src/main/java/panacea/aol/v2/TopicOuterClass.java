// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: panacea/aol/v2/topic.proto

package panacea.aol.v2;

public final class TopicOuterClass {
  private TopicOuterClass() {}
  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistryLite registry) {
  }

  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistry registry) {
    registerAllExtensions(
        (com.google.protobuf.ExtensionRegistryLite) registry);
  }
  static final com.google.protobuf.Descriptors.Descriptor
    internal_static_panacea_aol_v2_Topic_descriptor;
  static final 
    com.google.protobuf.GeneratedMessageV3.FieldAccessorTable
      internal_static_panacea_aol_v2_Topic_fieldAccessorTable;

  public static com.google.protobuf.Descriptors.FileDescriptor
      getDescriptor() {
    return descriptor;
  }
  private static  com.google.protobuf.Descriptors.FileDescriptor
      descriptor;
  static {
    java.lang.String[] descriptorData = {
      "\n\032panacea/aol/v2/topic.proto\022\016panacea.ao" +
      "l.v2\032\024gogoproto/gogo.proto\"J\n\005Topic\022\023\n\013d" +
      "escription\030\001 \001(\t\022\025\n\rtotal_records\030\002 \001(\004\022" +
      "\025\n\rtotal_writers\030\003 \001(\004B0P\001Z,github.com/m" +
      "edibloc/panacea-core/x/aol/typesb\006proto3"
    };
    descriptor = com.google.protobuf.Descriptors.FileDescriptor
      .internalBuildGeneratedFileFrom(descriptorData,
        new com.google.protobuf.Descriptors.FileDescriptor[] {
          com.google.protobuf2.GoGoProtos.getDescriptor(),
        });
    internal_static_panacea_aol_v2_Topic_descriptor =
      getDescriptor().getMessageTypes().get(0);
    internal_static_panacea_aol_v2_Topic_fieldAccessorTable = new
      com.google.protobuf.GeneratedMessageV3.FieldAccessorTable(
        internal_static_panacea_aol_v2_Topic_descriptor,
        new java.lang.String[] { "Description", "TotalRecords", "TotalWriters", });
    com.google.protobuf2.GoGoProtos.getDescriptor();
  }

  // @@protoc_insertion_point(outer_class_scope)
}
