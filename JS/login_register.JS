const containers = document.getElementById('containers');
const signUpBtn = document.getElementById('signUp');
const signInBtn = document.getElementById('signIn');

signUpBtn.addEventListener('click', () => {
  containers.classList.add('right-panel-active');
});

signInBtn.addEventListener('click', () => {
  containers.classList.remove('right-panel-active');
});
