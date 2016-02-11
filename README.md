# testnet-canonical

## This repository is the starting point for anyone wanting to work on or test the bitcoin-hivemind project.
+ Instructions for developers and testers
+ Modified testnet seeder (syncs only to the last canonical block height)
+ Script to generate canonical blockchain data using the hivemind-cli
+ Backups of the canonical blockchain(s)

### To start devloping / testing (environment setup and building)
1. You may use the following guide to setup a remote node, or follow the instructions on a virtual machine / your local system [Fullnode setup guide](https://github.com/bitcoin-hivemind/hivemind/blob/master/doc/fullnode-setup.txt)

2. Edit your configuration file (~/.hivemind/hivemind.conf) and append the following line
  ```
  testnet=1
  ```

3. Start the client of your choice (hivemindd & hivemind-cli or hivemind-qt) You should connect automatically to the testnet seeder node(s), if not run the following command through the debug window or hivemind-cli
  ```
  addnode 162.243.37.30 onetry
  ```
