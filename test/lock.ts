import { Client, Provider, ProviderRegistry, Result } from "@blockstack/clarity";
import { assert } from "chai";

describe("lock contract test suite", () => {
  let lockClient: Client;
  let provider: Provider;

  before(async () => {
    provider = await ProviderRegistry.createProvider();
    lockClient = new Client("SP3GWX3NE58KXHESRYE4DYQ1S31PQJTCRXB3PE9SB.lock", "lock", provider);
  });

  it("should have a valid syntax", async () => {
    await lockClient.checkContract();
  });

  describe("deploying an instance of the contract", () => {
    before(async () => {
      await lockClient.deployContract();
    });
  });

  after(async () => {
    await provider.close();
  });
});
