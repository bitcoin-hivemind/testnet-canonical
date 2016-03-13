#!/bin/bash

# This script will run the commands to create the canonical blockchain for the
# bitcoin-hivemind project
#
# NOTE:
# You may need to install the jq package for parsing json, install it using
# your package manager ex: apt-get update && apt-get install jq
#
# TODO: loops & arrays


ADDRESS='1AwXR5AFfR8PFCPB8cUDQpLF5CnkrsTZQC'
MAINBRANCH='0f894a25c5e0318ee148fe54600ebbf50782f0a1df1eb2aab06321a8ccec270d'

echo "Populating the testnet blockchain with canonical info"
#########################################
# Create branches
#########################################
# hivemind-cli createbranch
#        "createbranch name description baselistingfee"
#        " freedecisions targetdecisions maxdecisions"
#        " mintradingfee"
#        " tau ballottime unsealtime"
#        " consensusthreshold"
#        "\nCreates a new branch."
#        "\n1. name                (string) the name of the branch"
#        "\n2. description         (string) a short description of the branch"
#        "\n3. baselistingfee      (numeric)"
#        "\n4. freedecisions       (numeric < 65536)"
#        "\n5. targetdecisions     (numeric < 65536)"
#        "\n6. maxdecisions        (numeric < 65536)"
#        "\n7. mintradingfee       (numeric)"
#        "\n8. tau                 (block number < 65536)"
#        "\n9. ballottime          (block number < 65536)"
#        "\n10. unsealtime         (block number < 65536)"
#        "\n11. consensusthreshold (numeric)"
#        "\n12. alpha (numeric)"
#        "\n13. tol (numeric)";
echo "Creating branches"

#########################################
# Create decisions
#########################################
# hivemind-cli createdecision
#        "createdecision branchid prompt address eventoverby [scaled min max]"
#        "\nCreates a new decision within the branch."
#        "\n1. address             (base58 address)"
#        "\n2. branchid            (uint256 string)"
#        "\n3. prompt              (string)"
#        "\n4. eventoverby         (block number)"
#        "\n5. answer optionality  (false=need answer, true=optional answer)"
#        "\n6. is_scaled           (boolean)"
#        "\n7. scaled min          (if scaled, numeric)"
#        "\n8. scaled max          (if scaled, numeric)";
echo "Creating decisions"
DECISIONA=`./src/hivemind-cli createdecision $ADDRESS $MAINBRANCH 'Will Barack Obama win US President in 2012?' 333 false false`
DECISIONA=`echo $DECISIONA | jq '.decisionid'`
echo "Decision A: $DECISIONA"

DECISIONB=`./src/hivemind-cli createdecision $ADDRESS $MAINBRANCH 'Will US FED abandon ZIRP, at any time in 2012?' 333 false false`
DECISIONB=`echo $DECISIONB | jq '.decisionid'`
echo "Decision B: $DECISIONB"

DECISIONC=`./src/hivemind-cli createdecision $ADDRESS $MAINBRANCH 'Will Jeff Immelt have been replaced, as CEO of GE, by Jan 1, 2013?' 333 false false`
DECISIONC=`echo $DECISIONC | jq '.decisionid'`
echo "Decision C: $DECISIONC"

DECISIOND=`./src/hivemind-cli createdecision $ADDRESS $MAINBRANCH 'US U-3 Unemployment Rate, in Dec 2012, latest revision, in % [3.0, 15.0] ?' 333 false true 3 15`
DECISIOND=`echo $DECISIOND | jq '.decisionid'`
echo "Decision D: $DECISIOND"

DECISIONE=`./src/hivemind-cli createdecision $ADDRESS $MAINBRANCH 'Global surface temperature anomaly, cumulative, reported by NASA, for year 2012 (J-D), in Celsius [ 0.3, 0.9 ] ?' 333 false true 0.3 0.9`
DECISIONE=`echo $DECISIONE | jq '.decisionid'`
echo "Decision E: $DECISIONE"

DECISIONF=`./src/hivemind-cli createdecision $ADDRESS $MAINBRANCH 'Stock price of GE, Jan 1, 2013, closing, in USD [1, 100]?' 333 false true 1 100`
DECISIONF=`echo $DECISIONF | jq '.decisionid'`
echo "Decision F: $DECISIONF"

DECISIONG=`./src/hivemind-cli createdecision $ADDRESS $MAINBRANCH 'Bitcoin exchange rate as reported by CoinDesk BPI, Jan 8th, 2012, in USD [0.50, 50.00] ?' 333 false true 0.50, 50.00`
DECISIONG=`echo $DECISIONG | jq '.decisionid'`
echo "Decision G: $DECISIONG"

