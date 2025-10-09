document.addEventListener("DOMContentLoaded", () => {
  const buscador = document.getElementById("buscador");
  const sugerencias = document.getElementById("sugerencias");
  const sombra = document.getElementById("sombra");

  buscador.addEventListener("input", async () => {
    const query = buscador.value.trim();
    sombra.textContent = "";

    if (query.length < 2) {
      sugerencias.innerHTML = "";
      sugerencias.style.display = "none";
      return;
    }

    const rutas = ["PHP/buscador.php", "../PHP/buscador.php"];
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

    const primera = data[0].nombre;
    if (primera.toLowerCase().startsWith(query.toLowerCase())) {
      sombra.textContent = primera;
    }

    data.forEach((item) => {
      const div = document.createElement("div");
      div.classList.add("sugerencia-item");

      if (item.tipo === "carrera") {
        div.textContent = `${item.nombre} (${item.acronimo})`;
      } else {
        div.textContent = `${item.nombre} (${item.acronimo})`;
      }

      div.addEventListener("mousedown", () => {
        window.location.href = item.url;
      });

      sugerencias.appendChild(div);
    });

    sugerencias.style.display = "block";
  });

  buscador.addEventListener("keydown", (e) => {
    if (e.key === "Enter") {
      e.preventDefault();
      const items = sugerencias.querySelectorAll(".sugerencia-item");
      if (items.length > 0) {
        items[0].click();
      }
    }
  });

  document.addEventListener("click", (e) => {
    const contenedor = document.getElementById("buscador-container");
    if (!contenedor.contains(e.target)) {
      sugerencias.innerHTML = "";
      sugerencias.style.display = "none";
      sombra.textContent = "";
    }
  });
});
