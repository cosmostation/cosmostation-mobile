package wannabit.io.cosmostaion.task.FetchTask;

import java.util.ArrayList;

import retrofit2.Response;
import wannabit.io.cosmostaion.base.BaseApplication;
import wannabit.io.cosmostaion.base.BaseChain;
import wannabit.io.cosmostaion.base.BaseConstant;
import wannabit.io.cosmostaion.network.ApiClient;
import wannabit.io.cosmostaion.network.res.ResApiTxList;
import wannabit.io.cosmostaion.network.res.ResApiTxListCustom;
import wannabit.io.cosmostaion.task.CommonTask;
import wannabit.io.cosmostaion.task.TaskListener;
import wannabit.io.cosmostaion.task.TaskResult;
import wannabit.io.cosmostaion.utils.WLog;

import static wannabit.io.cosmostaion.base.BaseChain.COSMOS_MAIN;
import static wannabit.io.cosmostaion.base.BaseChain.COSMOS_TEST;
import static wannabit.io.cosmostaion.base.BaseChain.IRIS_MAIN;
import static wannabit.io.cosmostaion.base.BaseChain.IRIS_TEST;

public class ApiAccountTxsHistoryTask extends CommonTask {

    private String mAddress;
    private BaseChain mChain;

    public ApiAccountTxsHistoryTask(BaseApplication app, TaskListener listener, String address, BaseChain chain) {
        super(app, listener);
        this.mResult.taskType   = BaseConstant.TASK_FETCH_API_ADDRESS_HISTORY;
        this.mAddress = address;
        this.mChain = chain;
    }

