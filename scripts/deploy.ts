import { ethers, upgrades } from "hardhat";
// upgrades.silenceWarnings(); // Uncomment if you want to silence the warnings

async function main() {

  /****************************************
   * Comment out if you perfom an upgrade *
   ****************************************/
  // Deploying `OORT Upgradable`
  const oortUUPS = await ethers.getContractFactory(
    "OORT"
  );
  const tokenOORTUUPS = await upgrades.deployProxy(oortUUPS, [], {
    initializer: "initialize",
    kind: "uups",
    unsafeAllow: ["selfdestruct"],
  });
  await tokenOORTUUPS.deployed();

  console.log(
    "OORT Upgradable deployed to:",
    tokenOORTUUPS.address
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
