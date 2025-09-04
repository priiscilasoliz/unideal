const container = document.getElementById('container');
const signUpBtn = document.getElementById('signUp');
const signInBtn = document.getElementById('signIn');

function isMobile() {
  return window.innerWidth <= 768;
}

signUpBtn.addEventListener('click', () => {
  if (isMobile()) {
    container.classList.add('right-panel-active');
  } else {
    container.classList.add('right-panel-active');
  }
});

signInBtn.addEventListener('click', () => {
  if (isMobile()) {
    container.classList.remove('right-panel-active');
  } else {
    container.classList.remove('right-panel-active');
  }
});

// Opcional: resetear clase mobile cuando cambia el tamaño de ventana
window.addEventListener('resize', () => {
  if (!isMobile()) {
    container.classList.remove('sign-up-active');
  }
});
