function calculateResult() {
  const form = document.getElementById("interestTest");
  const answers = new FormData(form);

  let scores = {
    tecnologia: 0,
    arte: 0,
    social: 0,
    empresarial: 0
  };

  // sumar votos
  for (let value of answers.values()) {
    scores[value]++;
  }

  // encontrar el mayor
  let maxCategory = Object.keys(scores).reduce((a, b) => 
    scores[a] > scores[b] ? a : b
  );

  let resultText = "";
  switch (maxCategory) {
    case "tecnologia":
      resultText = "Te interesan las carreras relacionadas con Tecnología e Ingeniería 👩‍💻👨‍💻.";
      break;
    case "arte":
      resultText = "Tenés un perfil creativo, te pueden interesar las Artes, Diseño o Comunicación 🎨.";
      break;
    case "social":
      resultText = "Tu vocación es ayudar, podrías orientarte a Psicología, Educación o Trabajo Social 🤝.";
      break;
    case "empresarial":
      resultText = "Tenés perfil emprendedor, las carreras de Administración, Economía o Negocios son ideales 💼.";
      break;
  }

  // mostrar resultado
  const resultBox = document.getElementById("result");
  resultBox.innerHTML = `<strong>Resultado:</strong> ${resultText}`;
  resultBox.style.display = "block";
}
