export RUST_LOG=${RUST_LOG:-solana=info,solana_runtime::message_processor=info} # if RUST_LOG is unset, default to info
export RUST_BACKTRACE=full

./bin/solana-validator \
    --identity ./config/validator-keypair.json \
    --known-validator HXQyiQxmVipgohFSDex3TSyFkFp6yttF1T3Rdp7fnfZP \
    --ledger ./ledger \
    --rpc-port 8899 \
    --full-rpc-api \
	--no-voting \
    --rpc-bind-address 0.0.0.0 \
	--only-known-rpc \
	--gossip-host 172.31.11.97 \
	--gossip-port 8001 \
    --entrypoint 52.10.174.63:8001 \
	--public-rpc-address 172.31.11.97:8899 \
	--enable-rpc-transaction-history \
	--enable-extended-tx-metadata-storage \
	--no-wait-for-vote-to-start-leader \
	--no-os-network-limits-test \
	--rpc-pubsub-enable-block-subscription \
	--rpc-pubsub-enable-vote-subscription \
	--account-index program-id \
	--account-index spl-token-owner \
	--account-index spl-token-mint \
	--accounts-db-cache-limit-mb 102400 \
	--accounts-index-memory-limit-mb 40960 \
	--accounts-index-scan-results-limit-mb 40960 \
	--limit-ledger-size 300000000 \
    --expected-genesis-hash Ep5wb4kbMk8yHqV4jMXNqDiMWnNtnTh8jX6WY59Y8Qvj \
    --wal-recovery-mode skip_any_corrupted_record \
	--log ./logs/node.log &
#/home/ubuntu/solana-validator/solana-validator.log

#--log /home/ubuntu/solana-validator/solana-validator.log
#   --no-voting \
#	--private-rpc \
#   --only-known-rpc \