#########################################
# Create markets
#########################################
# hivemind-cli createmarket
#        "createmarket address decisionid[,...] B tradingfee address title"
#        " description tags[,...] maturation"
#        "\nCreates a new market on the decisions."
#        "\n1. address             (base58 address)"
#        "\n2. decisionid[,...]    (comma-separated list of decisions)"
#        "\n3. B                   (numeric) liquidity parameter"
#        "\n4. tradingfee          (numeric)"
#        "\n5. max commission      (numeric)"
#        "\n6. title               (string)"
#        "\n7. description         (string)"
#        "\n8. tags[,...]          (comma-separated list of strings)"
#        "\n9. maturation          (block number)"
#        "\n10. tx PoW hash id     (numeric)"
#        "\n11. tx PoW difficulty  (numeric)"
#        "\nEach decisionid is hash of a decision followed by a function code."
#        "\nThe available function codes are"
#        "\n    :X1   X, identity [default]"
#        "\n    :X2   X^2"
#        "\n    :X3   X^3"
#        "\n    :LNX  LN(X)";
echo "Creating markets"
MARKET1=`./src/hivemind-cli createmarket $ADDRESS $DECISIONA:X1 0.1 0.1 0.1 "Presidential Election" "Marketed based on Presidential Election" "tags" 400 0 1`
MARKET1=`echo $MARKET1 | jq '.marketid'`
echo "Market 1: $MARKET1"
MARKET2=`./src/hivemind-cli createmarket $ADDRESS $DECISIONE:X1 0.1 0.1 0.1 "Global warming health indicator" "Market to serve as a meter of global warming health" "tags" 400 0 1`
MARKET2=`echo $MARKET2 | jq '.marketid'`
echo "Market 2: $MARKET2"
MARKET3=`./src/hivemind-cli createmarket $ADDRESS $DECISIONA:X1,$DECISIONG:X1 0.1 0.1 0.1 "InTrade simulator, USD election betting" "USD election betting" "tags" 400 0 1`
MARKET3=`echo $MARKET3 | jq '.marketid'`
echo "Market 3: $MARKET3"
MARKET4=`./src/hivemind-cli createmarket $ADDRESS $DECISIONA:X1,$DECISIONB:X1,$DECISIOND:X1 0.1 0.1 0.1 "Unemployment drivers" "Market on unemployment" "tags" 400 0 1`
MARKET4=`echo $MARKET4 | jq '.marketid'`
echo "Market 4: $MARKET4"
MARKET5=`./src/hivemind-cli createmarket $ADDRESS $DECISIOND:X1,$DECISIOND:X2 0.1 0.1 0.1 "Unemployment standard deviation" "Market on unemployment standard deviation" "tags" 400 0 1`
MARKET5=`echo $MARKET5 | jq '.marketid'`
echo "Market 5: $MARKET5"
MARKET6=`./src/hivemind-cli createmarket $ADDRESS $DECISIONC:X1,$DECISIONF:LNX 0.1 0.1 0.1 "Fire Immelt?" "Market on the employment of GE CEO Immelt" "tags" 400 0 1`
MARKET6=`echo $MARKET6 | jq '.marketid'`
echo "Market 6: $MARKET6"

#########################################
# Create trades
#########################################
# hivemind-cli createtrade
#        "createtrade address marketid buy_or_sell number_shares"
#        " price decision_state [nonce]"
#        "\nCreates a new trade order in the market."
#        "\n1. address             (base58 address)"
#        "\n2. marketid            (u256 string)"
#        "\n3. buy_or_sell         (string)"
#        "\n4. number_shares       (numeric)"
#        "\n5. price               (numeric)"
#        "\n6. decision_state      (string)"
#        "\n7. nonce               (optional numeric)"
#        "\n"
#        "\nNote: for repeated trades, increase the nonce.";
echo "Creating trades"
./src/hivemind-cli createtrade $ADDRESS 926827a6d80340d5c810239eeecc624c68c68ef495a2278017302b4a5c8322e5 buy 1 0 0
./src/hivemind-cli createtrade $ADDRESS 926827a6d80340d5c810239eeecc624c68c68ef495a2278017302b4a5c8322e5 sell 1 0 0
./src/hivemind-cli createtrade $ADDRESS 926827a6d80340d5c810239eeecc624c68c68ef495a2278017302b4a5c8322e5 buy 1 0 0
./src/hivemind-cli createtrade $ADDRESS 926827a6d80340d5c810239eeecc624c68c68ef495a2278017302b4a5c8322e5 sell 1 0 0
./src/hivemind-cli createtrade $ADDRESS 926827a6d80340d5c810239eeecc624c68c68ef495a2278017302b4a5c8322e5 buy 1 0 0
./src/hivemind-cli createtrade $ADDRESS 926827a6d80340d5c810239eeecc624c68c68ef495a2278017302b4a5c8322e5 sell 1 0 0
./src/hivemind-cli createtrade $ADDRESS 926827a6d80340d5c810239eeecc624c68c68ef495a2278017302b4a5c8322e5 buy 1 0 0
./src/hivemind-cli createtrade $ADDRESS 926827a6d80340d5c810239eeecc624c68c68ef495a2278017302b4a5c8322e5 sell 1 0 0
./src/hivemind-cli createtrade $ADDRESS 926827a6d80340d5c810239eeecc624c68c68ef495a2278017302b4a5c8322e5 buy 1 0 0
./src/hivemind-cli createtrade $ADDRESS 926827a6d80340d5c810239eeecc624c68c68ef495a2278017302b4a5c8322e5 sell 1 0 0
./src/hivemind-cli createtrade $ADDRESS 926827a6d80340d5c810239eeecc624c68c68ef495a2278017302b4a5c8322e5 buy 1 0 0
./src/hivemind-cli createtrade $ADDRESS 926827a6d80340d5c810239eeecc624c68c68ef495a2278017302b4a5c8322e5 sell 1 0 0
