# Intro

Relates to the Blockstack Clarity Hackathon https://gitcoin.co/issue/blockstack/hackathons/4/4407

# Setup Local Dev Environment & IDE

Add VS Code plugins for Clarity language:
* blockstack.clarity
* lgalabru.clarity-lsp
* 2gua.rainbow-brackets

Setup Node.js and generate Clarity Hello World example
```
nvm use v13.12.0 
npm init clarity-starter
```

Run tests
```
npm test
```

# Create Testnet Address & Obtain STX

## CLI

### CLI Setup

Setup Blockstack CLI for Stacks 2.0
```
sudo npm install -g "https://github.com/blockstack/cli-blockstack#feature/stacks-2.0-tx"
blockstack-cli help all
```

### Obtain Testnet STX via CLI

Follow these steps: https://docs.blockstack.org/core/smart/tutorial.html#get-familiar-with-cli-optional

Create a new STX address and save keychain details. View the Testnet STX address. The `-t` flag targets the Testnet.
```
blockstack make_keychain -t > new_keychain.txt
cat new_keychain.txt
```

Log the Testnet STX address from the text file.

**IMPORTANT: REQUESTING BLOCKSTACK TESTNET STX VIA CLI FAUCET CURRENTLY DOES NOT WORK. In the interim request it from the UI instead here https://testnet.blockstack.org/faucet**

```
stx="$(awk -v FS="address\":\"" 'NF>1{print $2}' new_keychain.txt | sed 's/\".*//')"
curl -XPOST "https://sidecar.staging.blockstack.xyz/sidecar/v1/debug/faucet?address=$stx" | json_pp
```

We created an issue here to have it resolved: https://github.com/blockstack/docs.blockstack/issues/622

### Check Balance via CLI

```
stx="$(awk -v FS="address\":\"" 'NF>1{print $2}' new_keychain.txt | sed 's/\".*//')"
blockstack balance $stx -t
```

## UI

## Obtain Testnet STX or BTC via Faucet

Follow these steps: https://docs.blockstack.org/core/smart/cli-wallet-quickstart.html#getting-tokens

Go to https://testnet.blockstack.org/faucet
Enter Testnet STX address

### Obtain Testnet STX via UI (Blockstack Explorer Sandbox)

Go to the Blockstack Explorer Sandbox (similar to Ethereum Remix): https://testnet-explorer.blockstack.org/sandbox?tab=faucet

Request Testnet STX

# Deploy Contract to Stacks 2.0 Blockchain

## UI

Follow these steps: https://docs.blockstack.org/core/smart/tutorial.html#deploy-the-contract

Copy/paste the contents of ./contracts/hello-world.clar
Click "Deploy Contract"
Copy the deployed "Contract Name" by clicking the "Copy" icon
Go to https://testnet-explorer.blockstack.org/sandbox?tab=contract-call
Paste into the "Contract address" and it will paste the value into both fields
Click "Search"

## CLI

```
stxPrivateKey="$(awk -v FS="privateKey\":\"" 'NF>1{print $2}' new_keychain.txt | sed 's/\".*//')"
blockstack deploy_contract ./contracts/hello-world.clar hello-world 2000 0 $stxPrivateKey -t
```

# Call Contract Method

```
stxAddress="$(awk -v FS="address\":\"" 'NF>1{print $2}' new_keychain.txt | sed 's/\".*//')"
stxPrivateKey="$(awk -v FS="privateKey\":\"" 'NF>1{print $2}' new_keychain.txt | sed 's/\".*//')"
blockstack call_contract_func $stxAddress hello-world echo-number 2000 1 $stxPrivateKey -t
```

# Customise Smart Contract

Follow these steps: https://docs.blockstack.org/core/smart/tutorial-counter.html

# References

* https://docs.blockstack.org/core/smart/tutorial.html
* https://unix.stackexchange.com/questions/1096/grep-removing-text-after-delimiter-token
* https://stackoverflow.com/questions/30776265/how-to-grep-for-value-in-a-key-value-store-from-plain-text
* Chain Status - http://status.test-blockstack.com/
* Blockstack Explorer Sandbox & Testnet Faucet - https://docs.blockstack.org/core/smart/tutorial.html#access-the-explorer-sandbox
* Clarity language reference - https://docs.blockstack.org/core/smart/clarityref