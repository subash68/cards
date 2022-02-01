import { ethers } from "hardhat";

describe("Organization", function () {
  it("Should return all name cards for organization", async function () {
    const O = await ethers.getContractFactory("Organization");
    const org = await O.attach("0x38Edc062B088263B2B3B9E7cA289d05d927b665D");

    const cards = await org.fetchAllResources();
    console.log(cards);
  });
});
