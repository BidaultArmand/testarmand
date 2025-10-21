# 🧪 Guide Complet de Test - GitHub Action AI Naming Review

Bienvenue dans le guide complet pour tester l'action GitHub qui utilise l'IA pour réviser les conventions de nommage du code.

## 📚 Documentation Disponible

Ce repository contient plusieurs guides pour vous aider à tester l'action GitHub :

### 1. 🚀 [GUIDE_RAPIDE_TEST.md](./GUIDE_RAPIDE_TEST.md)
**Pour commencer rapidement**
- Commandes essentielles
- Méthode la plus simple
- Checklist rapide
- **Recommandé pour débuter !**

### 2. 📖 [TESTING_GITHUB_ACTION.md](./TESTING_GITHUB_ACTION.md)
**Documentation complète**
- Toutes les méthodes de test détaillées
- Configuration pas à pas
- Scénarios de test avancés
- Dépannage approfondi
- Ressources et références

### 3. 📊 [TEST_WORKFLOW_DIAGRAM.md](./TEST_WORKFLOW_DIAGRAM.md)
**Diagrammes visuels**
- Flux de travail illustrés
- Processus étape par étape
- Exemples de détection
- Timeline typique

### 4. 🔧 [test_github_action.sh](./test_github_action.sh)
**Script automatique**
- Test en une commande
- Création automatique de fichiers de test
- Gestion de la PR
- Nettoyage automatique

---

## ⚡ Démarrage Ultra-Rapide

### En 3 commandes :

```bash
# 1. Rendre le script exécutable (une seule fois)
chmod +x test_github_action.sh

# 2. Lancer le test complet
./test_github_action.sh full

# 3. Aller sur GitHub pour voir les résultats !
# https://github.com/VOTRE_USERNAME/VOTRE_REPO/actions
```

C'est tout ! 🎉

---

## 🎯 Que fait ce test ?

L'action GitHub va :

1. ✅ **Analyser** le code de votre Pull Request
2. 🔍 **Détecter** les problèmes de nommage :
   - Variables mal nommées (`x`, `tmp`, `rslt`)
   - Fonctions peu claires (`calc`, `fct`)
   - Classes non conformes (`maClasse`, `usr`)
3. 💬 **Commenter** directement sur les lignes problématiques
4. 💡 **Suggérer** des améliorations concrètes

### Exemples de détection :

#### ❌ Avant (détecté comme problématique)
```python
def calc(x, y):
    tmp = x + y
    return tmp
```

#### ✅ Après (suggestion de l'IA)
```python
def calculate_sum(first_number, second_number):
    result = first_number + second_number
    return result
```

---

## 📋 Prérequis

### Configuration Minimale

1. **Secret BLACKBOX_API_KEY** (obligatoire)
   - GitHub → Settings → Secrets and variables → Actions
   - Créer un nouveau secret nommé `BLACKBOX_API_KEY`
   - Valeur : votre clé API BLACKBOX

2. **Permissions du Repository**
   - Settings → Actions → General
   - Workflow permissions : "Read and write permissions"

### Outils Optionnels

- **GitHub CLI (`gh`)** : Pour créer des PR en ligne de commande
  ```bash
  brew install gh  # macOS
  ```

- **act** : Pour tester localement
  ```bash
  brew install act  # macOS
  ```

---

## 🛠️ Méthodes de Test

### Méthode 1 : Script Automatique (⭐ Recommandé)

```bash
./test_github_action.sh full
```

**Avantages** :
- ✅ Le plus rapide
- ✅ Crée automatiquement des fichiers de test
- ✅ Gère la PR automatiquement
- ✅ Pas d'erreur manuelle

### Méthode 2 : Manuel sur GitHub

```bash
# Créer une branche
git checkout -b test/naming-review

# Ajouter un fichier de test
echo "def calc(x, y): return x + y" > test.py

# Commit et push
git add test.py
git commit -m "test: naming review"
git push origin test/naming-review

# Créer une PR sur GitHub (interface web)
```

