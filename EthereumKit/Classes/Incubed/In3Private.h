#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface In3Private : NSObject

// Methods
FOUNDATION_EXPORT NSString *const GET_BLOCK_BY_NUMBER;
FOUNDATION_EXPORT NSString *const BLOCK_BY_HASH;
FOUNDATION_EXPORT NSString *const BLOCK_NUMBER;
FOUNDATION_EXPORT NSString *const GAS_PRICE;
FOUNDATION_EXPORT NSString *const CHAIN_ID;
FOUNDATION_EXPORT NSString *const CALL;
FOUNDATION_EXPORT NSString *const ESTIMATE_GAS;
FOUNDATION_EXPORT NSString *const GET_BALANCE;
FOUNDATION_EXPORT NSString *const GET_CODE;
FOUNDATION_EXPORT NSString *const GET_STORAGE_AT;
FOUNDATION_EXPORT NSString *const GET_BLOCK_TRANSACTION_COUNT_BY_HASH;
FOUNDATION_EXPORT NSString *const GET_BLOCK_TRANSACTION_COUNT_BY_NUMBER;
FOUNDATION_EXPORT NSString *const GET_FILTER_CHANGES;
FOUNDATION_EXPORT NSString *const GET_FILTER_LOGS;
FOUNDATION_EXPORT NSString *const GET_LOGS;
FOUNDATION_EXPORT NSString *const GET_TRANSACTION_BY_BLOCK_HASH_AND_INDEX;
FOUNDATION_EXPORT NSString *const GET_TRANSACTION_BY_BLOCK_NUMBER_AND_INDEX;
FOUNDATION_EXPORT NSString *const GET_TRANSACTION_BY_HASH;
FOUNDATION_EXPORT NSString *const GET_TRANSACTION_COUNT;
FOUNDATION_EXPORT NSString *const GET_TRANSACTION_RECEIPT;
FOUNDATION_EXPORT NSString *const GET_UNCLE_BY_BLOCK_NUMBER_AND_INDEX;
FOUNDATION_EXPORT NSString *const GET_UNCLE_COUNT_BY_BLOCK_HASH;
FOUNDATION_EXPORT NSString *const GET_UNCLE_COUNT_BY_BLOCK_NUMBER;
FOUNDATION_EXPORT NSString *const NEW_BLOCK_FILTER;
FOUNDATION_EXPORT NSString *const NEW_FILTER;
FOUNDATION_EXPORT NSString *const UNINSTALL_FILTER;
FOUNDATION_EXPORT NSString *const SEND_RAW_TRANSACTION;
FOUNDATION_EXPORT NSString *const SEND_TRANSACTION;
FOUNDATION_EXPORT NSString *const ABI_ENCODE;
FOUNDATION_EXPORT NSString *const ABI_DECODE;
FOUNDATION_EXPORT NSString *const CHECKSUM_ADDRESS;
FOUNDATION_EXPORT NSString *const ENS;

- (instancetype)initWithChainId:(UInt32)chain_id;

- (UInt64)blockNumber;
- (UInt64)transactionCount:(NSData *)address;
- (bool)transactionReceipt:(NSData *)transactionHash;
- (bool)transactionExist:(NSData *)transactionHash;

- (NSString *)rpcCall:(NSString *)method params:(NSString *)parameters didFailWithError:(NSError **)error;

@end

NS_ASSUME_NONNULL_END