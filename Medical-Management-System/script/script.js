function showToast(msg, type="success"){
    const toast = document.getElementById("toast");
    toast.className = "toast text-bg-" + type + " p-2";
    document.getElementById("alertMsg").innerText = msg;
    new bootstrap.Toast(toast).show();
}