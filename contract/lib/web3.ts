"use cllient";

import { ethers } from "ethers";

export async function getProvider() {
    if (typeof window === "undefined" || !window.ethereum) {
        alert("Please install MetaMask!");
        throw new Error("MetaMask not found");
    }
    return new ethers.BrowserProvider(window.ethereum);
}

export async function getSigner() {
    const provider = await getProvider();
    return await provider.getSigner();
}

export async function connectWallet() {
    const provider = await getProvider();
    const signer = await provider.getSigner();
    const address = await signer.getAddress();

    alert("Connected: " + address);
    return { provider, signer, address };
}
