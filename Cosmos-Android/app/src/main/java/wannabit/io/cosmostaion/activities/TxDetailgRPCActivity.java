package wannabit.io.cosmostaion.activities;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.text.TextUtils;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.appcompat.widget.Toolbar;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.google.protobuf2.Any;

import akash.deployment.v1beta1.DeploymentOuterClass;
import akash.market.v1beta1.BidOuterClass;
import akash.market.v1beta1.LeaseOuterClass;
import cosmos.tx.v1beta1.ServiceGrpc;
import cosmos.tx.v1beta1.ServiceOuterClass;
import io.grpc.stub.StreamObserver;
import wannabit.io.cosmostaion.R;
import wannabit.io.cosmostaion.base.BaseActivity;
import wannabit.io.cosmostaion.dialog.Dialog_MoreWait;
import wannabit.io.cosmostaion.network.ChannelBuilder;
import wannabit.io.cosmostaion.utils.WLog;
import wannabit.io.cosmostaion.utils.WUtil;
import wannabit.io.cosmostaion.widget.txDetail.TxCloseDeploymentHolder;
import wannabit.io.cosmostaion.widget.txDetail.TxCommissionHolder;
import wannabit.io.cosmostaion.widget.txDetail.TxCommonHolder;
import wannabit.io.cosmostaion.widget.txDetail.TxCreateBidHolder;
import wannabit.io.cosmostaion.widget.txDetail.TxCreateDeploymentHolder;
import wannabit.io.cosmostaion.widget.txDetail.TxCreateLeaseHolder;
import wannabit.io.cosmostaion.widget.txDetail.TxDelegateHolder;
import wannabit.io.cosmostaion.widget.txDetail.TxHolder;
import wannabit.io.cosmostaion.widget.txDetail.TxReDelegateHolder;
import wannabit.io.cosmostaion.widget.txDetail.TxSetAddressHolder;
import wannabit.io.cosmostaion.widget.txDetail.TxStakingRewardHolder;
import wannabit.io.cosmostaion.widget.txDetail.TxTransferHolder;
import wannabit.io.cosmostaion.widget.txDetail.TxUnDelegateHolder;
import wannabit.io.cosmostaion.widget.txDetail.TxUnjailHolder;
import wannabit.io.cosmostaion.widget.txDetail.TxUnknownHolder;
import wannabit.io.cosmostaion.widget.txDetail.TxVoterHolder;
import wannabit.io.cosmostaion.widget.txDetail.TxWithdrawLeaseHolder;

import static wannabit.io.cosmostaion.base.BaseChain.getChain;
import static wannabit.io.cosmostaion.base.BaseConstant.ERROR_CODE_UNKNOWN;

public class TxDetailgRPCActivity extends BaseActivity implements View.OnClickListener, Dialog_MoreWait.OnTxWaitListener {
    private Toolbar         mToolbar;
    private RecyclerView    mTxRecyclerView;
    private CardView        mErrorCardView;
    private TextView        mErrorMsgTv;
    private RelativeLayout  mLoadingLayer;

    private LinearLayout    mControlLayer;
    private Button          mDismissBtn;
    private Button          mShareBtn;
    private Button          mExplorerBtn;

    private boolean         mIsGen;
    private boolean         mIsSuccess;
    private int             mErrorCode;
    private String          mErrorMsg;
    private String          mTxHash;

