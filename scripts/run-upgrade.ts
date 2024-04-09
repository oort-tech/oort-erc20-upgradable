async function upgrade() {
    const UpgradeUUPS = await ethers.getContractFactory("NewOORT");
    // eslint-disable-next-line no-unused-vars
   const upgradedUUPS = await upgrades.upgradeProxy(
     "", // Set Token address here
     UpgradeUUPS
   );

   console.log("OORT UUPS upgraded & now the token has new functionaly");
   
   console.log(upgradedUUPS.address);
}

upgrade().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
