var firstNameField = document.getElementById('firstName');
var lastNameField = document.getElementById('lastName');
var emailField = document.getElementById('email');
var phoneField = document.getElementById('phone');
var firstNameError = document.getElementById('firstNameError');
var lastNameError = document.getElementById('lastNameError');
var emailError = document.getElementById('emailError');
var phoneError = document.getElementById('phoneError');

function isFirstNameValid(firstName){
    return /^[a-zA-Z.]+$/.test(firstName);
}

function isLastNameValid(lastName){
    return /^[a-zA-Z]+$/.test(lastName);
}

function isEmailValid(email){
    return /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email);
}

function isPhoneValid(phone){
    return /^[0-9]{10}$/.test(phoneField.value);
}

firstNameField.addEventListener('input', (e)=>{
    console.log(firstNameField.value);
    console.log(firstNameField.value.length);
    if (firstNameField.value.length > 0 && !isFirstNameValid(firstNameField.value)) {
        firstNameError.classList.remove('invisible');
        firstNameError.textContent = 'Only letters are allowed';
    } else{
        firstNameError.classList.add('invisible');
    }
})

lastNameField.addEventListener('input', (e)=>{
    if (lastNameField.value.length > 0 && !isLastNameValid(lastNameField.value)) {
        lastNameError.classList.remove('invisible');
        lastNameError.textContent = 'Only letters are allowed';
    } else{
        lastNameError.classList.add('invisible');
    }
})

emailField.addEventListener('input', (e)=>{
    if(emailField.value.length > 0 && !isEmailValid(emailField.value)) {
       emailError.classList.remove('invisible');
        emailError.textContent = "Enter valid email";
    } else {
        emailError.classList.add('invisible');
    }
})

phoneField.addEventListener('input', () => {
    if (phoneField.value.length > 0 && !isPhoneValid(phoneField.value)) {
        phoneError.classList.remove('invisible');
        phoneError.textContent = "Enter valid 10 digit phone number";
    } else {
        phoneError.classList.add('invisible');
    }
});
