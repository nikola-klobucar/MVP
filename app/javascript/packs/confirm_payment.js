// Confirm payment or display an error when the form is submitted.
var form = document.getElementById('payment-form');
form.addEventListener('submit', function (event) {
    event.preventDefault();
    const transactionParams = {
        address: "Adresa",
        fullName: "Test Test",
        city: "Sarajevo",
        zip: "71000",
        phone: "+38761000111",
        country: "BA",
        email: "tester+components_sdk@monri.com",
        orderInfo: "Testna trx"
    }

    monri.confirmPayment(card, transactionParams).then(function (result) {
        if (result.error) {
            // Inform the customer that there was an error.
            var errorElement = document.getElementById('card-errors');
            errorElement.textContent = result.error.message;
        } else {
            handlePaymentResult(result.result)
        }
    });
});

function handlePaymentResult(paymentResult) {
    // Handle PaymentResult
    if (paymentResult.status == 'approved') {
        alert("Transaction approved")
    } else {
        alert("Transaction declined")
    }
}