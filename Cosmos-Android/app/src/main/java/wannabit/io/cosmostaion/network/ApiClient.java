package wannabit.io.cosmostaion.network;

import android.content.Context;

import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;
import wannabit.io.cosmostaion.R;

public class ApiClient {

    //Services for Cosmostation wallet api
    private static Cosmostation cosmostation = null;
    public static Cosmostation getCosmostation(Context c) {
        if (cosmostation == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_css))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                cosmostation = retrofit.create(Cosmostation.class);
            }
        }
        return cosmostation;
    }


    //Services for Cosmos api
    private static HistoryApi api_cosmos = null;
    public static HistoryApi getCosmosApi(Context c) {
        if (api_cosmos == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_api_cosmos_main))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                api_cosmos = retrofit.create(HistoryApi.class);
            }
        }
        return api_cosmos;
    }


    //Services for Iris history api mainnet
    private static HistoryApi api_iris = null;
    public static HistoryApi getIrisApi(Context c) {
        if (api_iris == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_api_iris_main))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                api_iris = retrofit.create(HistoryApi.class);
            }
        }
        return api_iris;
    }


    //Services for Binance net
    private static BinanceChain service_binance = null;
    public static BinanceChain getBnbChain(Context c) {
        if (service_binance == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_main_bnb))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                service_binance = retrofit.create(BinanceChain.class);
            }
        }
        return service_binance;
    }

    //Services for BinanceTest net
    private static BinanceChain service_binance_test = null;
    public static BinanceChain getBnbTestChain(Context c) {
        if (service_binance_test == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_test_bnb))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                service_binance_test = retrofit.create(BinanceChain.class);
            }
        }
        return service_binance_test;
    }

    //Faucet for BinanceTest net
    private static BinanceChain service_binance_faucet = null;
    public static BinanceChain getBnbTestFaucet(Context c) {
        if (service_binance_faucet == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_test_bnb_faucet))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                service_binance_faucet = retrofit.create(BinanceChain.class);
            }
        }
        return service_binance_faucet;
    }


    //Services for KAVA chain
    private static KavaChain service_kava = null;
    public static KavaChain getKavaChain(Context c) {
        if (service_kava == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_lcd_kava_main))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                service_kava = retrofit.create(KavaChain.class);
            }
        }
        return service_kava;
    }

    //Services for KAVA api
    private static HistoryApi api_kava = null;
    public static HistoryApi getKavaApi(Context c) {
        if (api_kava == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_api_kava_main))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                api_kava = retrofit.create(HistoryApi.class);
            }
        }
        return api_kava;
    }

    //Services for KAVATest chain
    private static KavaChain service_kava_test = null;
    public static KavaChain getKavaTestChain(Context c) {
        if (service_kava_test == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_lcd_kava_test))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                service_kava_test = retrofit.create(KavaChain.class);
            }
        }
        return service_kava_test;
    }

    //Services for KAVATest api
    private static HistoryApi api_kava_test = null;
    public static HistoryApi getKavaTestApi(Context c) {
        if (api_kava_test == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_api_kava_test))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                api_kava_test = retrofit.create(HistoryApi.class);
            }
        }
        return api_kava_test;
    }

    //Rest for IOV main net
    private static IovChain service_iov = null;
    public static IovChain getIovChain(Context c) {
        if (service_iov == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_lcd_iov_main))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                service_iov = retrofit.create(IovChain.class);
            }
        }
        return service_iov;
    }

    //Services for IOV api
    private static HistoryApi api_iov = null;
    public static HistoryApi getIovApi(Context c) {
        if (api_iov == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_api_iov_main))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                api_iov = retrofit.create(HistoryApi.class);
            }
        }
        return api_iov;
    }

    //Service for IOV testnet
    private static IovChain service_iov_test = null;
    public static IovChain getIovTestChain(Context c) {
        if (service_iov_test == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_lcd_iov_test))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                service_iov_test = retrofit.create(IovChain.class);
            }
        }
        return service_iov_test;
    }

    //Rest for Band main net
    private static BandChain service_band = null;
    public static BandChain getBandChain(Context c) {
        if (service_band == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_lcd_band_main))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                service_band = retrofit.create(BandChain.class);
            }
        }
        return service_band;
    }

    //Services for Band api
    private static HistoryApi api_band = null;
    public static HistoryApi getBandApi(Context c) {
        if (api_band == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_api_band_main))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                api_band = retrofit.create(HistoryApi.class);
            }
        }
        return api_band;
    }


    //Services for Okex mainnet chain
    private static OkChain service_ok = null;
    public static OkChain getOkexChain(Context c) {
        if (service_ok == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_lcd_ok))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                service_ok = retrofit.create(OkChain.class);
            }
        }
        return service_ok;
    }

    //Services for OkTest chain
    private static OkChain service_ok_test = null;
    public static OkChain getOkTestChain(Context c) {
        if (service_ok_test == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_lcd_ok_test))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                service_ok_test = retrofit.create(OkChain.class);
            }
        }
        return service_ok_test;
    }




    //Services for Certik mainnet
    private static CertikChain service_certik = null;
    public static CertikChain getCertikChain(Context c) {
        if (service_certik == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_lcd_certik))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                service_certik = retrofit.create(CertikChain.class);
            }
        }
        return service_certik;
    }

    //Services for Certik mainnet api
    private static HistoryApi api_certik = null;
    public static HistoryApi getCertikApi(Context c) {
        if (api_certik == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_api_certik))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                api_certik = retrofit.create(HistoryApi.class);
            }
        }
        return api_certik;
    }

    //Services for Certik test chain
    private static CertikChain service_certik_test = null;
    public static CertikChain getCertikTestChain(Context c) {
        if (service_certik_test == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_lcd_certik_test))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                service_certik_test = retrofit.create(CertikChain.class);
            }
        }
        return service_certik_test;
    }

    //Services for Certik test api
    private static HistoryApi api_certik_test = null;
    public static HistoryApi getCertikTestApi(Context c) {
        if (api_certik_test == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_api_certik_test))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                api_certik_test = retrofit.create(HistoryApi.class);
            }
        }
        return api_certik_test;
    }




    //Services for Secret mainnet
    private static SecretChain service_secret = null;
    public static SecretChain getSecretChain(Context c) {
        if (service_secret == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_lcd_secret))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                service_secret = retrofit.create(SecretChain.class);
            }
        }
        return service_secret;
    }


    //Services for Akash mainnet api
    private static HistoryApi api_akash = null;
    public static HistoryApi getAkashApi(Context c) {
        if (api_akash == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_api_akash))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                api_akash = retrofit.create(HistoryApi.class);
            }
        }
        return api_akash;
    }

    //Services for Persistence mainnet api
    private static HistoryApi api_persis = null;
    public static HistoryApi getPersisApi(Context c) {
        if (api_persis == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_api_persis))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                api_persis = retrofit.create(HistoryApi.class);
            }
        }
        return api_persis;
    }



    //Services for Sentinel mainnet
    private static SentinelChain service_sentinel = null;
    public static SentinelChain getSentinelChain(Context c) {
        if (service_sentinel == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_lcd_sentinel))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                service_sentinel = retrofit.create(SentinelChain.class);
            }
        }
        return service_sentinel;
    }

    //Services for Sentinel mainnet api
    private static HistoryApi api_sentinel = null;
    public static HistoryApi getSentinelApi(Context c) {
        if (api_sentinel == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_api_sentinel))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                api_sentinel = retrofit.create(HistoryApi.class);
            }
        }
        return api_sentinel;
    }

    //Services for fetchAi mainnet
    private static FetchAiChain service_fetch = null;
    public static FetchAiChain getFetchChain(Context c) {
        if (service_fetch == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_lcd_fetch))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                service_fetch = retrofit.create(FetchAiChain.class);
            }
        }
        return service_fetch;
    }

    //Services for fetchAi mainnet api
    private static HistoryApi api_fetch = null;
    public static HistoryApi getFetchApi(Context c) {
        if (api_fetch == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_api_fetch))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                api_fetch = retrofit.create(HistoryApi.class);
            }
        }
        return api_fetch;
    }



    //Services for Crypto.org mainnet api
    private static HistoryApi api_crypto = null;
    public static HistoryApi getCryptoApi(Context c) {
        if (api_crypto == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_api_crypto))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                api_crypto = retrofit.create(HistoryApi.class);
            }
        }
        return api_crypto;
    }

    //Services for sifChain mainnet
    private static SifChain service_sif = null;
    public static SifChain getSifChain(Context c) {
        if (service_sif == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_lcd_sif))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                service_sif = retrofit.create(SifChain.class);
            }
        }
        return service_sif;
    }

    //Services for sifChain mainnet api
    private static HistoryApi api_sif = null;
    public static HistoryApi getSifApi(Context c) {
        if (api_sif == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_api_sif))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                api_sif = retrofit.create(HistoryApi.class);
            }
        }
        return api_sif;
    }

    //Services for kifoundation mainnet
    private static KiChain service_ki = null;
    public static KiChain getKiChain(Context c) {
        if (service_ki == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_lcd_ki))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                service_ki = retrofit.create(KiChain.class);
            }
        }
        return service_ki;
    }

    //Services for kifoundation mainnet api
    private static HistoryApi api_ki = null;
    public static HistoryApi getKiApi(Context c) {
        if (api_ki == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_api_ki))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                api_ki = retrofit.create(HistoryApi.class);
            }
        }
        return api_ki;
    }




    //Services for Cosmos Test api
    private static HistoryApi api_cosmos_test = null;
    public static HistoryApi getCosmosTestApi(Context c) {
        if (api_cosmos_test == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_api_cosmos_test))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                api_cosmos_test = retrofit.create(HistoryApi.class);
            }
        }
        return api_cosmos_test;
    }


    //Services for Iris Test api
    private static HistoryApi api_iris_test = null;
    public static HistoryApi getIrisTestApi(Context c) {
        if (api_iris_test == null) {
            synchronized (ApiClient.class) {
                Retrofit retrofit = new Retrofit.Builder()
                        .baseUrl(c.getString(R.string.url_api_iris_test))
                        .addConverterFactory(GsonConverterFactory.create())
                        .build();
                api_iris_test = retrofit.create(HistoryApi.class);
            }
        }
        return api_iris_test;
    }





    private static CoinGeckoService coingeckoService = null;
    public static CoinGeckoService getCGCClient(Context c) {
        if (coingeckoService == null) {
            synchronized (ApiClient.class) {
                if (coingeckoService == null)  {
                    Retrofit retrofit = new Retrofit.Builder()
                            .baseUrl(c.getString(R.string.url_coingecko))
                            .addConverterFactory(GsonConverterFactory.create())
                            .build();
                    coingeckoService = retrofit.create(CoinGeckoService.class);
                }
            }
        }
        return coingeckoService;
    }

}