    private TxDetailgRPCAdapter mAdapter;
    private ServiceOuterClass.GetTxResponse mResponse;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_tx_detail_grpc);
        mToolbar        = findViewById(R.id.tool_bar);
        mTxRecyclerView = findViewById(R.id.tx_recycler);
        mErrorCardView  = findViewById(R.id.error_Card);
        mErrorMsgTv     = findViewById(R.id.error_details);
        mLoadingLayer   = findViewById(R.id.loadingLayer);

        mControlLayer = findViewById(R.id.control_layer);
        mShareBtn = findViewById(R.id.btn_share);
        mDismissBtn = findViewById(R.id.btn_dismiss);
        mExplorerBtn = findViewById(R.id.btn_explorer);

        setSupportActionBar(mToolbar);
        getSupportActionBar().setDisplayShowTitleEnabled(false);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        mAccount    = getBaseDao().onSelectAccount(getBaseDao().getLastUser());
        mBaseChain  = getChain(mAccount.baseChain);
        mIsGen      = getIntent().getBooleanExtra("isGen", false);
        mIsSuccess  = getIntent().getBooleanExtra("isSuccess", false);
        mErrorCode  = getIntent().getIntExtra("errorCode", ERROR_CODE_UNKNOWN);
        mErrorMsg   = getIntent().getStringExtra("errorMsg");
        mTxHash     = getIntent().getStringExtra("txHash");

        mShareBtn.setOnClickListener(this);
        mDismissBtn.setOnClickListener(this);
        mExplorerBtn.setOnClickListener(this);

        mTxRecyclerView.setLayoutManager(new LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false));
        mTxRecyclerView.setHasFixedSize(true);
        mAdapter = new TxDetailgRPCAdapter();
        mTxRecyclerView.setAdapter(mAdapter);

        if (!mIsSuccess || TextUtils.isEmpty(mTxHash)) {
            onShowError();
        } else {
            onFetchTx(mTxHash);
        }
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                onBackPressed();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public void onBackPressed() {
        if (!mIsGen) {
            super.onBackPressed();
        } else {
            onStartMainActivity(0);
        }
    }

    private void onShowError() {
        mLoadingLayer.setVisibility(View.GONE);
        mControlLayer.setVisibility(View.VISIBLE);
        mErrorCardView.setVisibility(View.VISIBLE);
        mErrorMsgTv.setText("error code : " + mErrorCode + "\n" + mErrorMsg);
    }

    private void onUpdateView() {
        mLoadingLayer.setVisibility(View.GONE);
        mControlLayer.setVisibility(View.VISIBLE);
        mAdapter.notifyDataSetChanged();
        mTxRecyclerView.setVisibility(View.VISIBLE);
    }


    @Override
    public void onClick(View v) {
        if (v.equals(mDismissBtn)) {
            onBackPressed();

        } else if (v.equals(mShareBtn)) {
            Intent shareIntent = new Intent();
            shareIntent.setAction(Intent.ACTION_SEND);
            shareIntent.putExtra(Intent.EXTRA_TEXT, WUtil.getTxExplorer(mBaseChain, mResponse.getTxResponse().getTxhash()));
            shareIntent.setType("text/plain");
            startActivity(Intent.createChooser(shareIntent, "send"));

        } else if (v.equals(mExplorerBtn)) {
                String url  = WUtil.getTxExplorer(mBaseChain, mResponse.getTxResponse().getTxhash());
                Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
                startActivity(intent);
        }

    }


    private class TxDetailgRPCAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {
        private static final int TYPE_TX_COMMON = 0;
        private static final int TYPE_TX_TRANSFER = 1;
        private static final int TYPE_TX_DELEGATE = 2;
        private static final int TYPE_TX_UNDELEGATE = 3;
        private static final int TYPE_TX_REDELEGATE = 4;
        private static final int TYPE_TX_STAKING_REWARD = 5;
        private static final int TYPE_TX_ADDRESS_CHANGE = 6;
        private static final int TYPE_TX_VOTE = 7;
        private static final int TYPE_TX_COMMISSION = 8;
        private static final int TYPE_TX_UNJAIL = 9;
        private static final int TYPE_TX_CREATE_BID = 10;
        private static final int TYPE_TX_CREATE_LEASE = 11;
        private static final int TYPE_TX_WITHDRAW_LEASE = 12;
        private static final int TYPE_TX_CREATE_DEPLOYMENT = 13;
        private static final int TYPE_TX_CLOSE_DEPLOYMENT = 14;
        private static final int TYPE_TX_IBC_TRANSFER = 15;
        private static final int TYPE_TX_UNKNOWN = 999;

        @NonNull
        @Override
        public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int viewType) {
            if (viewType == TYPE_TX_COMMON) {
                return new TxCommonHolder(getLayoutInflater().inflate(R.layout.item_tx_common, viewGroup, false));

            } else if (viewType == TYPE_TX_TRANSFER) {
                return new TxTransferHolder(getLayoutInflater().inflate(R.layout.item_tx_transfer, viewGroup, false));

            } else if (viewType == TYPE_TX_DELEGATE) {
                return new TxDelegateHolder(getLayoutInflater().inflate(R.layout.item_tx_delegate, viewGroup, false));

            } else if (viewType == TYPE_TX_UNDELEGATE) {
                return new TxUnDelegateHolder(getLayoutInflater().inflate(R.layout.item_tx_undelegate, viewGroup, false));

            } else if (viewType == TYPE_TX_REDELEGATE) {
                return new TxReDelegateHolder(getLayoutInflater().inflate(R.layout.item_tx_redelegate, viewGroup, false));

            } else if (viewType == TYPE_TX_STAKING_REWARD) {
                return new TxStakingRewardHolder(getLayoutInflater().inflate(R.layout.item_tx_reward, viewGroup, false));

            } else if (viewType == TYPE_TX_ADDRESS_CHANGE) {
                return new TxSetAddressHolder(getLayoutInflater().inflate(R.layout.item_tx_reward_address, viewGroup, false));

            } else if (viewType == TYPE_TX_VOTE) {
                return new TxVoterHolder(getLayoutInflater().inflate(R.layout.item_tx_vote, viewGroup, false));

            } else if (viewType == TYPE_TX_COMMISSION) {
                return new TxCommissionHolder(getLayoutInflater().inflate(R.layout.item_tx_commission, viewGroup, false));

            } else if (viewType == TYPE_TX_UNJAIL) {
                return new TxUnjailHolder(getLayoutInflater().inflate(R.layout.item_tx_unjail, viewGroup, false));

            } else if (viewType == TYPE_TX_CREATE_BID) {
                return new TxCreateBidHolder(getLayoutInflater().inflate(R.layout.item_tx_create_bid, viewGroup, false));

            } else if (viewType == TYPE_TX_CREATE_LEASE) {
                return new TxCreateLeaseHolder(getLayoutInflater().inflate(R.layout.item_tx_create_lease, viewGroup, false));

            } else if (viewType == TYPE_TX_WITHDRAW_LEASE) {
                return new TxWithdrawLeaseHolder(getLayoutInflater().inflate(R.layout.item_tx_withdraw_lease, viewGroup, false));

            } else if (viewType == TYPE_TX_CREATE_DEPLOYMENT) {
                return new TxCreateDeploymentHolder(getLayoutInflater().inflate(R.layout.item_tx_create_deployment, viewGroup, false));

            } else if (viewType == TYPE_TX_CLOSE_DEPLOYMENT) {
                return new TxCloseDeploymentHolder(getLayoutInflater().inflate(R.layout.item_tx_close_deployment, viewGroup, false));

            } else if (viewType == TYPE_TX_IBC_TRANSFER) {
                return new TxCloseDeploymentHolder(getLayoutInflater().inflate(R.layout.item_tx_close_deployment, viewGroup, false));

            }
            return new TxUnknownHolder(getLayoutInflater().inflate(R.layout.item_tx_unknown, viewGroup, false));

        }

        @Override
        public void onBindViewHolder(@NonNull RecyclerView.ViewHolder holder, int position) {
            if (position == 0) {
                final TxCommonHolder viewHolder = (TxCommonHolder)holder;
                viewHolder.onBindCommon(TxDetailgRPCActivity.this, getBaseDao(),  mBaseChain, mResponse, mIsGen);

            } else {
                final TxHolder viewHolder = (TxHolder)holder;
                viewHolder.onBindMsg(getBaseContext(), getBaseDao(),  mBaseChain, mResponse, position - 1, mAccount.address, mIsGen);
            }
        }

        @Override
        public int getItemCount() {
            if (mResponse == null || mResponse.getTx().getBody().getMessagesCount() <= 0) {
                return 0;
            } else {
                return mResponse.getTx().getBody().getMessagesCount() + 1;
            }
        }

        @Override
        public int getItemViewType(int position) {
            if (position == 0) {
                return TYPE_TX_COMMON;
            } else {
                Any msg = mResponse.getTx().getBody().getMessages(position - 1);
                if (msg.getTypeUrl().contains(cosmos.bank.v1beta1.Tx.MsgSend.getDescriptor().getFullName())) {
                    return TYPE_TX_TRANSFER;
                } else if (msg.getTypeUrl().contains(cosmos.staking.v1beta1.Tx.MsgDelegate.getDescriptor().getFullName())) {
                    return TYPE_TX_DELEGATE;
                } else if (msg.getTypeUrl().contains(cosmos.staking.v1beta1.Tx.MsgUndelegate.getDescriptor().getFullName())) {
                    return TYPE_TX_UNDELEGATE;
                } else if (msg.getTypeUrl().contains(cosmos.staking.v1beta1.Tx.MsgBeginRedelegate.getDescriptor().getFullName())) {
                    return TYPE_TX_REDELEGATE;
                } else if (msg.getTypeUrl().contains(cosmos.distribution.v1beta1.Tx.MsgWithdrawDelegatorReward.getDescriptor().getFullName())) {
                    return TYPE_TX_STAKING_REWARD;
                } else if (msg.getTypeUrl().contains(cosmos.distribution.v1beta1.Tx.MsgSetWithdrawAddress.getDescriptor().getFullName())) {
                    return TYPE_TX_ADDRESS_CHANGE;
                } else if (msg.getTypeUrl().contains(cosmos.gov.v1beta1.Tx.MsgVote.getDescriptor().getFullName())) {
                    return TYPE_TX_VOTE;
                } else if (msg.getTypeUrl().contains(cosmos.distribution.v1beta1.Tx.MsgWithdrawValidatorCommission.getDescriptor().getFullName())) {
                    return TYPE_TX_COMMISSION;
                } else if (msg.getTypeUrl().contains(cosmos.slashing.v1beta1.Tx.MsgUnjail.getDescriptor().getFullName())) {
                    return TYPE_TX_UNJAIL;
                } else if (msg.getTypeUrl().contains(BidOuterClass.MsgCreateBid.getDescriptor().getFullName())) {
                    return TYPE_TX_CREATE_BID;
                } else if (msg.getTypeUrl().contains(LeaseOuterClass.MsgCreateLease.getDescriptor().getFullName())) {
                    return TYPE_TX_CREATE_LEASE;
                } else if (msg.getTypeUrl().contains(LeaseOuterClass.MsgWithdrawLease.getDescriptor().getFullName())) {
                    return TYPE_TX_WITHDRAW_LEASE;
                } else if (msg.getTypeUrl().contains(DeploymentOuterClass.MsgCreateDeployment.getDescriptor().getFullName())) {
                    return TYPE_TX_CREATE_DEPLOYMENT;
                } else if (msg.getTypeUrl().contains(DeploymentOuterClass.MsgCloseDeployment.getDescriptor().getFullName())) {
                    return TYPE_TX_CLOSE_DEPLOYMENT;
                }
                return TYPE_TX_UNKNOWN;
            }
        }
    }




    private int FetchCnt = 0;
    private void onFetchTx(String hash) {
//        WLog.w("onFetchTx " + hash);
        ServiceGrpc.ServiceStub mStub = ServiceGrpc.newStub(ChannelBuilder.getChain(mBaseChain));
        ServiceOuterClass.GetTxRequest request = ServiceOuterClass.GetTxRequest.newBuilder().setHash(mTxHash).build();
        mStub.getTx(request, new StreamObserver<ServiceOuterClass.GetTxResponse>() {
            @Override
            public void onNext(ServiceOuterClass.GetTxResponse value) {
                new Handler(Looper.getMainLooper()).postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        mResponse = value;
                        onUpdateView();
                    }
                }, 0);
            }

            @Override
            public void onError(Throwable t) {
                WLog.w("onError " + t.getLocalizedMessage());
                if (mIsSuccess && FetchCnt < 10) {
                    new Handler(Looper.getMainLooper()).postDelayed(new Runnable() {
                        @Override
                        public void run() {
                            FetchCnt++;
                            onFetchTx(mTxHash);
                        }
                    }, 6000);
                } else if (!mIsGen) {
                    new Handler(Looper.getMainLooper()).postDelayed(new Runnable() {
                        @Override
                        public void run() {
                            onBackPressed();
                        }
                    }, 0);

                } else {
                    new Handler(Looper.getMainLooper()).postDelayed(new Runnable() {
                        @Override
                        public void run() {
                            onShowMoreWait();
                        }
                    }, 0);
                }
            }

            @Override
            public void onCompleted() { }
        });

    }

    private void onShowMoreWait() {
        Dialog_MoreWait waitMore = Dialog_MoreWait.newInstance(null);
        waitMore.setCancelable(false);
        waitMore.show(getSupportFragmentManager(), "dialog");
    }

    @Override
    public void onWaitMore() {
        FetchCnt = 0;
        onFetchTx(mTxHash);
    }


}
