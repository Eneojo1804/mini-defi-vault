import {MetamaskInpageProvider} from "@metamask/provider";

declare global {
    interface Window {
        ethereum : MetamaskInpageProvider;
    }
}

export {};