**Avantages** :
- ✅ Contrôle total
- ✅ Comprendre chaque étape
- ✅ Personnalisation facile

### Méthode 3 : Local avec act

```bash
# Installer act
brew install act

# Créer .secrets
echo "BLACKBOX_API_KEY=votre_cle" > .secrets

# Tester localement
act pull_request -W .github/workflows/ai-naming-review.yml --secret-file .secrets
```

**Avantages** :
- ✅ Test sans push
- ✅ Itération rapide
- ✅ Pas de pollution du repo

---

## 📊 Vérifier les Résultats

### Sur GitHub

1. **Onglet Actions**
   - URL : `https://github.com/USERNAME/REPO/actions`
   - Voir le statut d'exécution (✅ ou ❌)
   - Consulter les logs détaillés
   - Vérifier le temps d'exécution

2. **Pull Request**
   - Voir les commentaires de l'IA
   - Lire les suggestions d'amélioration
   - Vérifier le check status

### Résultats Attendus

Pour les fichiers de test créés par le script :

| Fichier | Problèmes Attendus | Commentaires IA |
|---------|-------------------|-----------------|
| `test_bad_naming.py` | ❌ Nombreux | Oui, sur chaque ligne problématique |
| `test_good_naming.py` | ✅ Aucun ou peu | Non ou très peu |
| `test_bad_naming.ts` | ❌ Plusieurs | Oui, suggestions TypeScript |
| `ap_mok.py` (modifié) | ❌ Nouveaux problèmes | Oui, sur les ajouts |

---

## 🔧 Commandes Utiles

### Gestion du Script

```bash
# Voir l'aide
./test_github_action.sh help

# Setup uniquement (sans push)
./test_github_action.sh setup

# Push et PR uniquement
./test_github_action.sh push

# Nettoyage
./test_github_action.sh cleanup

# Test complet
./test_github_action.sh full
```

### GitHub CLI

```bash
# Lister les workflows
gh workflow list

# Voir les exécutions récentes
gh run list --workflow="AI Naming Review"

# Voir les logs d'une exécution
gh run view <run-id> --log

# Lister les PRs
gh pr list

# Voir une PR spécifique
gh pr view <pr-number>
```

---

## 🐛 Dépannage

### Problème : L'action ne se déclenche pas

**Solutions** :
- ✅ Vérifiez que vous avez créé une **Pull Request** (pas juste un push)
- ✅ Vérifiez que la PR n'est pas en mode "Draft"
- ✅ Vérifiez la syntaxe du fichier YAML

### Problème : Erreur "BLACKBOX_API_KEY not found"

