document.addEventListener("DOMContentLoaded", () => {
  const iconoBusqueda = document.getElementById("icono-busqueda");
  const contenedorBuscador = document.getElementById("buscador-container");

  iconoBusqueda.addEventListener("click", () => {
    contenedorBuscador.classList.toggle("oculto");
  });

  document.addEventListener("click", (e) => {
    if (
      !iconoBusqueda.contains(e.target) &&
      !contenedorBuscador.contains(e.target)
    ) {
      contenedorBuscador.classList.add("oculto");
    }
  });
});
