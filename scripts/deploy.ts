import { ethers, upgrades } from "hardhat";
// upgrades.silenceWarnings(); // Uncomment if you want to silence the warnings

async function main() {

  /****************************************
   * Comment out if you perfom an upgrade *
   ****************************************/
  // Deploying `OORT Upgradable`
  const oortUUPS = await ethers.getContractFactory(
    "OORTUUPS"
  );
  const tokenOORTUUPS = await upgrades.deployProxy(oortUUPS, [], {
    initializer: "initialize",
    kind: "uups",
  });
  await tokenOORTUUPS.deployed();

  console.log(
    "OORTUUPS deployed to:",
    tokenOORTUUPS.address
  );

  /**********************************************
   * Uncomment if you want to perfom an upgrade *
   **********************************************/
  /* const UpgradeUUPS = await ethers.getContractFactory("NewOORT");
  // eslint-disable-next-line no-unused-vars
   const upgradedUUPS = await upgrades.upgradeProxy(
     "", // Set Token address here
     UpgradeUUPS
   );

   console.log("OORT UUPS upgraded");
   
   console.log(upgradedUUPS.address);*/
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
