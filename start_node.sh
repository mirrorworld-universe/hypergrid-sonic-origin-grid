export RUST_LOG=${RUST_LOG:-solana=info,solana_runtime::message_processor=info,solana_metrics::metrics=warn}
export RUST_BACKTRACE=full

./bin/solana-validator \
  --identity ./config/validator-keypair.json \
  --known-validator CQqu5MsTpH1mTwEsZ75QzPtXGTz9ziEvKwpcAstKG9WJ \
  --ledger ./ledger \
	--no-voting \
  --rpc-port 8899 \
  --full-rpc-api \
  --rpc-bind-address 0.0.0.0 \
	--only-known-rpc \
	--gossip-host xxx.xxx.xxx.xxx \
	--gossip-port 8001 \
  --entrypoint 52.10.174.63:8001 \
	--public-rpc-address xxx.xxx.xxx.xxx:8899 \
	--enable-rpc-transaction-history \
	--enable-extended-tx-metadata-storage \
	--no-wait-for-vote-to-start-leader \
	--no-os-network-limits-test \
  --wal-recovery-mode skip_any_corrupted_record \
	--rpc-pubsub-enable-block-subscription \
	--rpc-pubsub-enable-vote-subscription \
	--account-index program-id \
	--account-index spl-token-owner \
	--account-index spl-token-mint \
	--rpc-threads 128 \
	--accounts-db-cache-limit-mb 102400 \
	--accounts-index-memory-limit-mb 40960 \
	--accounts-index-scan-results-limit-mb 40960 \
	--limit-ledger-size 300000000 \
  --expected-genesis-hash BsJstMXKW4DpjzHPsSCdEcAn4YtpNiLFRFa5M5L7UxFx \
	--log ./logs/validator.log &
