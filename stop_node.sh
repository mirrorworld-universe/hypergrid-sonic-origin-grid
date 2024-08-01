kill -15 `ps -aux|grep solana-validator | grep -v grep | awk '{print $2}'`
