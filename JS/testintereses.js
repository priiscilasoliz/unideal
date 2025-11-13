function calculateResult() {
  const form = document.getElementById("interestTest");
  const answers = new FormData(form);

  let scores = {
    tecnologia: 0,
    arte: 0,
    social: 0,
    empresarial: 0
  };

  // Sumar puntos
  for (let value of answers.values()) {
    scores[value]++;
  }

  const total = Object.values(scores).reduce((a, b) => a + b, 0);
  const resultBox = document.getElementById("result");

  if (total === 0) {
    resultBox.innerHTML = `<strong>Resultado:</strong> Por favor respondé al menos una pregunta.`;
    resultBox.style.display = "block";
    return;
  }

  // Calcular porcentajes
  const percentages = {};
  for (let key in scores) {
    percentages[key] = ((scores[key] / total) * 100).toFixed(1);
  }

  // Encontrar el máximo
  const maxScore = Math.max(...Object.values(scores));
  const topCategories = Object.keys(scores).filter(key => scores[key] === maxScore);

  // Generar texto de resultados
  let resultText = "";

  // Si hay solo una categoría ganadora
  if (topCategories.length === 1) {
    const cat = topCategories[0];
    resultText = generarDescripcion(cat, percentages[cat]);
  } else {
    resultText = `<strong>Empate detectado entre las siguientes áreas:</strong><br>`;
    topCategories.forEach(cat => {
      resultText += `- ${formatearNombre(cat)} (${percentages[cat]}%)<br>`;
    });
    resultText += `<br>Mostrás afinidad con múltiples áreas, te mostramos carreras recomendadas para cada una.`;
  }

  resultBox.innerHTML = `<strong>Resultado:</strong><br>${resultText}`;
  resultBox.style.display = "block";

  // Mostrar carreras para cada área empatada
  const listaContainerId = 'result-carreras';
  let listaContainer = document.getElementById(listaContainerId);
  if (!listaContainer) {
    listaContainer = document.createElement('div');
    listaContainer.id = listaContainerId;
    listaContainer.style.marginTop = '12px';
    resultBox.appendChild(listaContainer);
  }
  listaContainer.innerHTML = ""; // limpiar antes de mostrar nuevas

  topCategories.forEach(area => {
    mostrarCarrerasPorArea(area, listaContainer);
  });
}

// Función auxiliar: descripción breve por área
function generarDescripcion(area, porcentaje) {
  switch (area) {
    case "tecnologia":
      return `Tu perfil es <strong>Tecnológico</strong> (${porcentaje}%). Te atraen los desafíos lógicos, la innovación y la informática.`;
    case "arte":
      return `Tu perfil es <strong>Creativo</strong> (${porcentaje}%). Te interesa el arte, el diseño o la comunicación visual.`;
    case "social":
      return `Tu perfil es <strong>Social</strong> (${porcentaje}%). Te motiva ayudar y conectar con las personas.`;
    case "empresarial":
      return `Tu perfil es <strong>Emprendedor</strong> (${porcentaje}%). Te gusta liderar, planificar y alcanzar metas.`;
    default:
      return "";
  }
}

// Función auxiliar: convertir clave interna a texto legible
function formatearNombre(area) {
  switch (area) {
    case "tecnologia": return "Área Tecnológica";
    case "arte": return "Área Creativa";
    case "social": return "Área Social";
    case "empresarial": return "Área Empresarial";
    default: return area;
  }
}

// Función para mostrar carreras según el área
function mostrarCarrerasPorArea(area, contenedor) {
  const endpoint = `../PHP/get_carreras_por_area.php?area=${encodeURIComponent(area)}`;
  fetch(endpoint)
    .then(resp => {
      if (!resp.ok) throw new Error("Error en la petición");
      return resp.json();
    })
    .then(data => {
      let html = `<h4 style="margin-top:15px;">Carreras recomendadas para ${formatearNombre(area)}:</h4>`;
      if (!data || data.length === 0) {
        html += "<p>No se encontraron carreras relacionadas en la base de datos.</p>";
      } else {
        html += "<ul>";
        data.forEach(item => {
          const carreraLink = item.url
            ? `<a href="${item.url}" target="_blank" rel="noopener">${item.nombre}</a>`
            : item.nombre;
          const uniLink = item.universidad_url
            ? `<a href="${item.universidad_url}" target="_blank" rel="noopener">${item.universidad_acronimo}</a>`
            : item.universidad_acronimo;
          html += `<li>${carreraLink} (<em>${uniLink}</em>)</li>`;
        });
        html += "</ul>";
      }
      contenedor.innerHTML += html;
    })
    .catch(err => {
      contenedor.innerHTML += `<p>Error al obtener carreras del área ${formatearNombre(area)}.</p>`;
      console.error(err);
    });
}
