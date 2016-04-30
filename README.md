# testnet-canonical

## This repository is the starting point for anyone wanting to connect to the testnet and start testing / working on the bitcoin-hivemind project.

### Starting development / testing (environment setup and building):
1. You may use the following guide to setup a remote node, or follow the instructions on a virtual machine / your local system: [Fullnode setup guide](https://github.com/bitcoin-hivemind/hivemind/blob/master/doc/fullnode-setup.txt)

2. Edit your configuration file;
Linux: ```~/.hivemind/hivemind.conf```
Windows: ```%APPDATA%\hivemind\  Ex: C:\Users\username\AppData\Roaming\Hivemind\hivemind.conf```
and append the following line:
  ```
  testnet=1
  ```

3. Start the client of your choice (hivemindd & hivemind-cli or hivemind-qt) You should connect automatically to the testnet seeder node(s), if not run the following command through the debug window or hivemind-cli
  ```
  addnode 162.243.37.30 onetry
  ```
  
# Hivemind-Qt first start / tour
When starting Hivemind for the first time you should see the green testnet logo. Hivemind will start connecting to the testnet sync nodes and begin syncing the blockchain automatically. Once your copy of the blockchain is up to date, the overview page will show a list of recent Hivemind transactions.
![firstStart](/firstStart.png?raw=true "First Start")
  
After your node has downloaded the canonical testnet data, (you may need to restart Hivemind-Qt), your Hivemind window should look something like this:
![Synced](/synced.png?raw=true "Synced")

To start creating Decisions & Markets visit the Author tab:
![Author](/author.png?raw=true "Author")

To vote on Decisions, use the Vote tab:
![SealedVote](/SealedVote.png?raw=true "SealedVote")
![RevealVote](/RevealVote.png?raw=true "RevealVote")
![SelectDecision](/SelectDecision.png?raw=true "SelectDecision")
![SealedVoteSubmitted](/SealedVoteSubmitted.png?raw=true "SealedVoteSubmitted")
![RevealVoteSubmitted](/RevealVoteSubmitted.png?raw=true "RevealVoteSubmitted")

The GUI is still in development so the best way to see more details about the Hivemind network is to make use of the RPC console. Hivemind has the following RPC commands available in addition to the standard Bitcoin RPC commands:
```
createbranch name description baselistingfee freedecisions targetdecisions maxdecisions mintradingfee tau ballottime unsealtime consensusthreshold
createdecision branchid prompt address eventoverby [scaled min max]
createmarket address decisionid[,...] B tradingfee address title description tags[,...] maturation
createrevealvote address branchid height NA decisionid,vote [...]
createsealedvote branchid height voteid
createstealvote branchid height voteid 
createtrade address marketid buy_or_sell number_shares price decision_state [nonce]
getballot branchid [height]
getbranch branchid
getcreatetradecapitalrequired marketid number_shares decision_state
getdecision decisionid
getmarket marketid
getoutcome outcomeid
gettrade tradeid
getvote voteid
listbranches
listdecisions branchid
listmarkets decisionid
listoutcomes branchid
listtrades marketid
listvotes branchid height 
```
Listing Branches:
![List Branches](/listBranches.png?raw=true "List Branches")

Listing the Decisions on the Branch we just found:
![List Decisions](/listDecisions.png?raw=true "List Decisions")

# Resetting your environment, how to start over with the canonical blockchain data for testing:
1. Make sure that all instances of hivemind (hivemindd, hivemind-cli and hivemind-qt) are completely shutdown
  ```
  ps -aux | grep hivemind
  ```
  The above command will list any process on the system with the name hivemind, look for any running daemons or hivemind-qt instances.

2. Remove Hivemind's data directory <b>Warning: be careful with the rm command, it will permanently delete files</b> also note that this will remove all transactions, blocks, your configuration files and all of your private keys (coins) which you have created with hivemind.
  ```
  rm -rf ~/.hivemind/
  ```

3. Remove the directory to which you have built hivemind.

4. Re-download the source code and build it fresh again using the [Fullnode setup guide](https://github.com/bitcoin-hivemind/hivemind/blob/master/doc/fullnode-setup.txt)

# Running a testnet sync node (modified to sync a certain number of blocks of data)
Testnet sync nodes for bitcoin-hivemind are full nodes modified to accept a certain number of blocks, up to nHeight of canonical blockchain data. This is to provide developers a testing environment with examples of Hivemind's functions, which is always available in a clean state. Once a developer has synced with the seed node, they can create blocks and share blocks with other nodes that they connect to on the network. If for any reason however, the developer needs to reset the environment they need only erase the data they have added and restore the 'backup' by syncing with the seed node which has remained unchanged.

1. Download the source code and build it using the [Fullnode setup guide](https://github.com/bitcoin-hivemind/hivemind/blob/master/doc/fullnode-setup.txt)

2. Edit your configuration file (~/.hivemind/hivemind.conf) and append the following line
  ```
  testnet=1
  ```

3. Set the block sync limit by either:
 - Copying the main.cpp file from this repository to replace the main.cpp in your local repository.
 - Editing main.cpp in your code, adding the following to the AcceptBlock function after line 2751:
  ```
  // Don't accept any blocks higher than last block of canonical blockchain data
  if (nHeight > 279) {
      return false;
  }
  ```
4. Copy the canonical blockchain data (blocks/blocks.tar.gz) from this repository into your ~/.hivemind/testnet folder

5. Extract the contents of the blocks archive inside of the testnet directory:
  ```
  tar -xvzf blocks.tar.gz
  ```

5. Start the hivemindd daemon with the -rescan option
  ```
  ./src/hivemindd -rescan
  ```
