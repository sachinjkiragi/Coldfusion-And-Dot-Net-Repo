const firstNameField = document.getElementById('firstName');
const lastNameField = document.getElementById('lastName');
const emailField = document.getElementById('email');
const phoneField = document.getElementById('phone');
const departmentField = document.getElementById('departmentList');
const qualificationField = document.getElementById('qualification');
const firstNameError = document.getElementById('firstNameError');
const lastNameError = document.getElementById('lastNameError');
const emailError = document.getElementById('emailError');
const phoneError = document.getElementById('phoneError');
const departmentError = document.getElementById('departmentError');
const qualificationError = document.getElementById('qualificationError');
const formEle = document.querySelector('.needs-validation');

console.log(qualificationError);
console.log(qualificationField);


formEle.addEventListener('submit', (e) => {
    let valid = true;

    if (!isFirstNameValid(firstNameField.value)) {
        firstNameError.classList.remove('invisible');
        firstNameError.textContent = 'Please enter a valid first name';
        valid = false;
    } else {
        firstNameError.classList.add('invisible');
    }

    if (!isLastNameValid(lastNameField.value)) {
        lastNameError.classList.remove('invisible');
        lastNameError.textContent = 'Please enter a valid last name';
        valid = false;
    } else {
        lastNameError.classList.add('invisible');
    }
    if (!isQualificationValid(qualificationField.value)) {
        qualificationError.classList.remove('invisible');
        qualificationError.textContent = 'Please enter a valid qualification';
        valid = false;
    } else {
        qualificationError.classList.add('invisible');
    }

    if (!isEmailValid(emailField.value)) {
        emailError.classList.remove('invisible');
        emailError.textContent = 'Please enter a valid email';
        valid = false;
    } else {
        emailError.classList.add('invisible');
    }

    if (!isPhoneValid(phoneField.value)) {
        phoneError.classList.remove('invisible');
        phoneError.textContent = 'Please enter valid 10 digit phone number';
        valid = false;
    } else {
        phoneError.classList.add('invisible');
    }

    if(departmentField.value == ""){
        departmentError.classList.remove('invisible');
        departmentError.textContent = 'Please select a department';
        valid = false;
    } else{
        departmentError.classList.add('invisible');
    }

    if (!formEle.checkValidity()) valid = false;

    if (!valid) {
        e.preventDefault();
        e.stopPropagation();
    }
});

function isFirstNameValid(firstName){
    return /^[a-zA-Z.]+$/.test(firstName);
}

function isQualificationValid(qualification){
    return /^[a-zA-Z,]+$/.test(qualification);
}

function isLastNameValid(lastName){
    return /^[a-zA-Z]+$/.test(lastName);
}

function isEmailValid(email){
    return /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email);
}

function isPhoneValid(phone){
    return /^[0-9]{10}$/.test(phone);
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


qualificationField.addEventListener('input', (e)=>{
    console.log(qualificationField.value);
    
    if (qualificationField.value.length > 0 && !isQualificationValid(qualificationField.value)) {
        qualificationError.classList.remove('invisible');
        qualificationError.textContent = 'Only letters and (,) are allowed';
    } else{
        qualificationError.classList.add('invisible');
    }
})