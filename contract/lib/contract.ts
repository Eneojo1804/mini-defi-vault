"use client";
import { ethers } from "ethers";
import { getProvider, getSigner } from "./web3";
import vaultArtifacts from  "@/contract/out/vault.sol/vault.json";

const contractAddress = process.env.NEXT_PUBLIC_VAULT_ADDRESS || "0x6a15f0e91b97e9f3e7b6627e5d86e2bea7c4842f";
const SEPOLIA_CHAIN_ID = 11155111;
const  provider = new ethers.JsonRpcProvider(process.env.NEXT_PUBLIC_SEPOLIA_RPC_URL || "https://infura.io");

// Read-only contract
export function getVaultReadContract(){
    return new ethers.Contract(
        contractAddress,
        vaultArtifacts.abi,
        provider
    );

}

// Write contract
export async function getVaultWriteContract() {
    const signer = await getSigner();
    const network = await signer.provider!.getNetwork();
    if (Number(network.chainId) !== SEPOLIA_CHAIN_ID) {
        throw new Error ("please switch Metamask to Sepolia.");
    }
    return new ethers.Contract(
        contractAddress,
        vaultArtifacts.abi,
        signer,
    );
}