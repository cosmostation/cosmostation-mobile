// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: panacea/did/v2/genesis.proto

package panacea.did.v2;

/**
 * <pre>
 * GenesisState defines the did module's genesis state.
 * </pre>
 *
 * Protobuf type {@code panacea.did.v2.GenesisState}
 */
public  final class GenesisState extends
    com.google.protobuf.GeneratedMessageV3 implements
    // @@protoc_insertion_point(message_implements:panacea.did.v2.GenesisState)
    GenesisStateOrBuilder {
private static final long serialVersionUID = 0L;
  // Use GenesisState.newBuilder() to construct.
  private GenesisState(com.google.protobuf.GeneratedMessageV3.Builder<?> builder) {
    super(builder);
  }
  private GenesisState() {
  }

  @java.lang.Override
  @SuppressWarnings({"unused"})
  protected java.lang.Object newInstance(
      UnusedPrivateParameter unused) {
    return new GenesisState();
  }

  @java.lang.Override
  public final com.google.protobuf.UnknownFieldSet
  getUnknownFields() {
    return this.unknownFields;
  }
  private GenesisState(
      com.google.protobuf.CodedInputStream input,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws com.google.protobuf.InvalidProtocolBufferException {
    this();
    if (extensionRegistry == null) {
      throw new java.lang.NullPointerException();
    }
    int mutable_bitField0_ = 0;
    com.google.protobuf.UnknownFieldSet.Builder unknownFields =
        com.google.protobuf.UnknownFieldSet.newBuilder();
    try {
      boolean done = false;
      while (!done) {
        int tag = input.readTag();
        switch (tag) {
          case 0:
            done = true;
            break;
          case 10: {
            if (!((mutable_bitField0_ & 0x00000001) != 0)) {
              documents_ = com.google.protobuf.MapField.newMapField(
                  DocumentsDefaultEntryHolder.defaultEntry);
              mutable_bitField0_ |= 0x00000001;
            }
            com.google.protobuf.MapEntry<java.lang.String, panacea.did.v2.DIDDocumentWithSeq>
            documents__ = input.readMessage(
                DocumentsDefaultEntryHolder.defaultEntry.getParserForType(), extensionRegistry);
            documents_.getMutableMap().put(
                documents__.getKey(), documents__.getValue());
            break;
          }
          default: {
            if (!parseUnknownField(
                input, unknownFields, extensionRegistry, tag)) {
              done = true;
            }
            break;
          }
        }
      }
    } catch (com.google.protobuf.InvalidProtocolBufferException e) {
      throw e.setUnfinishedMessage(this);
    } catch (java.io.IOException e) {
      throw new com.google.protobuf.InvalidProtocolBufferException(
          e).setUnfinishedMessage(this);
    } finally {
      this.unknownFields = unknownFields.build();
      makeExtensionsImmutable();
    }
  }
  public static final com.google.protobuf.Descriptors.Descriptor
      getDescriptor() {
    return panacea.did.v2.Genesis.internal_static_panacea_did_v2_GenesisState_descriptor;
  }

  @SuppressWarnings({"rawtypes"})
  @java.lang.Override
  protected com.google.protobuf.MapField internalGetMapField(
      int number) {
    switch (number) {
      case 1:
        return internalGetDocuments();
      default:
        throw new RuntimeException(
            "Invalid map field number: " + number);
    }
  }
  @java.lang.Override
  protected com.google.protobuf.GeneratedMessageV3.FieldAccessorTable
      internalGetFieldAccessorTable() {
    return panacea.did.v2.Genesis.internal_static_panacea_did_v2_GenesisState_fieldAccessorTable
        .ensureFieldAccessorsInitialized(
            panacea.did.v2.GenesisState.class, panacea.did.v2.GenesisState.Builder.class);
  }

  public static final int DOCUMENTS_FIELD_NUMBER = 1;
  private static final class DocumentsDefaultEntryHolder {
    static final com.google.protobuf.MapEntry<
        java.lang.String, panacea.did.v2.DIDDocumentWithSeq> defaultEntry =
            com.google.protobuf.MapEntry
            .<java.lang.String, panacea.did.v2.DIDDocumentWithSeq>newDefaultInstance(
                panacea.did.v2.Genesis.internal_static_panacea_did_v2_GenesisState_DocumentsEntry_descriptor, 
                com.google.protobuf.WireFormat.FieldType.STRING,
                "",
                com.google.protobuf.WireFormat.FieldType.MESSAGE,
                panacea.did.v2.DIDDocumentWithSeq.getDefaultInstance());
  }
  private com.google.protobuf.MapField<
      java.lang.String, panacea.did.v2.DIDDocumentWithSeq> documents_;
  private com.google.protobuf.MapField<java.lang.String, panacea.did.v2.DIDDocumentWithSeq>
  internalGetDocuments() {
    if (documents_ == null) {
      return com.google.protobuf.MapField.emptyMapField(
          DocumentsDefaultEntryHolder.defaultEntry);
    }
    return documents_;
  }

  public int getDocumentsCount() {
    return internalGetDocuments().getMap().size();
  }
  /**
   * <code>map&lt;string, .panacea.did.v2.DIDDocumentWithSeq&gt; documents = 1;</code>
   */

  public boolean containsDocuments(
      java.lang.String key) {
    if (key == null) { throw new java.lang.NullPointerException(); }
    return internalGetDocuments().getMap().containsKey(key);
  }
  /**
   * Use {@link #getDocumentsMap()} instead.
   */
  @java.lang.Deprecated
  public java.util.Map<java.lang.String, panacea.did.v2.DIDDocumentWithSeq> getDocuments() {
    return getDocumentsMap();
  }
  /**
   * <code>map&lt;string, .panacea.did.v2.DIDDocumentWithSeq&gt; documents = 1;</code>
   */

  public java.util.Map<java.lang.String, panacea.did.v2.DIDDocumentWithSeq> getDocumentsMap() {
    return internalGetDocuments().getMap();
  }
  /**
   * <code>map&lt;string, .panacea.did.v2.DIDDocumentWithSeq&gt; documents = 1;</code>
   */

  public panacea.did.v2.DIDDocumentWithSeq getDocumentsOrDefault(
      java.lang.String key,
      panacea.did.v2.DIDDocumentWithSeq defaultValue) {
    if (key == null) { throw new java.lang.NullPointerException(); }
    java.util.Map<java.lang.String, panacea.did.v2.DIDDocumentWithSeq> map =
        internalGetDocuments().getMap();
    return map.containsKey(key) ? map.get(key) : defaultValue;
  }
  /**
   * <code>map&lt;string, .panacea.did.v2.DIDDocumentWithSeq&gt; documents = 1;</code>
   */

  public panacea.did.v2.DIDDocumentWithSeq getDocumentsOrThrow(
      java.lang.String key) {
    if (key == null) { throw new java.lang.NullPointerException(); }
    java.util.Map<java.lang.String, panacea.did.v2.DIDDocumentWithSeq> map =
        internalGetDocuments().getMap();
    if (!map.containsKey(key)) {
      throw new java.lang.IllegalArgumentException();
    }
    return map.get(key);
  }

  private byte memoizedIsInitialized = -1;
  @java.lang.Override
  public final boolean isInitialized() {
    byte isInitialized = memoizedIsInitialized;
    if (isInitialized == 1) return true;
    if (isInitialized == 0) return false;

    memoizedIsInitialized = 1;
    return true;
  }

  @java.lang.Override
  public void writeTo(com.google.protobuf.CodedOutputStream output)
                      throws java.io.IOException {
    com.google.protobuf.GeneratedMessageV3
      .serializeStringMapTo(
        output,
        internalGetDocuments(),
        DocumentsDefaultEntryHolder.defaultEntry,
        1);
    unknownFields.writeTo(output);
  }

  @java.lang.Override
  public int getSerializedSize() {
    int size = memoizedSize;
    if (size != -1) return size;

    size = 0;
    for (java.util.Map.Entry<java.lang.String, panacea.did.v2.DIDDocumentWithSeq> entry
         : internalGetDocuments().getMap().entrySet()) {
      com.google.protobuf.MapEntry<java.lang.String, panacea.did.v2.DIDDocumentWithSeq>
      documents__ = DocumentsDefaultEntryHolder.defaultEntry.newBuilderForType()
          .setKey(entry.getKey())
          .setValue(entry.getValue())
          .build();
      size += com.google.protobuf.CodedOutputStream
          .computeMessageSize(1, documents__);
    }
    size += unknownFields.getSerializedSize();
    memoizedSize = size;
    return size;
  }

  @java.lang.Override
  public boolean equals(final java.lang.Object obj) {
    if (obj == this) {
     return true;
    }
    if (!(obj instanceof panacea.did.v2.GenesisState)) {
      return super.equals(obj);
    }
    panacea.did.v2.GenesisState other = (panacea.did.v2.GenesisState) obj;

    if (!internalGetDocuments().equals(
        other.internalGetDocuments())) return false;
    if (!unknownFields.equals(other.unknownFields)) return false;
    return true;
  }

  @java.lang.Override
  public int hashCode() {
    if (memoizedHashCode != 0) {
      return memoizedHashCode;
    }
    int hash = 41;
    hash = (19 * hash) + getDescriptor().hashCode();
    if (!internalGetDocuments().getMap().isEmpty()) {
      hash = (37 * hash) + DOCUMENTS_FIELD_NUMBER;
      hash = (53 * hash) + internalGetDocuments().hashCode();
    }
    hash = (29 * hash) + unknownFields.hashCode();
    memoizedHashCode = hash;
    return hash;
  }

  public static panacea.did.v2.GenesisState parseFrom(
      java.nio.ByteBuffer data)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data);
  }
  public static panacea.did.v2.GenesisState parseFrom(
      java.nio.ByteBuffer data,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data, extensionRegistry);
  }
  public static panacea.did.v2.GenesisState parseFrom(
      com.google.protobuf.ByteString data)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data);
  }
  public static panacea.did.v2.GenesisState parseFrom(
      com.google.protobuf.ByteString data,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data, extensionRegistry);
  }
  public static panacea.did.v2.GenesisState parseFrom(byte[] data)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data);
  }
  public static panacea.did.v2.GenesisState parseFrom(
      byte[] data,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data, extensionRegistry);
  }
  public static panacea.did.v2.GenesisState parseFrom(java.io.InputStream input)
      throws java.io.IOException {
    return com.google.protobuf.GeneratedMessageV3
        .parseWithIOException(PARSER, input);
  }
  public static panacea.did.v2.GenesisState parseFrom(
      java.io.InputStream input,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws java.io.IOException {
    return com.google.protobuf.GeneratedMessageV3
        .parseWithIOException(PARSER, input, extensionRegistry);
  }
  public static panacea.did.v2.GenesisState parseDelimitedFrom(java.io.InputStream input)
      throws java.io.IOException {
    return com.google.protobuf.GeneratedMessageV3
        .parseDelimitedWithIOException(PARSER, input);
  }
  public static panacea.did.v2.GenesisState parseDelimitedFrom(
      java.io.InputStream input,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws java.io.IOException {
    return com.google.protobuf.GeneratedMessageV3
        .parseDelimitedWithIOException(PARSER, input, extensionRegistry);
  }
  public static panacea.did.v2.GenesisState parseFrom(
      com.google.protobuf.CodedInputStream input)
      throws java.io.IOException {
    return com.google.protobuf.GeneratedMessageV3
        .parseWithIOException(PARSER, input);
  }
  public static panacea.did.v2.GenesisState parseFrom(
      com.google.protobuf.CodedInputStream input,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws java.io.IOException {
    return com.google.protobuf.GeneratedMessageV3
        .parseWithIOException(PARSER, input, extensionRegistry);
  }

  @java.lang.Override
  public Builder newBuilderForType() { return newBuilder(); }
  public static Builder newBuilder() {
    return DEFAULT_INSTANCE.toBuilder();
  }
  public static Builder newBuilder(panacea.did.v2.GenesisState prototype) {
    return DEFAULT_INSTANCE.toBuilder().mergeFrom(prototype);
  }
  @java.lang.Override
  public Builder toBuilder() {
    return this == DEFAULT_INSTANCE
        ? new Builder() : new Builder().mergeFrom(this);
  }

  @java.lang.Override
  protected Builder newBuilderForType(
      com.google.protobuf.GeneratedMessageV3.BuilderParent parent) {
    Builder builder = new Builder(parent);
    return builder;
  }
  /**
   * <pre>
   * GenesisState defines the did module's genesis state.
   * </pre>
   *
   * Protobuf type {@code panacea.did.v2.GenesisState}
   */
  public static final class Builder extends
      com.google.protobuf.GeneratedMessageV3.Builder<Builder> implements
      // @@protoc_insertion_point(builder_implements:panacea.did.v2.GenesisState)
      panacea.did.v2.GenesisStateOrBuilder {
    public static final com.google.protobuf.Descriptors.Descriptor
        getDescriptor() {
      return panacea.did.v2.Genesis.internal_static_panacea_did_v2_GenesisState_descriptor;
    }

    @SuppressWarnings({"rawtypes"})
    protected com.google.protobuf.MapField internalGetMapField(
        int number) {
      switch (number) {
        case 1:
          return internalGetDocuments();
        default:
          throw new RuntimeException(
              "Invalid map field number: " + number);
      }
    }
    @SuppressWarnings({"rawtypes"})
    protected com.google.protobuf.MapField internalGetMutableMapField(
        int number) {
      switch (number) {
        case 1:
          return internalGetMutableDocuments();
        default:
          throw new RuntimeException(
              "Invalid map field number: " + number);
      }
    }
    @java.lang.Override
    protected com.google.protobuf.GeneratedMessageV3.FieldAccessorTable
        internalGetFieldAccessorTable() {
      return panacea.did.v2.Genesis.internal_static_panacea_did_v2_GenesisState_fieldAccessorTable
          .ensureFieldAccessorsInitialized(
              panacea.did.v2.GenesisState.class, panacea.did.v2.GenesisState.Builder.class);
    }

    // Construct using panacea.did.v2.GenesisState.newBuilder()
    private Builder() {
      maybeForceBuilderInitialization();
    }

    private Builder(
        com.google.protobuf.GeneratedMessageV3.BuilderParent parent) {
      super(parent);
      maybeForceBuilderInitialization();
    }
    private void maybeForceBuilderInitialization() {
      if (com.google.protobuf.GeneratedMessageV3
              .alwaysUseFieldBuilders) {
      }
    }
    @java.lang.Override
    public Builder clear() {
      super.clear();
      internalGetMutableDocuments().clear();
      return this;
    }

    @java.lang.Override
    public com.google.protobuf.Descriptors.Descriptor
        getDescriptorForType() {
      return panacea.did.v2.Genesis.internal_static_panacea_did_v2_GenesisState_descriptor;
    }

    @java.lang.Override
    public panacea.did.v2.GenesisState getDefaultInstanceForType() {
      return panacea.did.v2.GenesisState.getDefaultInstance();
    }

    @java.lang.Override
    public panacea.did.v2.GenesisState build() {
      panacea.did.v2.GenesisState result = buildPartial();
      if (!result.isInitialized()) {
        throw newUninitializedMessageException(result);
      }
      return result;
    }

    @java.lang.Override
    public panacea.did.v2.GenesisState buildPartial() {
      panacea.did.v2.GenesisState result = new panacea.did.v2.GenesisState(this);
      int from_bitField0_ = bitField0_;
      result.documents_ = internalGetDocuments();
      result.documents_.makeImmutable();
      onBuilt();
      return result;
    }

    @java.lang.Override
    public Builder clone() {
      return super.clone();
    }
    @java.lang.Override
    public Builder setField(
        com.google.protobuf.Descriptors.FieldDescriptor field,
        java.lang.Object value) {
      return super.setField(field, value);
    }
    @java.lang.Override
    public Builder clearField(
        com.google.protobuf.Descriptors.FieldDescriptor field) {
      return super.clearField(field);
    }
    @java.lang.Override
    public Builder clearOneof(
        com.google.protobuf.Descriptors.OneofDescriptor oneof) {
      return super.clearOneof(oneof);
    }
    @java.lang.Override
    public Builder setRepeatedField(
        com.google.protobuf.Descriptors.FieldDescriptor field,
        int index, java.lang.Object value) {
      return super.setRepeatedField(field, index, value);
    }
    @java.lang.Override
    public Builder addRepeatedField(
        com.google.protobuf.Descriptors.FieldDescriptor field,
        java.lang.Object value) {
      return super.addRepeatedField(field, value);
    }
    @java.lang.Override
    public Builder mergeFrom(com.google.protobuf.Message other) {
      if (other instanceof panacea.did.v2.GenesisState) {
        return mergeFrom((panacea.did.v2.GenesisState)other);
      } else {
        super.mergeFrom(other);
        return this;
      }
    }

    public Builder mergeFrom(panacea.did.v2.GenesisState other) {
      if (other == panacea.did.v2.GenesisState.getDefaultInstance()) return this;
      internalGetMutableDocuments().mergeFrom(
          other.internalGetDocuments());
      this.mergeUnknownFields(other.unknownFields);
      onChanged();
      return this;
    }

    @java.lang.Override
    public final boolean isInitialized() {
      return true;
    }

    @java.lang.Override
    public Builder mergeFrom(
        com.google.protobuf.CodedInputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      panacea.did.v2.GenesisState parsedMessage = null;
      try {
        parsedMessage = PARSER.parsePartialFrom(input, extensionRegistry);
      } catch (com.google.protobuf.InvalidProtocolBufferException e) {
        parsedMessage = (panacea.did.v2.GenesisState) e.getUnfinishedMessage();
        throw e.unwrapIOException();
      } finally {
        if (parsedMessage != null) {
          mergeFrom(parsedMessage);
        }
      }
      return this;
    }
    private int bitField0_;

    private com.google.protobuf.MapField<
        java.lang.String, panacea.did.v2.DIDDocumentWithSeq> documents_;
    private com.google.protobuf.MapField<java.lang.String, panacea.did.v2.DIDDocumentWithSeq>
    internalGetDocuments() {
      if (documents_ == null) {
        return com.google.protobuf.MapField.emptyMapField(
            DocumentsDefaultEntryHolder.defaultEntry);
      }
      return documents_;
    }
    private com.google.protobuf.MapField<java.lang.String, panacea.did.v2.DIDDocumentWithSeq>
    internalGetMutableDocuments() {
      onChanged();;
      if (documents_ == null) {
        documents_ = com.google.protobuf.MapField.newMapField(
            DocumentsDefaultEntryHolder.defaultEntry);
      }
      if (!documents_.isMutable()) {
        documents_ = documents_.copy();
      }
      return documents_;
    }

    public int getDocumentsCount() {
      return internalGetDocuments().getMap().size();
    }
    /**
     * <code>map&lt;string, .panacea.did.v2.DIDDocumentWithSeq&gt; documents = 1;</code>
     */

    public boolean containsDocuments(
        java.lang.String key) {
      if (key == null) { throw new java.lang.NullPointerException(); }
      return internalGetDocuments().getMap().containsKey(key);
    }
    /**
     * Use {@link #getDocumentsMap()} instead.
     */
    @java.lang.Deprecated
    public java.util.Map<java.lang.String, panacea.did.v2.DIDDocumentWithSeq> getDocuments() {
      return getDocumentsMap();
    }
    /**
     * <code>map&lt;string, .panacea.did.v2.DIDDocumentWithSeq&gt; documents = 1;</code>
     */

    public java.util.Map<java.lang.String, panacea.did.v2.DIDDocumentWithSeq> getDocumentsMap() {
      return internalGetDocuments().getMap();
    }
    /**
     * <code>map&lt;string, .panacea.did.v2.DIDDocumentWithSeq&gt; documents = 1;</code>
     */

    public panacea.did.v2.DIDDocumentWithSeq getDocumentsOrDefault(
        java.lang.String key,
        panacea.did.v2.DIDDocumentWithSeq defaultValue) {
      if (key == null) { throw new java.lang.NullPointerException(); }
      java.util.Map<java.lang.String, panacea.did.v2.DIDDocumentWithSeq> map =
          internalGetDocuments().getMap();
      return map.containsKey(key) ? map.get(key) : defaultValue;
    }
    /**
     * <code>map&lt;string, .panacea.did.v2.DIDDocumentWithSeq&gt; documents = 1;</code>
     */

    public panacea.did.v2.DIDDocumentWithSeq getDocumentsOrThrow(
        java.lang.String key) {
      if (key == null) { throw new java.lang.NullPointerException(); }
      java.util.Map<java.lang.String, panacea.did.v2.DIDDocumentWithSeq> map =
          internalGetDocuments().getMap();
      if (!map.containsKey(key)) {
        throw new java.lang.IllegalArgumentException();
      }
      return map.get(key);
    }

    public Builder clearDocuments() {
      internalGetMutableDocuments().getMutableMap()
          .clear();
      return this;
    }
    /**
     * <code>map&lt;string, .panacea.did.v2.DIDDocumentWithSeq&gt; documents = 1;</code>
     */

    public Builder removeDocuments(
        java.lang.String key) {
      if (key == null) { throw new java.lang.NullPointerException(); }
      internalGetMutableDocuments().getMutableMap()
          .remove(key);
      return this;
    }
    /**
     * Use alternate mutation accessors instead.
     */
    @java.lang.Deprecated
    public java.util.Map<java.lang.String, panacea.did.v2.DIDDocumentWithSeq>
    getMutableDocuments() {
      return internalGetMutableDocuments().getMutableMap();
    }
    /**
     * <code>map&lt;string, .panacea.did.v2.DIDDocumentWithSeq&gt; documents = 1;</code>
     */
    public Builder putDocuments(
        java.lang.String key,
        panacea.did.v2.DIDDocumentWithSeq value) {
      if (key == null) { throw new java.lang.NullPointerException(); }
      if (value == null) { throw new java.lang.NullPointerException(); }
      internalGetMutableDocuments().getMutableMap()
          .put(key, value);
      return this;
    }
    /**
     * <code>map&lt;string, .panacea.did.v2.DIDDocumentWithSeq&gt; documents = 1;</code>
     */

    public Builder putAllDocuments(
        java.util.Map<java.lang.String, panacea.did.v2.DIDDocumentWithSeq> values) {
      internalGetMutableDocuments().getMutableMap()
          .putAll(values);
      return this;
    }
    @java.lang.Override
    public final Builder setUnknownFields(
        final com.google.protobuf.UnknownFieldSet unknownFields) {
      return super.setUnknownFields(unknownFields);
    }

    @java.lang.Override
    public final Builder mergeUnknownFields(
        final com.google.protobuf.UnknownFieldSet unknownFields) {
      return super.mergeUnknownFields(unknownFields);
    }


    // @@protoc_insertion_point(builder_scope:panacea.did.v2.GenesisState)
  }

  // @@protoc_insertion_point(class_scope:panacea.did.v2.GenesisState)
  private static final panacea.did.v2.GenesisState DEFAULT_INSTANCE;
  static {
    DEFAULT_INSTANCE = new panacea.did.v2.GenesisState();
  }

  public static panacea.did.v2.GenesisState getDefaultInstance() {
    return DEFAULT_INSTANCE;
  }

  private static final com.google.protobuf.Parser<GenesisState>
      PARSER = new com.google.protobuf.AbstractParser<GenesisState>() {
    @java.lang.Override
    public GenesisState parsePartialFrom(
        com.google.protobuf.CodedInputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return new GenesisState(input, extensionRegistry);
    }
  };

  public static com.google.protobuf.Parser<GenesisState> parser() {
    return PARSER;
  }

  @java.lang.Override
  public com.google.protobuf.Parser<GenesisState> getParserForType() {
    return PARSER;
  }

  @java.lang.Override
  public panacea.did.v2.GenesisState getDefaultInstanceForType() {
    return DEFAULT_INSTANCE;
  }

}

