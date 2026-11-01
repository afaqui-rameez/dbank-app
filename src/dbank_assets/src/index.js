
import { dbank } from "../../declarations/dbank";

window.addEventListener("load", async function() {
    await update();
});

document.querySelector("form").addEventListener("submit", async function(event) {
    event.preventDefault();

    const button = event.target.querySelector("#submit-btn");

    const inputAmount = document.getElementById("input-amount").value;
    const outputAmount = document.getElementById("withdrawal-amount").value;

    button.setAttribute("disabled", true);

    try {
        if (inputAmount.length != 0) {
            await dbank.topUp(Number(inputAmount));
        }

        if (outputAmount.length != 0) {
            await dbank.withdrawl(Number(outputAmount));
        }

        await dbank.compound();
        await update();

        document.getElementById("input-amount").value = "";
        document.getElementById("withdrawal-amount").value = "";

    } catch (error) {
        console.error("Transaction failed:", error);
    } finally {
        button.removeAttribute("disabled");
    }
});

async function update() {
    const currentAmount = await dbank.checkBalance();

    document.getElementById("value").innerText =
        Math.round(Number(currentAmount) * 100) / 100;
}
