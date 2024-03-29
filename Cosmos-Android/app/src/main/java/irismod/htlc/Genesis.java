// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: htlc/genesis.proto

package irismod.htlc;

public final class Genesis {
  private Genesis() {}
  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistryLite registry) {
  }

  public static void registerAllExtensions(
      com.google.protobuf.ExtensionRegistry registry) {
    registerAllExtensions(
        (com.google.protobuf.ExtensionRegistryLite) registry);
  }
  public interface GenesisStateOrBuilder extends
      // @@protoc_insertion_point(interface_extends:irismod.htlc.GenesisState)
      com.google.protobuf.MessageOrBuilder {

    /**
     * <code>map&lt;string, .irismod.htlc.HTLC&gt; pending_htlcs = 1 [(.gogoproto.nullable) = false];</code>
     */
    int getPendingHtlcsCount();
    /**
     * <code>map&lt;string, .irismod.htlc.HTLC&gt; pending_htlcs = 1 [(.gogoproto.nullable) = false];</code>
     */
    boolean containsPendingHtlcs(
        java.lang.String key);
    /**
     * Use {@link #getPendingHtlcsMap()} instead.
     */
    @java.lang.Deprecated
    java.util.Map<java.lang.String, irismod.htlc.Htlc.HTLC>
    getPendingHtlcs();
    /**
     * <code>map&lt;string, .irismod.htlc.HTLC&gt; pending_htlcs = 1 [(.gogoproto.nullable) = false];</code>
     */
    java.util.Map<java.lang.String, irismod.htlc.Htlc.HTLC>
    getPendingHtlcsMap();
    /**
     * <code>map&lt;string, .irismod.htlc.HTLC&gt; pending_htlcs = 1 [(.gogoproto.nullable) = false];</code>
     */

    irismod.htlc.Htlc.HTLC getPendingHtlcsOrDefault(
        java.lang.String key,
        irismod.htlc.Htlc.HTLC defaultValue);
    /**
     * <code>map&lt;string, .irismod.htlc.HTLC&gt; pending_htlcs = 1 [(.gogoproto.nullable) = false];</code>
     */

    irismod.htlc.Htlc.HTLC getPendingHtlcsOrThrow(
        java.lang.String key);
  }
  /**
   * <pre>
   * GenesisState defines the HTLC module's genesis state
   * </pre>
   *
   * Protobuf type {@code irismod.htlc.GenesisState}
   */
  public static final class GenesisState extends
      com.google.protobuf.GeneratedMessageV3 implements
      // @@protoc_insertion_point(message_implements:irismod.htlc.GenesisState)
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
                pendingHtlcs_ = com.google.protobuf.MapField.newMapField(
                    PendingHtlcsDefaultEntryHolder.defaultEntry);
                mutable_bitField0_ |= 0x00000001;
              }
              com.google.protobuf.MapEntry<java.lang.String, irismod.htlc.Htlc.HTLC>
              pendingHtlcs__ = input.readMessage(
                  PendingHtlcsDefaultEntryHolder.defaultEntry.getParserForType(), extensionRegistry);
              pendingHtlcs_.getMutableMap().put(
                  pendingHtlcs__.getKey(), pendingHtlcs__.getValue());
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
      return irismod.htlc.Genesis.internal_static_irismod_htlc_GenesisState_descriptor;
    }

    @SuppressWarnings({"rawtypes"})
    @java.lang.Override
    protected com.google.protobuf.MapField internalGetMapField(
        int number) {
      switch (number) {
        case 1:
          return internalGetPendingHtlcs();
        default:
          throw new RuntimeException(
              "Invalid map field number: " + number);
      }
    }
    @java.lang.Override
    protected com.google.protobuf.GeneratedMessageV3.FieldAccessorTable
        internalGetFieldAccessorTable() {
      return irismod.htlc.Genesis.internal_static_irismod_htlc_GenesisState_fieldAccessorTable
          .ensureFieldAccessorsInitialized(
              irismod.htlc.Genesis.GenesisState.class, irismod.htlc.Genesis.GenesisState.Builder.class);
    }

    public static final int PENDING_HTLCS_FIELD_NUMBER = 1;
    private static final class PendingHtlcsDefaultEntryHolder {
      static final com.google.protobuf.MapEntry<
          java.lang.String, irismod.htlc.Htlc.HTLC> defaultEntry =
              com.google.protobuf.MapEntry
              .<java.lang.String, irismod.htlc.Htlc.HTLC>newDefaultInstance(
                  irismod.htlc.Genesis.internal_static_irismod_htlc_GenesisState_PendingHtlcsEntry_descriptor, 
                  com.google.protobuf.WireFormat.FieldType.STRING,
                  "",
                  com.google.protobuf.WireFormat.FieldType.MESSAGE,
                  irismod.htlc.Htlc.HTLC.getDefaultInstance());
    }
    private com.google.protobuf.MapField<
        java.lang.String, irismod.htlc.Htlc.HTLC> pendingHtlcs_;
    private com.google.protobuf.MapField<java.lang.String, irismod.htlc.Htlc.HTLC>
    internalGetPendingHtlcs() {
      if (pendingHtlcs_ == null) {
        return com.google.protobuf.MapField.emptyMapField(
            PendingHtlcsDefaultEntryHolder.defaultEntry);
      }
      return pendingHtlcs_;
    }

    public int getPendingHtlcsCount() {
      return internalGetPendingHtlcs().getMap().size();
    }
    /**
     * <code>map&lt;string, .irismod.htlc.HTLC&gt; pending_htlcs = 1 [(.gogoproto.nullable) = false];</code>
     */

    @java.lang.Override
    public boolean containsPendingHtlcs(
        java.lang.String key) {
      if (key == null) { throw new java.lang.NullPointerException(); }
      return internalGetPendingHtlcs().getMap().containsKey(key);
    }
    /**
     * Use {@link #getPendingHtlcsMap()} instead.
     */
    @java.lang.Override
    @java.lang.Deprecated
    public java.util.Map<java.lang.String, irismod.htlc.Htlc.HTLC> getPendingHtlcs() {
      return getPendingHtlcsMap();
    }
    /**
     * <code>map&lt;string, .irismod.htlc.HTLC&gt; pending_htlcs = 1 [(.gogoproto.nullable) = false];</code>
     */
    @java.lang.Override

    public java.util.Map<java.lang.String, irismod.htlc.Htlc.HTLC> getPendingHtlcsMap() {
      return internalGetPendingHtlcs().getMap();
    }
    /**
     * <code>map&lt;string, .irismod.htlc.HTLC&gt; pending_htlcs = 1 [(.gogoproto.nullable) = false];</code>
     */
    @java.lang.Override

    public irismod.htlc.Htlc.HTLC getPendingHtlcsOrDefault(
        java.lang.String key,
        irismod.htlc.Htlc.HTLC defaultValue) {
      if (key == null) { throw new java.lang.NullPointerException(); }
      java.util.Map<java.lang.String, irismod.htlc.Htlc.HTLC> map =
          internalGetPendingHtlcs().getMap();
      return map.containsKey(key) ? map.get(key) : defaultValue;
    }
    /**
     * <code>map&lt;string, .irismod.htlc.HTLC&gt; pending_htlcs = 1 [(.gogoproto.nullable) = false];</code>
     */
    @java.lang.Override

    public irismod.htlc.Htlc.HTLC getPendingHtlcsOrThrow(
        java.lang.String key) {
      if (key == null) { throw new java.lang.NullPointerException(); }
      java.util.Map<java.lang.String, irismod.htlc.Htlc.HTLC> map =
          internalGetPendingHtlcs().getMap();
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
          internalGetPendingHtlcs(),
          PendingHtlcsDefaultEntryHolder.defaultEntry,
          1);
      unknownFields.writeTo(output);
    }

    @java.lang.Override
    public int getSerializedSize() {
      int size = memoizedSize;
      if (size != -1) return size;

      size = 0;
      for (java.util.Map.Entry<java.lang.String, irismod.htlc.Htlc.HTLC> entry
           : internalGetPendingHtlcs().getMap().entrySet()) {
        com.google.protobuf.MapEntry<java.lang.String, irismod.htlc.Htlc.HTLC>
        pendingHtlcs__ = PendingHtlcsDefaultEntryHolder.defaultEntry.newBuilderForType()
            .setKey(entry.getKey())
            .setValue(entry.getValue())
            .build();
        size += com.google.protobuf.CodedOutputStream
            .computeMessageSize(1, pendingHtlcs__);
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
      if (!(obj instanceof irismod.htlc.Genesis.GenesisState)) {
        return super.equals(obj);
      }
      irismod.htlc.Genesis.GenesisState other = (irismod.htlc.Genesis.GenesisState) obj;

      if (!internalGetPendingHtlcs().equals(
          other.internalGetPendingHtlcs())) return false;
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
      if (!internalGetPendingHtlcs().getMap().isEmpty()) {
        hash = (37 * hash) + PENDING_HTLCS_FIELD_NUMBER;
        hash = (53 * hash) + internalGetPendingHtlcs().hashCode();
      }
      hash = (29 * hash) + unknownFields.hashCode();
      memoizedHashCode = hash;
      return hash;
    }

    public static irismod.htlc.Genesis.GenesisState parseFrom(
        java.nio.ByteBuffer data)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return PARSER.parseFrom(data);
    }
    public static irismod.htlc.Genesis.GenesisState parseFrom(
        java.nio.ByteBuffer data,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return PARSER.parseFrom(data, extensionRegistry);
    }
    public static irismod.htlc.Genesis.GenesisState parseFrom(
        com.google.protobuf.ByteString data)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return PARSER.parseFrom(data);
    }
    public static irismod.htlc.Genesis.GenesisState parseFrom(
        com.google.protobuf.ByteString data,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return PARSER.parseFrom(data, extensionRegistry);
    }
    public static irismod.htlc.Genesis.GenesisState parseFrom(byte[] data)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return PARSER.parseFrom(data);
    }
    public static irismod.htlc.Genesis.GenesisState parseFrom(
        byte[] data,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return PARSER.parseFrom(data, extensionRegistry);
    }
    public static irismod.htlc.Genesis.GenesisState parseFrom(java.io.InputStream input)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageV3
          .parseWithIOException(PARSER, input);
    }
    public static irismod.htlc.Genesis.GenesisState parseFrom(
        java.io.InputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageV3
          .parseWithIOException(PARSER, input, extensionRegistry);
    }
    public static irismod.htlc.Genesis.GenesisState parseDelimitedFrom(java.io.InputStream input)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageV3
          .parseDelimitedWithIOException(PARSER, input);
    }
    public static irismod.htlc.Genesis.GenesisState parseDelimitedFrom(
        java.io.InputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageV3
          .parseDelimitedWithIOException(PARSER, input, extensionRegistry);
    }
    public static irismod.htlc.Genesis.GenesisState parseFrom(
        com.google.protobuf.CodedInputStream input)
        throws java.io.IOException {
      return com.google.protobuf.GeneratedMessageV3
          .parseWithIOException(PARSER, input);
    }
    public static irismod.htlc.Genesis.GenesisState parseFrom(
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
    public static Builder newBuilder(irismod.htlc.Genesis.GenesisState prototype) {
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
     * GenesisState defines the HTLC module's genesis state
     * </pre>
     *
     * Protobuf type {@code irismod.htlc.GenesisState}
     */
    public static final class Builder extends
        com.google.protobuf.GeneratedMessageV3.Builder<Builder> implements
        // @@protoc_insertion_point(builder_implements:irismod.htlc.GenesisState)
        irismod.htlc.Genesis.GenesisStateOrBuilder {
      public static final com.google.protobuf.Descriptors.Descriptor
          getDescriptor() {
        return irismod.htlc.Genesis.internal_static_irismod_htlc_GenesisState_descriptor;
      }

      @SuppressWarnings({"rawtypes"})
      protected com.google.protobuf.MapField internalGetMapField(
          int number) {
        switch (number) {
          case 1:
            return internalGetPendingHtlcs();
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
            return internalGetMutablePendingHtlcs();
          default:
            throw new RuntimeException(
                "Invalid map field number: " + number);
        }
      }
      @java.lang.Override
      protected com.google.protobuf.GeneratedMessageV3.FieldAccessorTable
          internalGetFieldAccessorTable() {
        return irismod.htlc.Genesis.internal_static_irismod_htlc_GenesisState_fieldAccessorTable
            .ensureFieldAccessorsInitialized(
                irismod.htlc.Genesis.GenesisState.class, irismod.htlc.Genesis.GenesisState.Builder.class);
      }

      // Construct using irismod.htlc.Genesis.GenesisState.newBuilder()
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
        internalGetMutablePendingHtlcs().clear();
        return this;
      }

      @java.lang.Override
      public com.google.protobuf.Descriptors.Descriptor
          getDescriptorForType() {
        return irismod.htlc.Genesis.internal_static_irismod_htlc_GenesisState_descriptor;
      }

      @java.lang.Override
      public irismod.htlc.Genesis.GenesisState getDefaultInstanceForType() {
        return irismod.htlc.Genesis.GenesisState.getDefaultInstance();
      }

      @java.lang.Override
      public irismod.htlc.Genesis.GenesisState build() {
        irismod.htlc.Genesis.GenesisState result = buildPartial();
        if (!result.isInitialized()) {
          throw newUninitializedMessageException(result);
        }
        return result;
      }

      @java.lang.Override
      public irismod.htlc.Genesis.GenesisState buildPartial() {
        irismod.htlc.Genesis.GenesisState result = new irismod.htlc.Genesis.GenesisState(this);
        int from_bitField0_ = bitField0_;
        result.pendingHtlcs_ = internalGetPendingHtlcs();
        result.pendingHtlcs_.makeImmutable();
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
        if (other instanceof irismod.htlc.Genesis.GenesisState) {
          return mergeFrom((irismod.htlc.Genesis.GenesisState)other);
        } else {
          super.mergeFrom(other);
          return this;
        }
      }

      public Builder mergeFrom(irismod.htlc.Genesis.GenesisState other) {
        if (other == irismod.htlc.Genesis.GenesisState.getDefaultInstance()) return this;
        internalGetMutablePendingHtlcs().mergeFrom(
            other.internalGetPendingHtlcs());
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
        irismod.htlc.Genesis.GenesisState parsedMessage = null;
        try {
          parsedMessage = PARSER.parsePartialFrom(input, extensionRegistry);
        } catch (com.google.protobuf.InvalidProtocolBufferException e) {
          parsedMessage = (irismod.htlc.Genesis.GenesisState) e.getUnfinishedMessage();
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
          java.lang.String, irismod.htlc.Htlc.HTLC> pendingHtlcs_;
      private com.google.protobuf.MapField<java.lang.String, irismod.htlc.Htlc.HTLC>
      internalGetPendingHtlcs() {
        if (pendingHtlcs_ == null) {
          return com.google.protobuf.MapField.emptyMapField(
              PendingHtlcsDefaultEntryHolder.defaultEntry);
        }
        return pendingHtlcs_;
      }
      private com.google.protobuf.MapField<java.lang.String, irismod.htlc.Htlc.HTLC>
      internalGetMutablePendingHtlcs() {
        onChanged();;
        if (pendingHtlcs_ == null) {
          pendingHtlcs_ = com.google.protobuf.MapField.newMapField(
              PendingHtlcsDefaultEntryHolder.defaultEntry);
        }
        if (!pendingHtlcs_.isMutable()) {
          pendingHtlcs_ = pendingHtlcs_.copy();
        }
        return pendingHtlcs_;
      }

      public int getPendingHtlcsCount() {
        return internalGetPendingHtlcs().getMap().size();
      }
      /**
       * <code>map&lt;string, .irismod.htlc.HTLC&gt; pending_htlcs = 1 [(.gogoproto.nullable) = false];</code>
       */

      @java.lang.Override
      public boolean containsPendingHtlcs(
          java.lang.String key) {
        if (key == null) { throw new java.lang.NullPointerException(); }
        return internalGetPendingHtlcs().getMap().containsKey(key);
      }
      /**
       * Use {@link #getPendingHtlcsMap()} instead.
       */
      @java.lang.Override
      @java.lang.Deprecated
      public java.util.Map<java.lang.String, irismod.htlc.Htlc.HTLC> getPendingHtlcs() {
        return getPendingHtlcsMap();
      }
      /**
       * <code>map&lt;string, .irismod.htlc.HTLC&gt; pending_htlcs = 1 [(.gogoproto.nullable) = false];</code>
       */
      @java.lang.Override

      public java.util.Map<java.lang.String, irismod.htlc.Htlc.HTLC> getPendingHtlcsMap() {
        return internalGetPendingHtlcs().getMap();
      }
      /**
       * <code>map&lt;string, .irismod.htlc.HTLC&gt; pending_htlcs = 1 [(.gogoproto.nullable) = false];</code>
       */
      @java.lang.Override

      public irismod.htlc.Htlc.HTLC getPendingHtlcsOrDefault(
          java.lang.String key,
          irismod.htlc.Htlc.HTLC defaultValue) {
        if (key == null) { throw new java.lang.NullPointerException(); }
        java.util.Map<java.lang.String, irismod.htlc.Htlc.HTLC> map =
            internalGetPendingHtlcs().getMap();
        return map.containsKey(key) ? map.get(key) : defaultValue;
      }
      /**
       * <code>map&lt;string, .irismod.htlc.HTLC&gt; pending_htlcs = 1 [(.gogoproto.nullable) = false];</code>
       */
      @java.lang.Override

      public irismod.htlc.Htlc.HTLC getPendingHtlcsOrThrow(
          java.lang.String key) {
        if (key == null) { throw new java.lang.NullPointerException(); }
        java.util.Map<java.lang.String, irismod.htlc.Htlc.HTLC> map =
            internalGetPendingHtlcs().getMap();
        if (!map.containsKey(key)) {
          throw new java.lang.IllegalArgumentException();
        }
        return map.get(key);
      }

      public Builder clearPendingHtlcs() {
        internalGetMutablePendingHtlcs().getMutableMap()
            .clear();
        return this;
      }
      /**
       * <code>map&lt;string, .irismod.htlc.HTLC&gt; pending_htlcs = 1 [(.gogoproto.nullable) = false];</code>
       */

      public Builder removePendingHtlcs(
          java.lang.String key) {
        if (key == null) { throw new java.lang.NullPointerException(); }
        internalGetMutablePendingHtlcs().getMutableMap()
            .remove(key);
        return this;
      }
      /**
       * Use alternate mutation accessors instead.
       */
      @java.lang.Deprecated
      public java.util.Map<java.lang.String, irismod.htlc.Htlc.HTLC>
      getMutablePendingHtlcs() {
        return internalGetMutablePendingHtlcs().getMutableMap();
      }
      /**
       * <code>map&lt;string, .irismod.htlc.HTLC&gt; pending_htlcs = 1 [(.gogoproto.nullable) = false];</code>
       */
      public Builder putPendingHtlcs(
          java.lang.String key,
          irismod.htlc.Htlc.HTLC value) {
        if (key == null) { throw new java.lang.NullPointerException(); }
        if (value == null) { throw new java.lang.NullPointerException(); }
        internalGetMutablePendingHtlcs().getMutableMap()
            .put(key, value);
        return this;
      }
      /**
       * <code>map&lt;string, .irismod.htlc.HTLC&gt; pending_htlcs = 1 [(.gogoproto.nullable) = false];</code>
       */

      public Builder putAllPendingHtlcs(
          java.util.Map<java.lang.String, irismod.htlc.Htlc.HTLC> values) {
        internalGetMutablePendingHtlcs().getMutableMap()
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


      // @@protoc_insertion_point(builder_scope:irismod.htlc.GenesisState)
    }

    // @@protoc_insertion_point(class_scope:irismod.htlc.GenesisState)
    private static final irismod.htlc.Genesis.GenesisState DEFAULT_INSTANCE;
    static {
      DEFAULT_INSTANCE = new irismod.htlc.Genesis.GenesisState();
    }

    public static irismod.htlc.Genesis.GenesisState getDefaultInstance() {
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
    public irismod.htlc.Genesis.GenesisState getDefaultInstanceForType() {
      return DEFAULT_INSTANCE;
    }

  }

  private static final com.google.protobuf.Descriptors.Descriptor
    internal_static_irismod_htlc_GenesisState_descriptor;
  private static final 
    com.google.protobuf.GeneratedMessageV3.FieldAccessorTable
      internal_static_irismod_htlc_GenesisState_fieldAccessorTable;
  private static final com.google.protobuf.Descriptors.Descriptor
    internal_static_irismod_htlc_GenesisState_PendingHtlcsEntry_descriptor;
  private static final 
    com.google.protobuf.GeneratedMessageV3.FieldAccessorTable
      internal_static_irismod_htlc_GenesisState_PendingHtlcsEntry_fieldAccessorTable;

  public static com.google.protobuf.Descriptors.FileDescriptor
      getDescriptor() {
    return descriptor;
  }
  private static  com.google.protobuf.Descriptors.FileDescriptor
      descriptor;
  static {
    java.lang.String[] descriptorData = {
      "\n\022htlc/genesis.proto\022\014irismod.htlc\032\024gogo" +
      "proto/gogo.proto\032\017htlc/htlc.proto\"\242\001\n\014Ge" +
      "nesisState\022I\n\rpending_htlcs\030\001 \003(\0132,.iris" +
      "mod.htlc.GenesisState.PendingHtlcsEntryB" +
      "\004\310\336\037\000\032G\n\021PendingHtlcsEntry\022\013\n\003key\030\001 \001(\t\022" +
      "!\n\005value\030\002 \001(\0132\022.irismod.htlc.HTLC:\0028\001B/" +
      "Z-github.com/irisnet/irismod/modules/htl" +
      "c/typesb\006proto3"
    };
    descriptor = com.google.protobuf.Descriptors.FileDescriptor
      .internalBuildGeneratedFileFrom(descriptorData,
        new com.google.protobuf.Descriptors.FileDescriptor[] {
          com.google.protobuf2.GoGoProtos.getDescriptor(),
          irismod.htlc.Htlc.getDescriptor(),
        });
    internal_static_irismod_htlc_GenesisState_descriptor =
      getDescriptor().getMessageTypes().get(0);
    internal_static_irismod_htlc_GenesisState_fieldAccessorTable = new
      com.google.protobuf.GeneratedMessageV3.FieldAccessorTable(
        internal_static_irismod_htlc_GenesisState_descriptor,
        new java.lang.String[] { "PendingHtlcs", });
    internal_static_irismod_htlc_GenesisState_PendingHtlcsEntry_descriptor =
      internal_static_irismod_htlc_GenesisState_descriptor.getNestedTypes().get(0);
    internal_static_irismod_htlc_GenesisState_PendingHtlcsEntry_fieldAccessorTable = new
      com.google.protobuf.GeneratedMessageV3.FieldAccessorTable(
        internal_static_irismod_htlc_GenesisState_PendingHtlcsEntry_descriptor,
        new java.lang.String[] { "Key", "Value", });
    com.google.protobuf.ExtensionRegistry registry =
        com.google.protobuf.ExtensionRegistry.newInstance();
    registry.add(com.google.protobuf2.GoGoProtos.nullable);
    com.google.protobuf.Descriptors.FileDescriptor
        .internalUpdateFileDescriptor(descriptor, registry);
    com.google.protobuf2.GoGoProtos.getDescriptor();
    irismod.htlc.Htlc.getDescriptor();
  }

  // @@protoc_insertion_point(outer_class_scope)
}
