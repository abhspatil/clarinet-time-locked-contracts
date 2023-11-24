# clarinet-time-locked-contracts

$ clarinet check

$ clarinet console

> (contract-call? 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.time-lock-tokens lock-c 'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5 u10 u1000000 )

> ::get_assets_maps


> ::set_tx_sender ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5

> ::get_assets_maps

> (contract-call? 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.time-lock-tokens claim)

> ::advance_chain_tip 10

> (contract-call? 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.time-lock-tokens claim)