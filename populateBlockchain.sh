#!/bin/bash

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
