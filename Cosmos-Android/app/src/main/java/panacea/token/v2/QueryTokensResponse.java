// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: panacea/token/v2/query.proto

package panacea.token.v2;

/**
 * <pre>
 * QueryTokensResponse is the response type for the Query/Tokens RPC method.
 * </pre>
 *
 * Protobuf type {@code panacea.token.v2.QueryTokensResponse}
 */
public  final class QueryTokensResponse extends
    com.google.protobuf.GeneratedMessageV3 implements
    // @@protoc_insertion_point(message_implements:panacea.token.v2.QueryTokensResponse)
    QueryTokensResponseOrBuilder {
private static final long serialVersionUID = 0L;
  // Use QueryTokensResponse.newBuilder() to construct.
  private QueryTokensResponse(com.google.protobuf.GeneratedMessageV3.Builder<?> builder) {
    super(builder);
  }
  private QueryTokensResponse() {
    token_ = java.util.Collections.emptyList();
  }

  @java.lang.Override
  @SuppressWarnings({"unused"})
  protected java.lang.Object newInstance(
      UnusedPrivateParameter unused) {
    return new QueryTokensResponse();
  }

  @java.lang.Override
  public final com.google.protobuf.UnknownFieldSet
  getUnknownFields() {
    return this.unknownFields;
  }
  private QueryTokensResponse(
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
              token_ = new java.util.ArrayList<panacea.token.v2.Token>();
              mutable_bitField0_ |= 0x00000001;
            }
            token_.add(
                input.readMessage(panacea.token.v2.Token.parser(), extensionRegistry));
            break;
          }
          case 18: {
            cosmos.base.query.v1beta1.Pagination.PageResponse.Builder subBuilder = null;
            if (pagination_ != null) {
              subBuilder = pagination_.toBuilder();
            }
            pagination_ = input.readMessage(cosmos.base.query.v1beta1.Pagination.PageResponse.parser(), extensionRegistry);
            if (subBuilder != null) {
              subBuilder.mergeFrom(pagination_);
              pagination_ = subBuilder.buildPartial();
            }

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
      if (((mutable_bitField0_ & 0x00000001) != 0)) {
        token_ = java.util.Collections.unmodifiableList(token_);
      }
      this.unknownFields = unknownFields.build();
      makeExtensionsImmutable();
    }
  }
  public static final com.google.protobuf.Descriptors.Descriptor
      getDescriptor() {
    return panacea.token.v2.QueryOuterClass.internal_static_panacea_token_v2_QueryTokensResponse_descriptor;
  }

  @java.lang.Override
  protected com.google.protobuf.GeneratedMessageV3.FieldAccessorTable
      internalGetFieldAccessorTable() {
    return panacea.token.v2.QueryOuterClass.internal_static_panacea_token_v2_QueryTokensResponse_fieldAccessorTable
        .ensureFieldAccessorsInitialized(
            panacea.token.v2.QueryTokensResponse.class, panacea.token.v2.QueryTokensResponse.Builder.class);
  }

  public static final int TOKEN_FIELD_NUMBER = 1;
  private java.util.List<panacea.token.v2.Token> token_;
  /**
   * <code>repeated .panacea.token.v2.Token token = 1;</code>
   */
  public java.util.List<panacea.token.v2.Token> getTokenList() {
    return token_;
  }
  /**
   * <code>repeated .panacea.token.v2.Token token = 1;</code>
   */
  public java.util.List<? extends panacea.token.v2.TokenOrBuilder> 
      getTokenOrBuilderList() {
    return token_;
  }
  /**
   * <code>repeated .panacea.token.v2.Token token = 1;</code>
   */
  public int getTokenCount() {
    return token_.size();
  }
  /**
   * <code>repeated .panacea.token.v2.Token token = 1;</code>
   */
  public panacea.token.v2.Token getToken(int index) {
    return token_.get(index);
  }
  /**
   * <code>repeated .panacea.token.v2.Token token = 1;</code>
   */
  public panacea.token.v2.TokenOrBuilder getTokenOrBuilder(
      int index) {
    return token_.get(index);
  }

  public static final int PAGINATION_FIELD_NUMBER = 2;
  private cosmos.base.query.v1beta1.Pagination.PageResponse pagination_;
  /**
   * <code>.cosmos.base.query.v1beta1.PageResponse pagination = 2;</code>
   * @return Whether the pagination field is set.
   */
  public boolean hasPagination() {
    return pagination_ != null;
  }
  /**
   * <code>.cosmos.base.query.v1beta1.PageResponse pagination = 2;</code>
   * @return The pagination.
   */
  public cosmos.base.query.v1beta1.Pagination.PageResponse getPagination() {
    return pagination_ == null ? cosmos.base.query.v1beta1.Pagination.PageResponse.getDefaultInstance() : pagination_;
  }
  /**
   * <code>.cosmos.base.query.v1beta1.PageResponse pagination = 2;</code>
   */
  public cosmos.base.query.v1beta1.Pagination.PageResponseOrBuilder getPaginationOrBuilder() {
    return getPagination();
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
    for (int i = 0; i < token_.size(); i++) {
      output.writeMessage(1, token_.get(i));
    }
    if (pagination_ != null) {
      output.writeMessage(2, getPagination());
    }
    unknownFields.writeTo(output);
  }

  @java.lang.Override
  public int getSerializedSize() {
    int size = memoizedSize;
    if (size != -1) return size;

    size = 0;
    for (int i = 0; i < token_.size(); i++) {
      size += com.google.protobuf.CodedOutputStream
        .computeMessageSize(1, token_.get(i));
    }
    if (pagination_ != null) {
      size += com.google.protobuf.CodedOutputStream
        .computeMessageSize(2, getPagination());
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
    if (!(obj instanceof panacea.token.v2.QueryTokensResponse)) {
      return super.equals(obj);
    }
    panacea.token.v2.QueryTokensResponse other = (panacea.token.v2.QueryTokensResponse) obj;

    if (!getTokenList()
        .equals(other.getTokenList())) return false;
    if (hasPagination() != other.hasPagination()) return false;
    if (hasPagination()) {
      if (!getPagination()
          .equals(other.getPagination())) return false;
    }
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
    if (getTokenCount() > 0) {
      hash = (37 * hash) + TOKEN_FIELD_NUMBER;
      hash = (53 * hash) + getTokenList().hashCode();
    }
    if (hasPagination()) {
      hash = (37 * hash) + PAGINATION_FIELD_NUMBER;
      hash = (53 * hash) + getPagination().hashCode();
    }
    hash = (29 * hash) + unknownFields.hashCode();
    memoizedHashCode = hash;
    return hash;
  }

  public static panacea.token.v2.QueryTokensResponse parseFrom(
      java.nio.ByteBuffer data)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data);
  }
  public static panacea.token.v2.QueryTokensResponse parseFrom(
      java.nio.ByteBuffer data,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data, extensionRegistry);
  }
  public static panacea.token.v2.QueryTokensResponse parseFrom(
      com.google.protobuf.ByteString data)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data);
  }
  public static panacea.token.v2.QueryTokensResponse parseFrom(
      com.google.protobuf.ByteString data,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data, extensionRegistry);
  }
  public static panacea.token.v2.QueryTokensResponse parseFrom(byte[] data)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data);
  }
  public static panacea.token.v2.QueryTokensResponse parseFrom(
      byte[] data,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data, extensionRegistry);
  }
  public static panacea.token.v2.QueryTokensResponse parseFrom(java.io.InputStream input)
      throws java.io.IOException {
    return com.google.protobuf.GeneratedMessageV3
        .parseWithIOException(PARSER, input);
  }
  public static panacea.token.v2.QueryTokensResponse parseFrom(
      java.io.InputStream input,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws java.io.IOException {
    return com.google.protobuf.GeneratedMessageV3
        .parseWithIOException(PARSER, input, extensionRegistry);
  }
  public static panacea.token.v2.QueryTokensResponse parseDelimitedFrom(java.io.InputStream input)
      throws java.io.IOException {
    return com.google.protobuf.GeneratedMessageV3
        .parseDelimitedWithIOException(PARSER, input);
  }
  public static panacea.token.v2.QueryTokensResponse parseDelimitedFrom(
      java.io.InputStream input,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws java.io.IOException {
    return com.google.protobuf.GeneratedMessageV3
        .parseDelimitedWithIOException(PARSER, input, extensionRegistry);
  }
  public static panacea.token.v2.QueryTokensResponse parseFrom(
      com.google.protobuf.CodedInputStream input)
      throws java.io.IOException {
    return com.google.protobuf.GeneratedMessageV3
        .parseWithIOException(PARSER, input);
  }
  public static panacea.token.v2.QueryTokensResponse parseFrom(
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
  public static Builder newBuilder(panacea.token.v2.QueryTokensResponse prototype) {
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
   * QueryTokensResponse is the response type for the Query/Tokens RPC method.
   * </pre>
   *
   * Protobuf type {@code panacea.token.v2.QueryTokensResponse}
   */
  public static final class Builder extends
      com.google.protobuf.GeneratedMessageV3.Builder<Builder> implements
      // @@protoc_insertion_point(builder_implements:panacea.token.v2.QueryTokensResponse)
      panacea.token.v2.QueryTokensResponseOrBuilder {
    public static final com.google.protobuf.Descriptors.Descriptor
        getDescriptor() {
      return panacea.token.v2.QueryOuterClass.internal_static_panacea_token_v2_QueryTokensResponse_descriptor;
    }

    @java.lang.Override
    protected com.google.protobuf.GeneratedMessageV3.FieldAccessorTable
        internalGetFieldAccessorTable() {
      return panacea.token.v2.QueryOuterClass.internal_static_panacea_token_v2_QueryTokensResponse_fieldAccessorTable
          .ensureFieldAccessorsInitialized(
              panacea.token.v2.QueryTokensResponse.class, panacea.token.v2.QueryTokensResponse.Builder.class);
    }

    // Construct using panacea.token.v2.QueryTokensResponse.newBuilder()
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
        getTokenFieldBuilder();
      }
    }
    @java.lang.Override
    public Builder clear() {
      super.clear();
      if (tokenBuilder_ == null) {
        token_ = java.util.Collections.emptyList();
        bitField0_ = (bitField0_ & ~0x00000001);
      } else {
        tokenBuilder_.clear();
      }
      if (paginationBuilder_ == null) {
        pagination_ = null;
      } else {
        pagination_ = null;
        paginationBuilder_ = null;
      }
      return this;
    }

    @java.lang.Override
    public com.google.protobuf.Descriptors.Descriptor
        getDescriptorForType() {
      return panacea.token.v2.QueryOuterClass.internal_static_panacea_token_v2_QueryTokensResponse_descriptor;
    }

    @java.lang.Override
    public panacea.token.v2.QueryTokensResponse getDefaultInstanceForType() {
      return panacea.token.v2.QueryTokensResponse.getDefaultInstance();
    }

    @java.lang.Override
    public panacea.token.v2.QueryTokensResponse build() {
      panacea.token.v2.QueryTokensResponse result = buildPartial();
      if (!result.isInitialized()) {
        throw newUninitializedMessageException(result);
      }
      return result;
    }

    @java.lang.Override
    public panacea.token.v2.QueryTokensResponse buildPartial() {
      panacea.token.v2.QueryTokensResponse result = new panacea.token.v2.QueryTokensResponse(this);
      int from_bitField0_ = bitField0_;
      if (tokenBuilder_ == null) {
        if (((bitField0_ & 0x00000001) != 0)) {
          token_ = java.util.Collections.unmodifiableList(token_);
          bitField0_ = (bitField0_ & ~0x00000001);
        }
        result.token_ = token_;
      } else {
        result.token_ = tokenBuilder_.build();
      }
      if (paginationBuilder_ == null) {
        result.pagination_ = pagination_;
      } else {
        result.pagination_ = paginationBuilder_.build();
      }
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
      if (other instanceof panacea.token.v2.QueryTokensResponse) {
        return mergeFrom((panacea.token.v2.QueryTokensResponse)other);
      } else {
        super.mergeFrom(other);
        return this;
      }
    }

    public Builder mergeFrom(panacea.token.v2.QueryTokensResponse other) {
      if (other == panacea.token.v2.QueryTokensResponse.getDefaultInstance()) return this;
      if (tokenBuilder_ == null) {
        if (!other.token_.isEmpty()) {
          if (token_.isEmpty()) {
            token_ = other.token_;
            bitField0_ = (bitField0_ & ~0x00000001);
          } else {
            ensureTokenIsMutable();
            token_.addAll(other.token_);
          }
          onChanged();
        }
      } else {
        if (!other.token_.isEmpty()) {
          if (tokenBuilder_.isEmpty()) {
            tokenBuilder_.dispose();
            tokenBuilder_ = null;
            token_ = other.token_;
            bitField0_ = (bitField0_ & ~0x00000001);
            tokenBuilder_ = 
              com.google.protobuf.GeneratedMessageV3.alwaysUseFieldBuilders ?
                 getTokenFieldBuilder() : null;
          } else {
            tokenBuilder_.addAllMessages(other.token_);
          }
        }
      }
      if (other.hasPagination()) {
        mergePagination(other.getPagination());
      }
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
      panacea.token.v2.QueryTokensResponse parsedMessage = null;
      try {
        parsedMessage = PARSER.parsePartialFrom(input, extensionRegistry);
      } catch (com.google.protobuf.InvalidProtocolBufferException e) {
        parsedMessage = (panacea.token.v2.QueryTokensResponse) e.getUnfinishedMessage();
        throw e.unwrapIOException();
      } finally {
        if (parsedMessage != null) {
          mergeFrom(parsedMessage);
        }
      }
      return this;
    }
    private int bitField0_;

    private java.util.List<panacea.token.v2.Token> token_ =
      java.util.Collections.emptyList();
    private void ensureTokenIsMutable() {
      if (!((bitField0_ & 0x00000001) != 0)) {
        token_ = new java.util.ArrayList<panacea.token.v2.Token>(token_);
        bitField0_ |= 0x00000001;
       }
    }

    private com.google.protobuf.RepeatedFieldBuilderV3<
        panacea.token.v2.Token, panacea.token.v2.Token.Builder, panacea.token.v2.TokenOrBuilder> tokenBuilder_;

    /**
     * <code>repeated .panacea.token.v2.Token token = 1;</code>
     */
    public java.util.List<panacea.token.v2.Token> getTokenList() {
      if (tokenBuilder_ == null) {
        return java.util.Collections.unmodifiableList(token_);
      } else {
        return tokenBuilder_.getMessageList();
      }
    }
    /**
     * <code>repeated .panacea.token.v2.Token token = 1;</code>
     */
    public int getTokenCount() {
      if (tokenBuilder_ == null) {
        return token_.size();
      } else {
        return tokenBuilder_.getCount();
      }
    }
    /**
     * <code>repeated .panacea.token.v2.Token token = 1;</code>
     */
    public panacea.token.v2.Token getToken(int index) {
      if (tokenBuilder_ == null) {
        return token_.get(index);
      } else {
        return tokenBuilder_.getMessage(index);
      }
    }
    /**
     * <code>repeated .panacea.token.v2.Token token = 1;</code>
     */
    public Builder setToken(
        int index, panacea.token.v2.Token value) {
      if (tokenBuilder_ == null) {
        if (value == null) {
          throw new NullPointerException();
        }
        ensureTokenIsMutable();
        token_.set(index, value);
        onChanged();
      } else {
        tokenBuilder_.setMessage(index, value);
      }
      return this;
    }
    /**
     * <code>repeated .panacea.token.v2.Token token = 1;</code>
     */
    public Builder setToken(
        int index, panacea.token.v2.Token.Builder builderForValue) {
      if (tokenBuilder_ == null) {
        ensureTokenIsMutable();
        token_.set(index, builderForValue.build());
        onChanged();
      } else {
        tokenBuilder_.setMessage(index, builderForValue.build());
      }
      return this;
    }
    /**
     * <code>repeated .panacea.token.v2.Token token = 1;</code>
     */
    public Builder addToken(panacea.token.v2.Token value) {
      if (tokenBuilder_ == null) {
        if (value == null) {
          throw new NullPointerException();
        }
        ensureTokenIsMutable();
        token_.add(value);
        onChanged();
      } else {
        tokenBuilder_.addMessage(value);
      }
      return this;
    }
    /**
     * <code>repeated .panacea.token.v2.Token token = 1;</code>
     */
    public Builder addToken(
        int index, panacea.token.v2.Token value) {
      if (tokenBuilder_ == null) {
        if (value == null) {
          throw new NullPointerException();
        }
        ensureTokenIsMutable();
        token_.add(index, value);
        onChanged();
      } else {
        tokenBuilder_.addMessage(index, value);
      }
      return this;
    }
    /**
     * <code>repeated .panacea.token.v2.Token token = 1;</code>
     */
    public Builder addToken(
        panacea.token.v2.Token.Builder builderForValue) {
      if (tokenBuilder_ == null) {
        ensureTokenIsMutable();
        token_.add(builderForValue.build());
        onChanged();
      } else {
        tokenBuilder_.addMessage(builderForValue.build());
      }
      return this;
    }
    /**
     * <code>repeated .panacea.token.v2.Token token = 1;</code>
     */
    public Builder addToken(
        int index, panacea.token.v2.Token.Builder builderForValue) {
      if (tokenBuilder_ == null) {
        ensureTokenIsMutable();
        token_.add(index, builderForValue.build());
        onChanged();
      } else {
        tokenBuilder_.addMessage(index, builderForValue.build());
      }
      return this;
    }
    /**
     * <code>repeated .panacea.token.v2.Token token = 1;</code>
     */
    public Builder addAllToken(
        java.lang.Iterable<? extends panacea.token.v2.Token> values) {
      if (tokenBuilder_ == null) {
        ensureTokenIsMutable();
        com.google.protobuf.AbstractMessageLite.Builder.addAll(
            values, token_);
        onChanged();
      } else {
        tokenBuilder_.addAllMessages(values);
      }
      return this;
    }
    /**
     * <code>repeated .panacea.token.v2.Token token = 1;</code>
     */
    public Builder clearToken() {
      if (tokenBuilder_ == null) {
        token_ = java.util.Collections.emptyList();
        bitField0_ = (bitField0_ & ~0x00000001);
        onChanged();
      } else {
        tokenBuilder_.clear();
      }
      return this;
    }
    /**
     * <code>repeated .panacea.token.v2.Token token = 1;</code>
     */
    public Builder removeToken(int index) {
      if (tokenBuilder_ == null) {
        ensureTokenIsMutable();
        token_.remove(index);
        onChanged();
      } else {
        tokenBuilder_.remove(index);
      }
      return this;
    }
    /**
     * <code>repeated .panacea.token.v2.Token token = 1;</code>
     */
    public panacea.token.v2.Token.Builder getTokenBuilder(
        int index) {
      return getTokenFieldBuilder().getBuilder(index);
    }
    /**
     * <code>repeated .panacea.token.v2.Token token = 1;</code>
     */
    public panacea.token.v2.TokenOrBuilder getTokenOrBuilder(
        int index) {
      if (tokenBuilder_ == null) {
        return token_.get(index);  } else {
        return tokenBuilder_.getMessageOrBuilder(index);
      }
    }
    /**
     * <code>repeated .panacea.token.v2.Token token = 1;</code>
     */
    public java.util.List<? extends panacea.token.v2.TokenOrBuilder> 
         getTokenOrBuilderList() {
      if (tokenBuilder_ != null) {
        return tokenBuilder_.getMessageOrBuilderList();
      } else {
        return java.util.Collections.unmodifiableList(token_);
      }
    }
    /**
     * <code>repeated .panacea.token.v2.Token token = 1;</code>
     */
    public panacea.token.v2.Token.Builder addTokenBuilder() {
      return getTokenFieldBuilder().addBuilder(
          panacea.token.v2.Token.getDefaultInstance());
    }
    /**
     * <code>repeated .panacea.token.v2.Token token = 1;</code>
     */
    public panacea.token.v2.Token.Builder addTokenBuilder(
        int index) {
      return getTokenFieldBuilder().addBuilder(
          index, panacea.token.v2.Token.getDefaultInstance());
    }
    /**
     * <code>repeated .panacea.token.v2.Token token = 1;</code>
     */
    public java.util.List<panacea.token.v2.Token.Builder> 
         getTokenBuilderList() {
      return getTokenFieldBuilder().getBuilderList();
    }
    private com.google.protobuf.RepeatedFieldBuilderV3<
        panacea.token.v2.Token, panacea.token.v2.Token.Builder, panacea.token.v2.TokenOrBuilder> 
        getTokenFieldBuilder() {
      if (tokenBuilder_ == null) {
        tokenBuilder_ = new com.google.protobuf.RepeatedFieldBuilderV3<
            panacea.token.v2.Token, panacea.token.v2.Token.Builder, panacea.token.v2.TokenOrBuilder>(
                token_,
                ((bitField0_ & 0x00000001) != 0),
                getParentForChildren(),
                isClean());
        token_ = null;
      }
      return tokenBuilder_;
    }

    private cosmos.base.query.v1beta1.Pagination.PageResponse pagination_;
    private com.google.protobuf.SingleFieldBuilderV3<
        cosmos.base.query.v1beta1.Pagination.PageResponse, cosmos.base.query.v1beta1.Pagination.PageResponse.Builder, cosmos.base.query.v1beta1.Pagination.PageResponseOrBuilder> paginationBuilder_;
    /**
     * <code>.cosmos.base.query.v1beta1.PageResponse pagination = 2;</code>
     * @return Whether the pagination field is set.
     */
    public boolean hasPagination() {
      return paginationBuilder_ != null || pagination_ != null;
    }
    /**
     * <code>.cosmos.base.query.v1beta1.PageResponse pagination = 2;</code>
     * @return The pagination.
     */
    public cosmos.base.query.v1beta1.Pagination.PageResponse getPagination() {
      if (paginationBuilder_ == null) {
        return pagination_ == null ? cosmos.base.query.v1beta1.Pagination.PageResponse.getDefaultInstance() : pagination_;
      } else {
        return paginationBuilder_.getMessage();
      }
    }
    /**
     * <code>.cosmos.base.query.v1beta1.PageResponse pagination = 2;</code>
     */
    public Builder setPagination(cosmos.base.query.v1beta1.Pagination.PageResponse value) {
      if (paginationBuilder_ == null) {
        if (value == null) {
          throw new NullPointerException();
        }
        pagination_ = value;
        onChanged();
      } else {
        paginationBuilder_.setMessage(value);
      }

      return this;
    }
    /**
     * <code>.cosmos.base.query.v1beta1.PageResponse pagination = 2;</code>
     */
    public Builder setPagination(
        cosmos.base.query.v1beta1.Pagination.PageResponse.Builder builderForValue) {
      if (paginationBuilder_ == null) {
        pagination_ = builderForValue.build();
        onChanged();
      } else {
        paginationBuilder_.setMessage(builderForValue.build());
      }

      return this;
    }
    /**
     * <code>.cosmos.base.query.v1beta1.PageResponse pagination = 2;</code>
     */
    public Builder mergePagination(cosmos.base.query.v1beta1.Pagination.PageResponse value) {
      if (paginationBuilder_ == null) {
        if (pagination_ != null) {
          pagination_ =
            cosmos.base.query.v1beta1.Pagination.PageResponse.newBuilder(pagination_).mergeFrom(value).buildPartial();
        } else {
          pagination_ = value;
        }
        onChanged();
      } else {
        paginationBuilder_.mergeFrom(value);
      }

      return this;
    }
    /**
     * <code>.cosmos.base.query.v1beta1.PageResponse pagination = 2;</code>
     */
    public Builder clearPagination() {
      if (paginationBuilder_ == null) {
        pagination_ = null;
        onChanged();
      } else {
        pagination_ = null;
        paginationBuilder_ = null;
      }

      return this;
    }
    /**
     * <code>.cosmos.base.query.v1beta1.PageResponse pagination = 2;</code>
     */
    public cosmos.base.query.v1beta1.Pagination.PageResponse.Builder getPaginationBuilder() {
      
      onChanged();
      return getPaginationFieldBuilder().getBuilder();
    }
    /**
     * <code>.cosmos.base.query.v1beta1.PageResponse pagination = 2;</code>
     */
    public cosmos.base.query.v1beta1.Pagination.PageResponseOrBuilder getPaginationOrBuilder() {
      if (paginationBuilder_ != null) {
        return paginationBuilder_.getMessageOrBuilder();
      } else {
        return pagination_ == null ?
            cosmos.base.query.v1beta1.Pagination.PageResponse.getDefaultInstance() : pagination_;
      }
    }
    /**
     * <code>.cosmos.base.query.v1beta1.PageResponse pagination = 2;</code>
     */
    private com.google.protobuf.SingleFieldBuilderV3<
        cosmos.base.query.v1beta1.Pagination.PageResponse, cosmos.base.query.v1beta1.Pagination.PageResponse.Builder, cosmos.base.query.v1beta1.Pagination.PageResponseOrBuilder> 
        getPaginationFieldBuilder() {
      if (paginationBuilder_ == null) {
        paginationBuilder_ = new com.google.protobuf.SingleFieldBuilderV3<
            cosmos.base.query.v1beta1.Pagination.PageResponse, cosmos.base.query.v1beta1.Pagination.PageResponse.Builder, cosmos.base.query.v1beta1.Pagination.PageResponseOrBuilder>(
                getPagination(),
                getParentForChildren(),
                isClean());
        pagination_ = null;
      }
      return paginationBuilder_;
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


    // @@protoc_insertion_point(builder_scope:panacea.token.v2.QueryTokensResponse)
  }

  // @@protoc_insertion_point(class_scope:panacea.token.v2.QueryTokensResponse)
  private static final panacea.token.v2.QueryTokensResponse DEFAULT_INSTANCE;
  static {
    DEFAULT_INSTANCE = new panacea.token.v2.QueryTokensResponse();
  }

  public static panacea.token.v2.QueryTokensResponse getDefaultInstance() {
    return DEFAULT_INSTANCE;
  }

  private static final com.google.protobuf.Parser<QueryTokensResponse>
      PARSER = new com.google.protobuf.AbstractParser<QueryTokensResponse>() {
    @java.lang.Override
    public QueryTokensResponse parsePartialFrom(
        com.google.protobuf.CodedInputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return new QueryTokensResponse(input, extensionRegistry);
    }
  };

  public static com.google.protobuf.Parser<QueryTokensResponse> parser() {
    return PARSER;
  }

  @java.lang.Override
  public com.google.protobuf.Parser<QueryTokensResponse> getParserForType() {
    return PARSER;
  }

  @java.lang.Override
  public panacea.token.v2.QueryTokensResponse getDefaultInstanceForType() {
    return DEFAULT_INSTANCE;
  }

}

