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

  // Calcular total y porcentajes
  const total = Object.values(scores).reduce((a, b) => a + b, 0);
  const percentages = {};
  for (let key in scores) {
    percentages[key] = ((scores[key] / total) * 100).toFixed(1);
  }

  // Encontrar el mayor
  let maxCategory = Object.keys(scores).reduce((a, b) =>
    scores[a] > scores[b] ? a : b
  );

  let resultText = "";
  switch (maxCategory) {
    case "tecnologia":
      resultText = `Tu perfil es Tecnológico (${percentages.tecnologia}%). Te atraen los desafíos lógicos, la innovación y la informática.`;
      break;
    case "arte":
      resultText = `Tu perfil es Creativo (${percentages.arte}%). Te interesa el arte, el diseño o la comunicación visual.`;
      break;
    case "social":
      resultText = `Tu perfil es Social (${percentages.social}%). Te motiva ayudar y conectar con las personas.`;
      break;
    case "empresarial":
      resultText = `Tu perfil es Emprendedor (${percentages.empresarial}%). Te gusta liderar, planificar y alcanzar metas.`;
      break;
  }

  // Si hay empate, mostrarlo
  const sorted = Object.entries(scores).sort((a,b)=>b[1]-a[1]);
  if (sorted[0][1] === sorted[1][1]) {
    resultText += `<br><br><em>También mostrás afinidad con el área ${sorted[1][0]} (${percentages[sorted[1][0]]}%).</em>`;
  }

  // Mostrar resultado
  const resultBox = document.getElementById("result");
  resultBox.innerHTML = `<strong>Resultado:</strong> ${resultText}`;
  resultBox.style.display = "block";
}
