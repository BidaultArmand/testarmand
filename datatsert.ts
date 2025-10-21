import { readFileSync, writeFileSync, existsSync } from "fs";
import { join } from "path";

/**
 * Petit utilitaire TypeScript pour :
 *  - générer des données aléatoires (JSON)
 *  - les enregistrer sur disque
 *  - les relire et afficher des statistiques
 */

type RecordType = {
  id: number;
  name: string;
  score: number;
  active: boolean;
};

const N = 20;
const names = ["Alice", "Bob", "Charlie", "Diana", "Ethan", "Fiona", "George", "Hana"];

const filePath = join(__dirname, "test_data.json");

function generateData(): RecordType[] {
  const data: RecordType[] = [];
  for (let i = 1; i <= N; i++) {
    data.push({
      id: i,
      name: names[Math.floor(Math.random() * names.length)],
      score: Math.floor(Math.random() * 100),
      active: Math.random() > 0.5,
    });
  }
  return data;
}

function saveData(data: RecordType[]) {
  writeFileSync(filePath, JSON.stringify(data, null, 2), "utf8");
  console.log(`💾 Données enregistrées dans ${filePath}`);
}

function loadData(): RecordType[] {
  if (!existsSync(filePath)) {
    console.error("❌ Aucun fichier trouvé, lance d'abord la génération !");
    process.exit(1);
  }
  const content = readFileSync(filePath, "utf8");
  return JSON.parse(content) as RecordType[];
}

function analyzeData(data: RecordType[]) {
  const avgScore = data.reduce((acc, r) => acc + r.score, 0) / data.length;
  const activeCount = data.filter(r => r.active).length;

  console.log("📊 Statistiques :");
  console.log(`- Nombre d’enregistrements : ${data.length}`);
  console.log(`- Score moyen : ${avgScore.toFixed(2)}`);
  console.log(`- Utilisateurs actifs : ${activeCount}`);
  console.log(`- Utilisateurs inactifs : ${data.length - activeCount}`);
}

function main() {
  const args = process.argv.slice(2);
  if (args.includes("--gen")) {
    const data = generateData();
    saveData(data);
  } else {
    const data = loadData();
    analyzeData(data);
  }
}

if (require.main === module) main();
