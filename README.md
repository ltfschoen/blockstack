
# Setup

Add VS Code plugins for Clarity language:
* blockstack.clarity
* lgalabru.clarity-lsp
* 2gua.rainbow-brackets

Setup Node.js and generate Clarity Hello World example
```
nvm use v13.12.0 
npm init clarity-starter
```

Setup Blockstack CLI for Stacks 2.0
```
sudo npm install -g "https://github.com/blockstack/cli-blockstack#feature/stacks-2.0-tx"
```

Create a new STX address and save keychain details. View the Testnet STX address. The `-t` flag targets the Testnet.
```
blockstack make_keychain -t > new_keychain.txt
cat new_keychain.txt
```

Log the Testnet STX address from the text file.
Call Blockstack Testnet faucet to get Testnet STX tokens.
```
stx="$(awk -v FS="address\":\"" 'NF>1{print $2}' new_keychain.txt | sed 's/\".*//')"
curl -XPOST "https://sidecar.staging.blockstack.xyz/sidecar/v1/debug/faucet?address=$stx" | json_pp
```

# References

* https://docs.blockstack.org/core/smart/tutorial.html
* https://unix.stackexchange.com/questions/1096/grep-removing-text-after-delimiter-token
* https://stackoverflow.com/questions/30776265/how-to-grep-for-value-in-a-key-value-store-from-plain-text
