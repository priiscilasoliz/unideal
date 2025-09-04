document.addEventListener("DOMContentLoaded", () => {
  const buscador = document.getElementById("buscador");
  const sugerencias = document.getElementById("sugerencias");
  const sombra = document.getElementById("sombra");

  buscador.addEventListener("input", async () => {
    const query = buscador.value.trim();

    sombra.textContent = ""; // Reset

    if (query.length < 2) {
      sugerencias.innerHTML = "";
      sugerencias.style.display = "none";
      return;
    }

    const rutas = ['PHP/buscador.php', '../PHP/buscador.php'];
    let data = null;

    for (const ruta of rutas) {
      try {
        const response = await fetch(`${ruta}?q=${encodeURIComponent(query)}`);
        if (response.ok) {
          data = await response.json();
          break;
        }
      } catch (error) {
        console.warn(`No se pudo acceder a ${ruta}:`, error);
      }
    }

    sugerencias.innerHTML = "";

    if (!data || data.length === 0) {
      sugerencias.style.display = "none";
      sombra.textContent = "";
      return;
    }

    // Mostrar sugerencia fantasma (primera coincidencia)
    const primera = data[0];
    if (primera.toLowerCase().startsWith(query.toLowerCase())) {
      sombra.textContent = primera;
    } else {
      sombra.textContent = "";
    }

    data.forEach(universidad => {
      const div = document.createElement("div");
      div.classList.add("sugerencia-item");
      div.textContent = universidad;

      div.addEventListener("mousedown", (e) => {
        e.preventDefault();
        buscador.value = universidad;
        sombra.textContent = "";
        sugerencias.innerHTML = "";
        sugerencias.style.display = "none";
      });

      sugerencias.appendChild(div);
    });

    sugerencias.style.display = "block";
  });

  // Aceptar sugerencia fantasma con flecha derecha o Tab
  buscador.addEventListener("keydown", (e) => {
    if (e.key === "ArrowRight" || e.key === "Tab") {
      const sombraTexto = sombra.textContent;
      const inputTexto = buscador.value;

      if (sombraTexto && sombraTexto.toLowerCase().startsWith(inputTexto.toLowerCase())) {
        buscador.value = sombraTexto;
        sombra.textContent = "";
        sugerencias.innerHTML = "";
        sugerencias.style.display = "none";
        e.preventDefault(); // Evita que Tab se vaya del input
      }
    }
  });

 document.addEventListener("click", (e) => {
    const contenedor = document.querySelector(".buscador-container");
    if (!contenedor || !contenedor.contains(e.target)) {
      sugerencias.innerHTML = "";
      sugerencias.style.display = "none";
      sombra.textContent = "";
    }
  });
});
