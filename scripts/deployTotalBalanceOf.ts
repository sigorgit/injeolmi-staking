import hardhat from "hardhat";

async function main() {
    console.log("deploy start")

    const TotalBalanceOf = await hardhat.ethers.getContractFactory("TotalBalanceOf")
    const contact = await TotalBalanceOf.deploy("0x0268dbed3832b87582B1FA508aCF5958cbb1cd74", "0x485Ec445AD112aCc33909bc7918f9FE282a1c330")
    console.log(`TotalBalanceOf address: ${contact.address}`)
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });