//
//  BaseNetWork.swift
//  Cosmostation
//
//  Created by 정용주 on 2020/12/09.
//  Copyright © 2020 wannabit. All rights reserved.
//

import Foundation
import GRPC
import NIO


class BaseNetWork {
    
<<<<<<< HEAD
    /*
    static func validatorUrl(_ chain: ChainType) -> String {
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_VALIDATORS
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_VALIDATORS
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_VALIDATORS
=======
    static func nodeInfoUrl(_ chain: ChainType?) -> String {
        if (chain == ChainType.BINANCE_MAIN) {
            return BNB_URL + "api/v1/node-info"
        } else if (chain == ChainType.OKEX_MAIN) {
            return OKEX_URL + "node_info"
        } else if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "node_info"
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "node_info"
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "node_info"
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "node_info"
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "node_info"
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "node_info"
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "node_info"
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "node_info"
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "node_info"
        }
        
        else if (chain == ChainType.BINANCE_TEST) {
            return BNB_TEST_URL + "api/v1/node-info"
        } else if (chain == ChainType.OKEX_TEST) {
            return OKEX_TEST_URL + "node_info"
        } else if (chain == ChainType.KAVA_TEST) {
            return KAVA_TEST_URL + "node_info"
        } else if (chain == ChainType.IOV_TEST) {
            return IOV_TEST_URL + "node_info"
        } else if (chain == ChainType.CERTIK_TEST) {
            return CERTIK_TEST_URL + "node_info"
        }
        return ""
    }
    
    static func accountInfoUrl(_ chain: ChainType?, _ address: String) -> String {
        if (chain == ChainType.BINANCE_MAIN) {
            return BNB_URL + "api/v1/account/" + address
        } else if (chain == ChainType.OKEX_MAIN) {
            return OKEX_URL + "auth/accounts/" + address
        } else if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "auth/accounts/" + address
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "auth/accounts/" + address
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "auth/accounts/" + address
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "auth/accounts/" + address
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "auth/accounts/" + address
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "auth/accounts/" + address
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "auth/accounts/" + address
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "auth/accounts/" + address
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "auth/accounts/" + address
        }
        
        else if (chain == ChainType.BINANCE_TEST) {
            return BNB_TEST_URL + "api/v1/account/" + address
        } else if (chain == ChainType.OKEX_TEST) {
            return OKEX_TEST_URL + "auth/accounts/" + address
        } else if (chain == ChainType.KAVA_TEST) {
            return KAVA_TEST_URL + "auth/accounts/" + address
        } else if (chain == ChainType.IOV_TEST) {
            return IOV_TEST_URL + "auth/accounts/" + address
        } else if (chain == ChainType.CERTIK_TEST) {
            return CERTIK_TEST_URL + "auth/accounts/" + address
        }
        return ""
    }
    
    static func validatorsUrl(_ chain: ChainType?) -> String {
        if (chain == ChainType.OKEX_MAIN) {
            return OKEX_URL + "staking/validators"
        } else if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "staking/validators"
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "staking/validators"
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "staking/validators"
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "staking/validators"
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "staking/validators"
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "staking/validators"
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "staking/validators"
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "staking/validators"
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "staking/validators"
        }
        
        else if (chain == ChainType.OKEX_TEST) {
            return OKEX_URL + "staking/validators"
        } else if (chain == ChainType.KAVA_TEST) {
            return KAVA_TEST_URL + "staking/validators"
        } else if (chain == ChainType.IOV_TEST) {
            return IOV_TEST_URL + "staking/validators"
        } else if (chain == ChainType.CERTIK_TEST) {
            return CERTIK_TEST_URL + "staking/validators"
        }
        return ""
    }
    
    static func validatorUrl(_ chain: ChainType?, _ opAddress: String) -> String {
        if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "staking/validators" + "/" + opAddress
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "staking/validators" + "/" + opAddress
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "staking/validators" + "/" + opAddress
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "staking/validators" + "/" + opAddress
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "staking/validators" + "/" + opAddress
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "staking/validators" + "/" + opAddress
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "staking/validators" + "/" + opAddress
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "staking/validators" + "/" + opAddress
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "staking/validators" + "/" + opAddress
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_VALIDATORS
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_VALIDATORS
        }
        return result
    }
    
<<<<<<< HEAD
    static func delegationUrl(_ chain: ChainType, _ address: String) -> String {
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_DELEGATIONS + address
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_DELEGATIONS + address
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_DELEGATIONS + address
=======
    static func bondingsUrl(_ chain: ChainType, _ address: String) -> String {
        if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "staking/delegators/" + address + "/delegations"
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "staking/delegators/" + address + "/delegations"
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "staking/delegators/" + address + "/delegations"
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "staking/delegators/" + address + "/delegations"
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "staking/delegators/" + address + "/delegations"
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "staking/delegators/" + address + "/delegations"
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "staking/delegators/" + address + "/delegations"
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "staking/delegators/" + address + "/delegations"
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "staking/delegators/" + address + "/delegations"
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_DELEGATIONS + address
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_DELEGATIONS + address
        }
        return result
    }
    
<<<<<<< HEAD
    static func undelegationUrl(_ chain: ChainType, _ address: String) -> String {
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_UNDELEGATIONS + address + COSMOS_MAIN_UNDELEGATIONS_T
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_UNDELEGATIONS + address + IRIS_MAIN_UNDELEGATIONS_T
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_UNDELEGATIONS + address + AKASH_MAIN_UNDELEGATIONS_T
=======
    static func bondingUrl(_ chain: ChainType?, _ address: String, _ opAddress: String) -> String {
        if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "staking/delegators/" + address + "/delegations/" + opAddress
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "staking/delegators/" + address + "/delegations/" + opAddress
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "staking/delegators/" + address + "/delegations/" + opAddress
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "staking/delegators/" + address + "/delegations/" + opAddress
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "staking/delegators/" + address + "/delegations/" + opAddress
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "staking/delegators/" + address + "/delegations/" + opAddress
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "staking/delegators/" + address + "/delegations/" + opAddress
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "staking/delegators/" + address + "/delegations/" + opAddress
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "staking/delegators/" + address + "/delegations/" + opAddress
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_UNDELEGATIONS + address + COSMOS_TEST_UNDELEGATIONS_T
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_UNDELEGATIONS + address + IRIS_TEST_UNDELEGATIONS_T
        }
        return result
    }
    
<<<<<<< HEAD
    static func balanceUrl(_ chain: ChainType, _ address: String) -> String {
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_BALANCE + address
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_BALANCE + address
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_BALANCE + address
=======
    static func unbondingsUrl(_ chain: ChainType, _ address: String) -> String {
        if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "staking/delegators/" + address + "/unbonding_delegations"
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "staking/delegators/" + address + "/unbonding_delegations"
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "staking/delegators/" + address + "/unbonding_delegations"
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "staking/delegators/" + address + "/unbonding_delegations"
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "staking/delegators/" + address + "/unbonding_delegations"
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "staking/delegators/" + address + "/unbonding_delegations"
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "staking/delegators/" + address + "/unbonding_delegations"
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "staking/delegators/" + address + "/unbonding_delegations"
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "staking/delegators/" + address + "/unbonding_delegations"
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_BALANCE + address
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_BALANCE + address
        }
        return result
    }
    
<<<<<<< HEAD
    static func authUrl(_ chain: ChainType, _ address: String) -> String {
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_AUTH + address
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_AUTH + address
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_AUTH + address
=======
    static func unbondingUrl(_ chain: ChainType?, _ address: String, _ opAddress: String) -> String {
        if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "staking/delegators/" + address + "/unbonding_delegations/" + opAddress
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "staking/delegators/" + address + "/unbonding_delegations/" + opAddress
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "staking/delegators/" + address + "/unbonding_delegations/" + opAddress
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "staking/delegators/" + address + "/unbonding_delegations/" + opAddress
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "staking/delegators/" + address + "/unbonding_delegations/" + opAddress
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "staking/delegators/" + address + "/unbonding_delegations/" + opAddress
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "staking/delegators/" + address + "/unbonding_delegations/" + opAddress
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "staking/delegators/" + address + "/unbonding_delegations/" + opAddress
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "staking/delegators/" + address + "/unbonding_delegations/" + opAddress
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_AUTH + address
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_AUTH + address
        }
        return result
    }
    
<<<<<<< HEAD
    static func rewardAddressUrl(_ chain: ChainType, _ address: String) -> String {
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_REWARD_ADDRESS + address + COSMOS_MAIN_REWARD_ADDRESS_T
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_REWARD_ADDRESS + address + IRIS_MAIN_REWARD_ADDRESS_T
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_REWARD_ADDRESS + address + AKASH_MAIN_REWARD_ADDRESS_T
=======
    static func redelegationsUrl(_ chain: ChainType?) -> String {
        if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "staking/redelegations"
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "staking/redelegations"
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "staking/redelegations"
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "staking/redelegations"
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "staking/redelegations"
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "staking/redelegations"
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "staking/redelegations"
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "staking/redelegations"
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "staking/redelegations"
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_REWARD_ADDRESS + address + COSMOS_TEST_REWARD_ADDRESS_T
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_REWARD_ADDRESS + address + IRIS_TEST_REWARD_ADDRESS_T
        }
        return result
    }
    
    static func rewardsUrl(_ chain: ChainType, _ address: String) -> String {
<<<<<<< HEAD
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_REWARDS + address + COSMOS_MAIN_REWARDS_T
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_REWARDS + address + IRIS_MAIN_REWARDS_T
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_REWARDS + address + AKASH_MAIN_REWARDS_T
=======
        if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "distribution/delegators/" + address + "/rewards"
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "distribution/delegators/" + address + "/rewards"
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "distribution/delegators/" + address + "/rewards"
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "distribution/delegators/" + address + "/rewards"
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "distribution/delegators/" + address + "/rewards"
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "distribution/delegators/" + address + "/rewards"
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "distribution/delegators/" + address + "/rewards"
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "distribution/delegators/" + address + "/rewards"
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "distribution/delegators/" + address + "/rewards"
        }
        
        else if (chain == ChainType.KAVA_TEST) {
            return KAVA_TEST_URL + "distribution/delegators/" + address + "/rewards"
        } else if (chain == ChainType.IOV_TEST) {
            return IOV_TEST_URL + "distribution/delegators/" + address + "/rewards"
        } else if (chain == ChainType.CERTIK_TEST) {
            return CERTIK_TEST_URL + "distribution/delegators/" + address + "/rewards"
        }
        return ""
    }
    
    static func rewardUrl(_ chain: ChainType?, _ address: String, _ opAddress: String) -> String {
        if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "distribution/delegators/" + address + "/rewards/" + opAddress
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "distribution/delegators/" + address + "/rewards/" + opAddress
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "distribution/delegators/" + address + "/rewards/" + opAddress
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "distribution/delegators/" + address + "/rewards/" + opAddress
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "distribution/delegators/" + address + "/rewards/" + opAddress
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "distribution/delegators/" + address + "/rewards/" + opAddress
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "distribution/delegators/" + address + "/rewards/" + opAddress
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "distribution/delegators/" + address + "/rewards/" + opAddress
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "distribution/delegators/" + address + "/rewards/" + opAddress
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_REWARDS + address + COSMOS_TEST_REWARDS_T
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_REWARDS + address + IRIS_TEST_REWARDS_T
        }
        return result
    }
    
<<<<<<< HEAD
    static func redelegation(_ chain: ChainType, _ address: String) -> String {
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_REDELEGATION + address + COSMOS_MAIN_REDELEGATION_T
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_REDELEGATION + address + IRIS_MAIN_REDELEGATION
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_REDELEGATION + address + AKASH_MAIN_REDELEGATION_T
=======
    static func rewardAddressUrl(_ chain: ChainType?, _ address: String) -> String {
        if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "distribution/delegators/" + address + "/withdraw_address"
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "distribution/delegators/" + address + "/withdraw_address"
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "distribution/delegators/" + address + "/withdraw_address"
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "distribution/delegators/" + address + "/withdraw_address"
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "distribution/delegators/" + address + "/withdraw_address"
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "distribution/delegators/" + address + "/withdraw_address"
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "distribution/delegators/" + address + "/withdraw_address"
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "distribution/delegators/" + address + "/withdraw_address"
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "distribution/delegators/" + address + "/withdraw_address"
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_REDELEGATION + address + COSMOS_TEST_REDELEGATION_T
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_REDELEGATION + address + IRIS_TEST_REDELEGATION_T
        }
        return result
    }
    
<<<<<<< HEAD
    static func mintParamUrl(_ chain: ChainType) -> String {
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_MINT_PARAM
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_MINT_PARAM
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_MINT_PARAM
=======
    static func paramMintUrl(_ chain: ChainType) -> String {
        if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "minting/parameters"
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "minting/parameters"
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "minting/parameters"
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "minting/parameters"
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "minting/parameters"
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "minting/parameters"
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "minting/parameters"
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "minting/parameters"
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_MINT_PARAM
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_MINT_PARAM
        }
        return result
    }
    
    static func inflationUrl(_ chain: ChainType) -> String {
<<<<<<< HEAD
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_INFLATION
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_INFLATION
=======
        if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "minting/inflation"
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "minting/inflation"
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "minting/inflation"
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "minting/inflation"
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "minting/inflation"
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "minting/inflation"
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "minting/inflation"
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "minting/inflation"
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_INFLATION
        }
        return result
    }
    
    static func provisionUrl(_ chain: ChainType) -> String {
<<<<<<< HEAD
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_PROVISIONS
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_PROVISIONS
=======
        if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "minting/annual-provisions"
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "minting/annual-provisions"
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "minting/annual-provisions"
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "minting/annual-provisions"
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "minting/annual-provisions"
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "minting/annual-provisions"
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "minting/annual-provisions"
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "minting/annual-provisions"
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_PROVISIONS
        }
        return result
    }
    
    static func stakingPoolUrl(_ chain: ChainType) -> String {
<<<<<<< HEAD
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_STAKING_POOL
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_STAKING_POOL
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_STAKING_POOL
=======
        if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "staking/pool"
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "staking/pool"
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "staking/pool"
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "staking/pool"
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "staking/pool"
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "staking/pool"
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "staking/pool"
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "staking/pool"
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "staking/pool"
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_STAKING_POOL
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_STAKING_POOL
        }
        return result
    }
    
<<<<<<< HEAD
    static func irisTokensUrl(_ chain: ChainType) -> String {
        var result = ""
        if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_TOKENS
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_TOKENS
=======
    static func proposalsUrl(_ chain: ChainType?) -> String {
        if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "gov/proposals"
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "gov/proposals"
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "gov/proposals"
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "gov/proposals"
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "gov/proposals"
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "gov/proposals"
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "gov/proposals"
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "gov/proposals"
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "gov/proposals"
        }
        
        else if (chain == ChainType.KAVA_TEST) {
            return KAVA_TEST_URL + "gov/proposals"
        } else if (chain == ChainType.IOV_TEST) {
            return IOV_TEST_URL + "gov/proposals"
        } else if (chain == ChainType.CERTIK_TEST) {
            return CERTIK_TEST_URL + "gov/proposals"
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        return result
    }
    
<<<<<<< HEAD
    
    
    static func singleValidatorUrl(_ chain: ChainType, _ opAddress: String) -> String {
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_SINGLE_VALIDATOR + opAddress
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_SINGLE_VALIDATOR + opAddress
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_SINGLE_VALIDATOR + opAddress
=======
    static func proposalUrl(_ chain: ChainType?, _ id: String) -> String {
        if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "gov/proposals" + "/" + id
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "gov/proposals" + "/" + id
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "gov/proposals" + "/" + id
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "gov/proposals" + "/" + id
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "gov/proposals" + "/" + id
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "gov/proposals" + "/" + id
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "gov/proposals" + "/" + id
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "gov/proposals" + "/" + id
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "gov/proposals" + "/" + id
        }
        
        else if (chain == ChainType.KAVA_TEST) {
            return KAVA_TEST_URL + "gov/proposals" + "/" + id
        } else if (chain == ChainType.IOV_TEST) {
            return IOV_TEST_URL + "gov/proposals" + "/" + id
        } else if (chain == ChainType.CERTIK_TEST) {
            return CERTIK_TEST_URL + "gov/proposals" + "/" + id
        }
        return ""
    }
    
    static func tallyUrl(_ chain: ChainType?, _ id: String) -> String {
        if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "gov/proposals" + "/" + id + "/tally"
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "gov/proposals" + "/" + id + "/tally"
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "gov/proposals" + "/" + id + "/tally"
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "gov/proposals" + "/" + id + "/tally"
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "gov/proposals" + "/" + id + "/tally"
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "gov/proposals" + "/" + id + "/tally"
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "gov/proposals" + "/" + id + "/tally"
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "gov/proposals" + "/" + id + "/tally"
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "gov/proposals" + "/" + id + "/tally"
        }
        
        else if (chain == ChainType.KAVA_TEST) {
            return KAVA_TEST_URL + "gov/proposals" + "/" + id + "/tally"
        } else if (chain == ChainType.IOV_TEST) {
            return IOV_TEST_URL + "gov/proposals" + "/" + id + "/tally"
        } else if (chain == ChainType.CERTIK_TEST) {
            return CERTIK_TEST_URL + "gov/proposals" + "/" + id + "/tally"
        }
        return ""
    }
    
    static func voteUrl(_ chain: ChainType?, _ id: String, _ address: String) -> String {
        if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "gov/proposals" +  "/" + id + "/votes/" + address
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "gov/proposals" + "/" + id + "/votes/" + address
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "gov/proposals" + "/" + id + "/votes/" + address
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "gov/proposals" + "/" + id + "/votes/" + address
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "gov/proposals" + "/" + id + "/votes/" + address
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "gov/proposals" + "/" + id + "/votes/" + address
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "gov/proposals" + "/" + id + "/votes/" + address
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "gov/proposals" + "/" + id + "/votes/" + address
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "gov/proposals" + "/" + id + "/votes/" + address
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_SINGLE_VALIDATOR + opAddress
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_SINGLE_VALIDATOR + opAddress
        }
        return result
    }
    
<<<<<<< HEAD
    static func singleDelegationUrl(_ chain: ChainType, _ address: String, _ opAddress: String) -> String {
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_SINGLE_DELEGATION + opAddress + COSMOS_MAIN_SINGLE_DELEGATION_M + address
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_SINGLE_DELEGATION + opAddress + IRIS_MAIN_SINGLE_DELEGATION_M + address
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_SINGLE_DELEGATION + opAddress + AKASH_MAIN_SINGLE_DELEGATION_M + address
=======
    static func proposerUrl(_ chain: ChainType?, _ id: String) -> String {
        if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "gov/proposals" + "/" + id + "/proposer"
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "gov/proposals" + "/" + id + "/proposer"
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "gov/proposals" + "/" + id + "/proposer"
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "gov/proposals" + "/" + id + "/proposer"
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "gov/proposals" + "/" + id + "/proposer"
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "gov/proposals" + "/" + id + "/proposer"
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "gov/proposals" + "/" + id + "/proposer"
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "gov/proposals" + "/" + id + "/proposer"
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "gov/proposals" + "/" + id + "/proposer"
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_SINGLE_DELEGATION + opAddress + COSMOS_TEST_SINGLE_DELEGATION_M + address
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_SINGLE_DELEGATION + opAddress + IRIS_TEST_SINGLE_DELEGATION_M + address
        }
        return result
    }
    
<<<<<<< HEAD
    static func proposals(_ chain: ChainType) -> String {
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_PROPOSALS
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_PROPOSALS
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_PROPOSALS
=======
    static func votesUrl(_ chain: ChainType?, _ id: String) -> String {
        if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "gov/proposals" + "/" + id + "/votes"
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "gov/proposals" + "/" + id + "/votes"
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "gov/proposals" + "/" + id + "/votes"
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "gov/proposals" + "/" + id + "/votes"
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "gov/proposals" + "/" + id + "/votes"
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "gov/proposals" + "/" + id + "/votes"
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "gov/proposals" + "/" + id + "/votes"
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "gov/proposals" + "/" + id + "/votes"
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "gov/proposals" + "/" + id + "/votes"
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_PROPOSALS
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_PROPOSALS
        }
        return result
    }
    
<<<<<<< HEAD
    static func proposalDetail(_ chain: ChainType, _ proposal_id: String) -> String {
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_PROPOSAL + proposal_id
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_PROPOSAL + proposal_id
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_PROPOSAL + proposal_id
=======
    
    static func txUrl(_ chain: ChainType?, _ txhash: String) -> String {
        if (chain == ChainType.BINANCE_MAIN) {
            return BNB_URL + "api/v1/tx/" + txhash
        } else if (chain == ChainType.OKEX_MAIN) {
            return OKEX_URL + "txs/" + txhash
        } else if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "txs/" + txhash
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "txs/" + txhash
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "txs/" + txhash
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "txs/" + txhash
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "txs/" + txhash
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "txs/" + txhash
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "txs/" + txhash
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "txs/" + txhash
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "txs/" + txhash
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_PROPOSAL + proposal_id
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_PROPOSAL + proposal_id
        }
        return result
    }
    
<<<<<<< HEAD
    static func proposalTally(_ chain: ChainType, _ proposal_id: String) -> String {
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_PROPOSAL + proposal_id + "/tally"
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_PROPOSAL + proposal_id + "/tally"
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_PROPOSAL + proposal_id + "/tally"
=======
    static func broadcastUrl(_ chain: ChainType?) -> String {
        if (chain == ChainType.OKEX_MAIN) {
            return OKEX_URL + "txs"
        } else if (chain == ChainType.KAVA_MAIN) {
            return KAVA_URL + "txs"
        } else if (chain == ChainType.BAND_MAIN) {
            return BAND_URL + "txs"
        } else if (chain == ChainType.IOV_MAIN) {
            return IOV_URL + "txs"
        } else if (chain == ChainType.CERTIK_MAIN) {
            return CERTIK_URL + "txs"
        } else if (chain == ChainType.SECRET_MAIN) {
            return SECRET_URL + "txs"
        } else if (chain == ChainType.SENTINEL_MAIN) {
            return SENTINEL_URL + "txs"
        } else if (chain == ChainType.FETCH_MAIN) {
            return FETCH_URL + "txs"
        } else if (chain == ChainType.SIF_MAIN) {
            return SIF_URL + "txs"
        } else if (chain == ChainType.KI_MAIN) {
            return KI_URL + "txs"
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_PROPOSAL + proposal_id + "/tally"
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_PROPOSAL + proposal_id + "/tally"
        }
        return result
    }
    
    static func proposalVoterList(_ chain: ChainType, _ proposal_id: String) -> String {
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_PROPOSAL + proposal_id + "/votes"
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_PROPOSAL + proposal_id + "/votes"
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_PROPOSAL + proposal_id + "/votes"
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_PROPOSAL + proposal_id + "/votes"
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_PROPOSAL + proposal_id + "/votes"
        }
        return result
    }
    
    static func proposalMyVote(_ chain: ChainType, _ proposal_id: String, _ address: String) -> String {
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_PROPOSAL + proposal_id + "/votes/" + address
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_PROPOSAL + proposal_id + "/votes/" + address
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_PROPOSAL + proposal_id + "/votes/" + address
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_PROPOSAL + proposal_id + "/votes/" + address
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_PROPOSAL + proposal_id + "/votes/" + address
        }
        return result
    }
    
    
    static func postTxUrl(_ chain: ChainType) -> String {
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_BORAD_TX
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_BORAD_TX
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_BORAD_TX
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_BORAD_TX
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_BORAD_TX
        }
        return result
    }
     */
    
    
    static func accountHistory(_ chain: ChainType, _ address: String) -> String {
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_HISTORY + address
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_HISTORY + address
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_HISTORY + address
        } else if (chain == ChainType.PERSIS_MAIN) {
            result = PERSIS_MAIN_HISTORY + address
        } else if (chain == ChainType.CRYPTO_MAIN) {
<<<<<<< HEAD
            result = CRYTO_MAIN_HISTORY + address
=======
            result = CRYTO_API + "v1/account/txs/" + address
        }
        else if (chain == ChainType.KAVA_MAIN) {
            result = KAVA_API + "v1/account/txs/" + address
        } else if (chain == ChainType.BAND_MAIN) {
            result = BAND_API + "v1/account/txs/" + address
        } else if (chain == ChainType.CERTIK_MAIN) {
            result = CERTIK_API + "v1/account/txs/" + address
        } else if (chain == ChainType.IOV_MAIN) {
            result = IOV_API + "v1/account/txs/" + address
        } else if (chain == ChainType.SENTINEL_MAIN) {
            result = SENTINEL_API + "v1/account/txs/" + address
        } else if (chain == ChainType.FETCH_MAIN) {
            result = FETCH_API + "v1/account/txs/" + address
        } else if (chain == ChainType.SIF_MAIN) {
            result = SIF_API + "v1/account/txs/" + address
        } else if (chain == ChainType.KI_MAIN) {
            result = KI_API + "v1/account/txs/" + address
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_HISTORY + address
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_HISTORY + address
        }
        return result
    }
    
    static func accountStakingHistory(_ chain: ChainType, _ address: String, _ valAddress: String) -> String {
        var result = ""
        if (chain == ChainType.COSMOS_MAIN) {
            result = COSMOS_MAIN_HISTORY + address + "/" + valAddress
        } else if (chain == ChainType.IRIS_MAIN) {
            result = IRIS_MAIN_HISTORY + address + "/" + valAddress
        } else if (chain == ChainType.AKASH_MAIN) {
            result = AKASH_MAIN_HISTORY + address + "/" + valAddress
        } else if (chain == ChainType.PERSIS_MAIN) {
            result = PERSIS_MAIN_HISTORY + address + "/" + valAddress
        } else if (chain == ChainType.CRYPTO_MAIN) {
<<<<<<< HEAD
            result = CRYTO_MAIN_HISTORY + address + "/" + valAddress
=======
            result = CRYTO_API + "v1/account/txs/" + address + "/" + valAddress
        }
        else if (chain == ChainType.KAVA_MAIN) {
            result = KAVA_API + "v1/account/txs/" + address + "/" + valAddress
        } else if (chain == ChainType.BAND_MAIN) {
            result = BAND_API + "v1/account/txs/" + address + "/" + valAddress
        } else if (chain == ChainType.CERTIK_MAIN) {
            result = CERTIK_API + "v1/account/txs/" + address + "/" + valAddress
        } else if (chain == ChainType.IOV_MAIN) {
            result = IOV_API + "v1/account/txs/" + address + "/" + valAddress
        } else if (chain == ChainType.SENTINEL_MAIN) {
            result = SENTINEL_API + "v1/account/txs/" + address + "/" + valAddress
        } else if (chain == ChainType.FETCH_MAIN) {
            result = FETCH_API + "v1/account/txs/" + address + "/" + valAddress
        } else if (chain == ChainType.SIF_MAIN) {
            result = SIF_API + "v1/account/txs/" + address + "/" + valAddress
        } else if (chain == ChainType.KI_MAIN) {
            result = KI_API + "v1/account/txs/" + address + "/" + valAddress
>>>>>>> b2dab5419736fcb45af41a45373728510dc2b5ca
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            result = COSMOS_TEST_HISTORY + address + "/" + valAddress
        } else if (chain == ChainType.IRIS_TEST) {
            result = IRIS_TEST_HISTORY + address + "/" + valAddress
        }
        return result
    }
    
    
    
    
    
    
    
    static func getConnection(_ chain: ChainType, _ group: MultiThreadedEventLoopGroup) -> ClientConnection? {
        if (chain == ChainType.COSMOS_MAIN) {
            return ClientConnection.insecure(group: group).connect(host: "lcd-cosmos-app.cosmostation.io", port: 9090)
            
        } else if (chain == ChainType.IRIS_MAIN) {
            return ClientConnection.insecure(group: group).connect(host: "lcd-iris-app.cosmostation.io", port: 9090)
            
        } else if (chain == ChainType.AKASH_MAIN) {
            return ClientConnection.insecure(group: group).connect(host: "lcd-akash-app.cosmostation.io", port: 9090)
            
        } else if (chain == ChainType.PERSIS_MAIN) {
            return ClientConnection.insecure(group: group).connect(host: "lcd-persistence-app.cosmostation.io", port: 9090)
            
        } else if (chain == ChainType.CRYPTO_MAIN) {
            return ClientConnection.insecure(group: group).connect(host: "lcd-cryptocom.cosmostation.io", port: 9090)
        }
        
        else if (chain == ChainType.COSMOS_TEST) {
            return ClientConnection.insecure(group: group).connect(host: "lcd-office.cosmostation.io", port: 9090)
            
        } else if (chain == ChainType.IRIS_TEST) {
            return ClientConnection.insecure(group: group).connect(host: "lcd-office.cosmostation.io", port: 9095)
            
        }
        return nil
    }
    
    static func getCallOptions() -> CallOptions {
        var callOptions = CallOptions()
        callOptions.timeLimit = TimeLimit.timeout(TimeAmount.milliseconds(8000))
        return callOptions
    }
    
}

