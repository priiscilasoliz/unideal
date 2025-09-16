const containers = document.getElementById('containers');
const signUpBtn = document.getElementById('signUp');
const signInBtn = document.getElementById('signIn');

function isMobile() {
  return window.innerWidth <= 768;
}

signUpBtn.addEventListener('click', () => {
  if (isMobile()) {
    containes.classList.add('right-panel-active');
  } else {
    containers.classList.add('right-panel-active');
  }
});

signInBtn.addEventListener('click', () => {
  if (isMobile()) {
    containers.classList.remove('right-panel-active');
  } else {
    containers.classList.remove('right-panel-active');
  }
});

// Opcional: resetear clase mobile cuando cambia el tamaño de ventana
window.addEventListener('resize', () => {
  if (!isMobile()) {
    containers.classList.remove('sign-up-active');
  }
});