    @Override
    protected TaskResult doInBackground(String... strings) {
        try {
            if (mChain.equals(BaseChain.KAVA_MAIN)) {
                Response<ArrayList<ResApiTxList.Data>> response = ApiClient.getKavaApi(mApp).getAccountTxs(mAddress, "50").execute();
                if (response.isSuccessful() && response.body() != null) {
                    mResult.resultData = response.body();
                    mResult.isSuccess = true;
                } else {
                    WLog.w("HistoryTask : NOk");
                }
            } else if (mChain.equals(BaseChain.KAVA_TEST)) {
                Response<ArrayList<ResApiTxList.Data>> response = ApiClient.getKavaTestApi(mApp).getAccountTxs(mAddress, "50").execute();
                if (response.isSuccessful() && response.body() != null) {
                    mResult.resultData = response.body();
                    mResult.isSuccess = true;
                } else {
                    WLog.w("HistoryTask : NOk");
                }

            } else if (mChain.equals(BaseChain.IOV_MAIN)) {
                Response<ArrayList<ResApiTxList.Data>> response = ApiClient.getIovApi(mApp).getAccountTxs(mAddress, "50").execute();
                if (response.isSuccessful() && response.body() != null) {
                    mResult.resultData = response.body();
                    mResult.isSuccess = true;
                } else {
                    WLog.w("HistoryTask : NOk");
                }

            } else if (mChain.equals(BaseChain.BAND_MAIN)) {
                Response<ArrayList<ResApiTxList.Data>> response = ApiClient.getBandApi(mApp).getAccountTxs(mAddress, "50").execute();
                if (response.isSuccessful() && response.body() != null) {
                    mResult.resultData = response.body();
                    mResult.isSuccess = true;
                } else {
                    WLog.w("HistoryTask : NOk");
                }

            } else if (mChain.equals(BaseChain.CERTIK_MAIN)) {
                Response<ArrayList<ResApiTxList.Data>> response = ApiClient.getCertikApi(mApp).getAccountTxs(mAddress, "50").execute();
                if (response.isSuccessful() && response.body() != null) {
                    mResult.resultData = response.body();
                    mResult.isSuccess = true;
                } else {
                    WLog.w("HistoryTask : NOk");
                }

            } else if (mChain.equals(BaseChain.CERTIK_TEST)) {
                Response<ArrayList<ResApiTxList.Data>> response = ApiClient.getCertikTestApi(mApp).getAccountTxs(mAddress, "50").execute();
                if (response.isSuccessful() && response.body() != null) {
                    mResult.resultData = response.body();
                    mResult.isSuccess = true;
                } else {
                    WLog.w("HistoryTask : NOk");
                }

            } else if (mChain.equals(BaseChain.SENTINEL_MAIN)) {
                Response<ArrayList<ResApiTxList.Data>> response = ApiClient.getSentinelApi(mApp).getAccountTxs(mAddress, "50").execute();
                if (response.isSuccessful() && response.body() != null) {
                    mResult.resultData = response.body();
                    mResult.isSuccess = true;
                } else {
                    WLog.w("HistoryTask : NOk");
                }

            } else if (mChain.equals(BaseChain.FETCHAI_MAIN)) {
//                WLog.w("FETCHAI_MAIN " + ApiClient.getFetchApi(mApp).getAccountTxs(mAddress, "50").request().url());
                Response<ArrayList<ResApiTxList.Data>> response = ApiClient.getFetchApi(mApp).getAccountTxs(mAddress, "50").execute();
                if (response.isSuccessful() && response.body() != null) {
                    mResult.resultData = response.body();
                    mResult.isSuccess = true;
                } else {
                    WLog.w("HistoryTask : NOk");
                }

            } else if (mChain.equals(BaseChain.SIF_MAIN)) {
                Response<ArrayList<ResApiTxList.Data>> response = ApiClient.getSifApi(mApp).getAccountTxs(mAddress, "50").execute();
                if (response.isSuccessful() && response.body() != null) {
                    mResult.resultData = response.body();
                    mResult.isSuccess = true;
                } else {
                    WLog.w("HistoryTask : NOk");
                }

            } else if (mChain.equals(BaseChain.KI_MAIN)) {
                Response<ArrayList<ResApiTxList.Data>> response = ApiClient.getKiApi(mApp).getAccountTxs(mAddress, "50").execute();
                if (response.isSuccessful() && response.body() != null) {
                    mResult.resultData = response.body();
                    mResult.isSuccess = true;
                } else {
                    WLog.w("HistoryTask : NOk");
                }

            }


            else if (mChain.equals(COSMOS_MAIN)) {
//                WLog.w("COSMOS_MAIN " + ApiClient.getCosmosApi(mApp).getAccountTxsCustom(mAddress, "50").request().url());
                Response<ArrayList<ResApiTxListCustom>> response = ApiClient.getCosmosApi(mApp).getAccountTxsCustom(mAddress, "50").execute();
                if (response.isSuccessful() && response.body() != null) {
                    mResult.resultData = response.body();
                    mResult.isSuccess = true;
                } else {
                    WLog.w("HistoryTask : NOk");
                }

            } else if (mChain.equals(IRIS_MAIN)) {
                Response<ArrayList<ResApiTxListCustom>> response = ApiClient.getIrisApi(mApp).getAccountTxsCustom(mAddress, "50").execute();
                if (response.isSuccessful() && response.body() != null) {
                    mResult.resultData = response.body();
                    mResult.isSuccess = true;
                } else {
                    WLog.w("HistoryTask : NOk");
                }

            } else if (mChain.equals(BaseChain.AKASH_MAIN)) {
                Response<ArrayList<ResApiTxListCustom>> response = ApiClient.getAkashApi(mApp).getAccountTxsCustom(mAddress, "50").execute();
                if (response.isSuccessful() && response.body() != null) {
                    mResult.resultData = response.body();
                    mResult.isSuccess = true;
                } else {
                    WLog.w("HistoryTask : NOk");
                }

            } else if (mChain.equals(BaseChain.PERSIS_MAIN)) {
                Response<ArrayList<ResApiTxListCustom>> response = ApiClient.getPersisApi(mApp).getAccountTxsCustom(mAddress, "50").execute();
                if (response.isSuccessful() && response.body() != null) {
                    mResult.resultData = response.body();
                    mResult.isSuccess = true;
                } else {
                    WLog.w("HistoryTask : NOk");
                }

            } else if (mChain.equals(BaseChain.CRYPTO_MAIN)) {
//                WLog.w("CRYTO_MAIN " + ApiClient.getCrytoApi(mApp).getAccountTxsCustom(mAddress, "50").request().url());
                Response<ArrayList<ResApiTxListCustom>> response = ApiClient.getCryptoApi(mApp).getAccountTxsCustom(mAddress, "50").execute();
                if (response.isSuccessful() && response.body() != null) {
                    mResult.resultData = response.body();
                    mResult.isSuccess = true;
                } else {
                    WLog.w("HistoryTask : NOk");
                }
            }


            else if (mChain.equals(COSMOS_TEST)) {
                Response<ArrayList<ResApiTxListCustom>> response = ApiClient.getCosmosTestApi(mApp).getAccountTxsCustom(mAddress, "50").execute();
                if (response.isSuccessful() && response.body() != null) {
                    mResult.resultData = response.body();
                    mResult.isSuccess = true;
                } else {
                    WLog.w("HistoryTask : NOk");
                }

            }else if (mChain.equals(IRIS_TEST)) {
                Response<ArrayList<ResApiTxListCustom>> response = ApiClient.getIrisTestApi(mApp).getAccountTxsCustom(mAddress, "50").execute();
                if (response.isSuccessful() && response.body() != null) {
                    mResult.resultData = response.body();
                    mResult.isSuccess = true;
                } else {
                    WLog.w("HistoryTask : NOk");
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
            WLog.w("ApiAccountTxsHistoryTask Error " + e.getMessage());
        }
        return mResult;
    }
}