**Solutions** :
- ✅ Configurez le secret dans Settings → Secrets
- ✅ Vérifiez l'orthographe exacte : `BLACKBOX_API_KEY`
- ✅ Vérifiez que le secret est au niveau du repository (pas de l'organisation)

### Problème : Pas de commentaires sur la PR

**Solutions** :
- ✅ Vérifiez les logs dans l'onglet Actions
- ✅ Vérifiez les permissions : "Read and write permissions"
- ✅ Vérifiez que le mode est bien `review` dans le workflow
- ✅ Vérifiez que votre clé API est valide

### Problème : Le workflow échoue

**Solutions** :
- ✅ Consultez les logs détaillés dans Actions
- ✅ Vérifiez la version de l'action utilisée
- ✅ Vérifiez que tous les paramètres sont corrects

---

## 📈 Bonnes Pratiques

### Avant de Tester

1. ✅ Lisez le [GUIDE_RAPIDE_TEST.md](./GUIDE_RAPIDE_TEST.md)
2. ✅ Configurez les secrets nécessaires
3. ✅ Vérifiez les permissions du repository
4. ✅ Testez d'abord avec le script automatique

### Pendant le Test

1. ✅ Créez une branche dédiée (`test/...`)
2. ✅ Utilisez des fichiers de test, pas le code de production
3. ✅ Testez différents scénarios (bon/mauvais nommage)
4. ✅ Documentez vos observations

### Après le Test

1. ✅ Examinez les commentaires de l'IA
2. ✅ Vérifiez la pertinence des suggestions
3. ✅ Notez les faux positifs/négatifs
4. ✅ Nettoyez les branches de test
5. ✅ Fermez les PRs de test

---

## 📝 Fichiers de Test Inclus

Le script `test_github_action.sh` crée automatiquement :

### test_bad_naming.py
Exemples de **mauvais** nommage en Python :
- Fonctions : `calcul()`, `fct()`
- Variables : `rslt`, `tmp`, `x`, `y`
- Classes : `maClasse`

### test_good_naming.py
Exemples de **bon** nommage en Python :
- Fonctions : `calculate_total_price()`, `process_order()`
- Variables : `total_orders_processed`, `customer_name`
- Classes : `OrderProcessor`

### test_bad_naming.ts
Exemples de **mauvais** nommage en TypeScript :
- Fonctions : `calc()`
- Variables : `tmp`, `x`, `y`
- Classes : `usr`

---

## 🎓 Ressources Supplémentaires

### Documentation Officielle

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [BLACKBOX AI Documentation](https://www.blackbox.ai/docs)
- [act - Local GitHub Actions](https://github.com/nektos/act)

### Conventions de Nommage

- [PEP 8 - Python Style Guide](https://pep8.org/#naming-conventions)
- [Google TypeScript Style Guide](https://google.github.io/styleguide/tsguide.html#naming)
- [Clean Code Principles](https://github.com/ryanmcdermott/clean-code-javascript)

### Guides dans ce Repository

1. [GUIDE_RAPIDE_TEST.md](./GUIDE_RAPIDE_TEST.md) - Démarrage rapide
2. [TESTING_GITHUB_ACTION.md](./TESTING_GITHUB_ACTION.md) - Documentation complète
3. [TEST_WORKFLOW_DIAGRAM.md](./TEST_WORKFLOW_DIAGRAM.md) - Diagrammes visuels

---

## 💡 Conseils Pro

1. **Commencez simple** : Utilisez le script automatique pour votre premier test
2. **Comparez** : Créez des fichiers avec bon et mauvais nommage côte à côte
3. **Itérez** : Testez plusieurs fois avec différents scénarios
4. **Documentez** : Notez ce qui fonctionne bien et ce qui peut être amélioré
5. **Partagez** : Discutez des résultats avec votre équipe

---

## ✅ Checklist Complète

### Configuration Initiale
- [ ] Secret `BLACKBOX_API_KEY` configuré
- [ ] Permissions du repository vérifiées
- [ ] Script `test_github_action.sh` rendu exécutable
- [ ] GitHub CLI installé (optionnel)
- [ ] act installé (optionnel)

### Premier Test
- [ ] Lecture du guide rapide
- [ ] Exécution de `./test_github_action.sh full`
- [ ] Vérification de l'onglet Actions
- [ ] Vérification des commentaires sur la PR
- [ ] Examen des logs

### Validation
- [ ] Les problèmes de nommage sont détectés
- [ ] Les suggestions sont pertinentes
- [ ] Le bon code n'est pas signalé à tort
- [ ] Le temps d'exécution est acceptable
- [ ] Pas d'erreurs dans les logs

### Nettoyage
- [ ] Exécution de `./test_github_action.sh cleanup`
- [ ] Fermeture de la PR de test
- [ ] Suppression de la branche de test
- [ ] Documentation des résultats

---

## 🤝 Support

Si vous rencontrez des problèmes :

1. Consultez la section [Dépannage](#-dépannage)
2. Vérifiez les logs dans l'onglet Actions
3. Lisez la [documentation complète](./TESTING_GITHUB_ACTION.md)
4. Vérifiez les issues GitHub du repository

---

## 📄 Licence

Ce guide de test fait partie du projet testarmand.

---

**Bon test ! 🚀**

N'oubliez pas : le but est de vérifier que l'IA détecte correctement les problèmes de nommage et fournit des suggestions pertinentes. Amusez-vous bien ! 😊
