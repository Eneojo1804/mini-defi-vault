import NavBar from "@/contract/component/NavBar";
import VaultBalance from "@/contract/component/VaultBalance";
import UserBalance from "@/contract/component/UserBalance";
import Withdraw from "@/contract/component/Withdraw";
import Deposit from "@/contract/component/Deposit";
import TransactionHistory from "@/contract/component/TransactionHistory";

export default function Home() {
  return (
    <>
    <NavBar />
    <main className="mx-auto max-w-7xl spacce-y-10 p-8">
      <section>
        <h1 className="text-4xl font-bold">
          Welcome to Mini Defi Vault
        </h1>
        <p className="mt-2 text-gray-600">
          Deposit ETH securely into a decentralized vault and withdraw it 
          anytime you need it.
        </p>
      </section>
      <section className="grid gap-6 md:grid-cols-2">
        <VaultBalance />
        <UserBalance />
      </section>
      <section id="Deposit" className="grid gap-6 md:grid-cols-2">
        <Deposit />
        <div id="withdraw">
          <Withdraw /> 
        </div>
      </section>
      <section id="history">
        <TransactionHistory />
      </section>
    </main>
    </>
  );
}