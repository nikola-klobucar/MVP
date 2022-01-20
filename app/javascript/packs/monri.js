var monri = Monri("c70ec12b1c9518bef9859edd75e0012148391ee7");
const client = gon.client_secret;
var components = monri.components({"clientSecret": client});
debugger;
var style = {
    base: {
        // Add your base input styles here. For example:
        fontSize: '16px',
        color: '#663399',
    }
};
// Create an instance of the card Component.
var card = components.create('card', {style: style});
// Add an instance of the card Component into the `card-element` <div>.
card.mount('card-element');

card.onChange(function (event) {
    var displayError = document.getElementById('card-errors');
    if (event.error) {
        displayError.textContent = event.error.message;
    } else {
        displayError.textContent = '';
    }
});

card.addChangeListener('card_number', function (event) {
    console.log("Card number data", event.data)
    console.log(event.data.bin)
    console.log("Card number brand", event.data.brand)
    console.log("Card number message",event.message)
    console.log("Card number validation", event.valid)
    console.log("Card number element", event.element)
});

card.addChangeListener('expiry_date', function (event) {
    console.log("Expiry date data", event.data)
    console.log("Expiry date month", event.data.month)
    console.log("Expiry date year", event.data.year)
    console.log("Expiry date message", event.message)
    console.log("Expiry date validation", event.valid)
    console.log("Expiry date element", event.element)
});

card.addChangeListener('cvv', function (event) {
    console.log("CVV data", event.data)
    console.log("CVV message", event.message)
    console.log("CVV validation", event.valid)
    console.log("CVV element", event.element)
});

// Confirm payment or display an error when the form is submitted.
var form = document.getElementById('payment-form');
form.addEventListener('submit', function (event) {
    event.preventDefault();
    const transactionParams = {
        address: gon.address,
        fullName: "Test Test",
        city: "Sarajevo",
        zip: "71000",
        phone: "+38761000111",
        country: gon.country,
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
            window.location.replace("/")
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