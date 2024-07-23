<p align="center">
  <a href="https://worldstore.mirrorworld.fun/" target="_blank"><img alt="Sonic - The First SVM Gaming Chain powered by HyperGrid" title="Sonic - The First SVM Gaming Chain powered by HyperGrid" src="https://pbs.twimg.com/media/GMZ287_XgAARYEU?format=jpg&name=medium" width="100%">
  </a>
</p>

[![Live on Mainnet](https://img.shields.io/badge/Sonic%20Explorer-Live%20on%20HyperGrid-blue)](https://explorer.sonic.game)
[![Live on Mainnet](https://img.shields.io/badge/Sonic%20Faucet-Live%20on%20HyperGrid-blue)](https://faucet.sonic.game)
[![Follow Us!](https://img.shields.io/twitter/follow/zksync?color=%238C8DFC&label=Follow%20%40SonicSVM&logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPHN2ZyB3aWR0aD0iNDMiIGhlaWdodD0iMjUiIHZpZXdCb3g9IjAgMCA0MyAyNSIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGQ9Ik00Mi42NTM5IDEyLjQ5MTVMMzAuODM3OCAwLjcxNjc0M1Y5LjM0TDE5LjEwNTUgMTcuOTczOUwzMC44Mzc4IDE3Ljk4MlYyNC4yNjYyTDQyLjY1MzkgMTIuNDkxNVoiIGZpbGw9IiM0RTUyOUEiLz4KPHBhdGggZmlsbC1ydWxlPSJldmVub2RkIiBjbGlwLXJ1bGU9ImV2ZW5vZGQiIGQ9Ik0wLjk5ODA0NyAxMi40ODcyTDEyLjgxNDEgMjQuMjYxOVYxNS43MDhMMjQuNTQ2NSA3LjAwNDdMMTIuODE0MSA2Ljk5NjY0VjAuNzEyNDYzTDAuOTk4MDQ3IDEyLjQ4NzJaIiBmaWxsPSIjOEM4REZDIi8%2BCjwvc3ZnPgo%3D&style=flat)](https://twitter.com/SonicSVM)  




# Sonic Devnet HyperGrid Node Setup Guide


### HyperGrid Operating System Requirements
Ubuntu Server 22.04.4 LTS


### HyperGrid Hardware Requirements
Low-End Configuration:  
CPU: 64-core  
RAM: 256GB  
SSD: 10TB  

Mid-Range Configuration:
CPU: 128-core  
RAM: 512GB  
SSD: 15TB  

### Server Port Policy
Open ports 80 and 443 to support RPC external services.  
Open TCP and UDP protocol ports in the range of 8000 to 9000, and whitelist the IP addresses 52.10.174.63 and 35.164.22.3.  
After completing the above configurations, please send your server's public IP address to operators@sonic.game.

### System Tuning
Your system will need to be tuned in order to run properly. Your validator may not start without the settings below.  
Optimize sysctl knobs​  
```
sudo bash -c "cat >/etc/sysctl.d/21-solana-validator.conf <<EOF
#### Increase UDP buffer sizes
net.core.rmem_default = 134217728
net.core.rmem_max = 134217728
net.core.wmem_default = 134217728
net.core.wmem_max = 134217728

#### Increase memory mapped files limit
vm.max_map_count = 1000000

#### Increase number of allowed open file descriptors
fs.nr_open = 1000000
EOF"
sudo sysctl -p /etc/sysctl.d/21-solana-validator.conf
```
Increase systemd and session file limits​
Add

LimitNOFILE=1000000

to the [Service] section of your systemd service file, if you use one, otherwise add

DefaultLimitNOFILE=1000000



to the [Manager] section of /etc/systemd/system.conf.

sudo systemctl daemon-reload


sudo bash -c "cat >/etc/security/limits.d/90-solana-nofiles.conf <<EOF
#### Increase process file descriptor count limit
* - nofile 1000000
EOF"


### Close all open sessions (log out then, in again) ###


Install Sonic Devnet Validator
1. Install Sonic devnet program
You can install a pre-built binary package, or build it from source codes.

1.1 Download and Extract the Installation Package

$ wget https://grid-sonic.hypergrid.dev/downloads/hypergrid-rpcnode.tar.gz
$ tar -zxvf hypergrid-rpcnode.tar.gz


1.2 Building program from source codes
1). Install rustc, cargo and rustfmt.

$ curl https://sh.rustup.rs -sSf | sh
$ source $HOME/.cargo/env
$ rustup component add rustfmt

On Ubuntu you may need to install libssl-dev, pkg-config, zlib1g-dev, protobuf etc.

$ sudo apt-get update
$ sudo apt-get install libssl-dev libudev-dev pkg-config zlib1g-dev llvm clang cmake make libprotobuf-dev protobuf-compiler

2). Download the source code.

$ git clone https://github.com/mirrorworld-universe/hypergrid-sonic-origin-grid
$ cd hypergrid-sonic-origin-grid


3). Build.

$ mkdir ~/grid_node
$ ./scripts/cargo-install-all.sh ~/grid_node
$ cp ./run_rpcnode.sh ~/grid_node/


2. Initialization

$ cd ~/grid_node
$ mkdir config
$ mkdir logs
$ ./bin/solana-keygen new --no-passphrase
$ ./bin/solana config set --url http://127.0.0.1:8899
$ ./bin/solana-keygen new -o ./config/validator-keypair.json



3. Modify Configuration
Edit the run_rpcnode.sh file to replace the IP address (172.31.61.43) with your machine's public IP address.
./bin/solana-validator \
    --identity ./config/validator-keypair.json \
    --known-validator CQqu5MsTpH1mTwEsZ75QzPtXGTz9ziEvKwpcAstKG9WJ \
    --ledger ./ledger \
    --rpc-port 8899 \
    --full-rpc-api \
    --no-voting \
    --rpc-bind-address 0.0.0.0 \
    --only-known-rpc \
    --gossip-host 172.31.61.43 \
    --gossip-port 8001 \
    --entrypoi:8001 \
    --public-rpc-address 172.31.61.43:8899 \
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
    --expected-genesis-hash BsJstMXKW4DpjzHPsSCdEcAn4YtpNiLFRFa5M5L7UxFx \
    --wal-recovery-mode skip_any_corrupted_record \
    --log ./logs/validator.log &




4. Run

$ ./run_rpcnode.sh


