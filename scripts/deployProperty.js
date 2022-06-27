const hre = require("hardhat");

async function main() {
  const Property = await hre.ethers.getContractFactory("Property");
  const property = await Property.deploy("Property Trading", "Property","1000000000000000000");

  await property.deployed();

  console.log("Property deployed to:", property.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
