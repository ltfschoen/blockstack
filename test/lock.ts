import { Client, Provider, ProviderRegistry, Result } from "@blockstack/clarity";
import { assert } from "chai";

describe("lock contract test suite", () => {
  let lockClient: Client;
  let provider: Provider;

  before(async () => {
    provider = await ProviderRegistry.createProvider();
    lockClient = new Client("STQX02C1KXY4VFYX2ABECJYZ4XAG5KV99WAQ370Z.lock", "lock", provider);
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
