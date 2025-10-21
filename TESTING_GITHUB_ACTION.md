# Guide de Test pour GitHub Action AI Naming Review

Ce guide explique comment tester l'action GitHub `ai-naming-review.yml` qui utilise l'IA pour réviser les conventions de nommage du code.

## 📋 Prérequis

### 1. Configuration des Secrets GitHub

L'action nécessite le secret `BLACKBOX_API_KEY` :

1. Allez dans les paramètres du repository : `Settings` → `Secrets and variables` → `Actions`
2. Cliquez sur `New repository secret`
3. Nom : `BLACKBOX_API_KEY`
4. Valeur : Votre clé API BLACKBOX
5. Cliquez sur `Add secret`

> **Note** : Le `GITHUB_TOKEN` est automatiquement fourni par GitHub Actions.

### 2. Permissions du Repository

Vérifiez que les permissions sont correctes :
- `Settings` → `Actions` → `General` → `Workflow permissions`
- Assurez-vous que "Read and write permissions" est activé pour les pull requests

---

## 🧪 Méthode 1 : Test Local avec `act`

### Installation de `act`

**macOS :**
```bash
brew install act
```

**Linux :**
```bash
curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
```

**Windows :**
```bash
choco install act-cli
```

### Configuration

1. Créez un fichier `.secrets` à la racine du projet :
```bash
BLACKBOX_API_KEY=votre_cle_api_ici
```

2. Testez l'action localement :
```bash
cd testarmand
act pull_request -W .github/workflows/ai-naming-review.yml --secret-file .secrets
```

### Limitations de `act`
- Ne simule pas parfaitement l'environnement GitHub
- Certaines fonctionnalités peuvent ne pas fonctionner exactement comme sur GitHub

---

## 🚀 Méthode 2 : Test sur GitHub (Recommandé)

### Étape 1 : Créer une Branche de Test

```bash
cd testarmand
git checkout -b test/naming-review
```

### Étape 2 : Créer des Fichiers de Test

Créez des fichiers avec des problèmes de nommage intentionnels :

```bash
# Fichier avec mauvais nommage
cat > bad_naming_example.py << 'EOF'
def calcul_truc(x, y):
    """Fonction mal nommée"""
    rslt = x + y
    return rslt

class maClasse:
    def __init__(self):
        self.var1 = 0
        self.VarMixte = 1
EOF

# Fichier avec bon nommage
cat > good_naming_example.py << 'EOF'
def calculate_sum(first_number: int, second_number: int) -> int:
    """Calculate the sum of two numbers."""
    result = first_number + second_number
    return result

class DataProcessor:
    def __init__(self):
        self.processed_count = 0
        self.error_count = 0
EOF
```

### Étape 3 : Commit et Push

```bash
git add .
git commit -m "test: add files to test AI naming review"
git push origin test/naming-review
```

### Étape 4 : Créer une Pull Request

1. Allez sur GitHub : `https://github.com/VOTRE_USERNAME/VOTRE_REPO/pulls`
2. Cliquez sur `New pull request`
3. Sélectionnez la branche `test/naming-review`
4. Créez la pull request

### Étape 5 : Vérifier l'Exécution

1. Allez dans l'onglet `Actions` de votre repository
2. Vous devriez voir le workflow "AI Naming Review" en cours d'exécution
3. Cliquez dessus pour voir les détails

### Étape 6 : Vérifier les Commentaires

Retournez sur la pull request et vérifiez :
- Les commentaires de l'IA sur les problèmes de nommage
- Les suggestions d'amélioration
- Le statut du check (✅ ou ❌)

---

## 🎯 Scénarios de Test

### Test 1 : Fichiers Existants avec Mauvais Nommage

Les fichiers suivants ont déjà des problèmes de nommage :

- `ap_mok.py` → devrait être `api_mock.py`
- `datatsert.ts` → devrait être `data_insert.ts`
- Variables dans le code avec des noms peu clairs

**Action** : Créez une PR qui modifie ces fichiers pour déclencher la review.

### Test 2 : Nouveau Fichier avec Bon Nommage

```python
# good_example.py
class UserDataProcessor:
    """Process user data with clear naming conventions."""
    
    def __init__(self):
        self.total_users_processed = 0
        self.failed_operations_count = 0
    
    def process_user_data(self, user_id: int, user_name: str) -> dict:
        """Process data for a specific user."""
        processed_data = {
            "user_id": user_id,
            "user_name": user_name,
            "timestamp": "2024-01-01"
        }
        return processed_data
```

**Résultat attendu** : Peu ou pas de commentaires de l'IA.

### Test 3 : Nouveau Fichier avec Mauvais Nommage

```python
# bad_example.py
class usr:
    def __init__(self):
        self.x = 0
        self.y = 1
    
    def calc(self, a, b):
        tmp = a + b
        return tmp
```

**Résultat attendu** : Plusieurs commentaires de l'IA suggérant des améliorations.

---

## 🔍 Vérification des Résultats

### Dans l'onglet Actions

Vérifiez :
- ✅ Le workflow s'est exécuté sans erreur
- ⏱️ Le temps d'exécution (généralement < 2 minutes)
- 📝 Les logs de chaque étape

### Dans la Pull Request

Vérifiez :
- 💬 Les commentaires de l'IA sur les lignes de code
- 📊 Le résumé des problèmes trouvés
- ✨ Les suggestions d'amélioration

---

## 🐛 Dépannage

### L'action ne se déclenche pas

1. Vérifiez que le fichier workflow est dans `.github/workflows/`
2. Vérifiez la syntaxe YAML avec : https://www.yamllint.com/
3. Assurez-vous que la PR n'est pas en mode "draft"

### Erreur "BLACKBOX_API_KEY not found"

1. Vérifiez que le secret est bien configuré dans les paramètres du repository
2. Le nom doit être exactement `BLACKBOX_API_KEY` (sensible à la casse)

### L'action échoue avec une erreur 401/403

1. Vérifiez que votre clé API BLACKBOX est valide
2. Vérifiez les permissions du repository pour les workflows

### Pas de commentaires sur la PR

1. Vérifiez les logs de l'action dans l'onglet Actions
2. Assurez-vous que l'action a les permissions d'écriture sur les PRs
3. Vérifiez que le mode est bien configuré sur `review`

---

## 📊 Commandes Utiles

### Voir les workflows disponibles
```bash
gh workflow list
```

### Déclencher manuellement un workflow (si configuré)
```bash
gh workflow run "AI Naming Review"
```

### Voir les exécutions récentes
```bash
gh run list --workflow="AI Naming Review"
```

### Voir les logs d'une exécution
```bash
gh run view <run-id> --log
```

---

## 🎓 Bonnes Pratiques

1. **Testez d'abord localement** avec `act` si possible
2. **Créez des branches de test** dédiées pour ne pas polluer votre historique
3. **Documentez les résultats** de vos tests
4. **Testez différents scénarios** (bon/mauvais nommage, différents langages)
5. **Vérifiez les performances** (temps d'exécution, coût API)

---

## 📚 Ressources

- [Documentation GitHub Actions](https://docs.github.com/en/actions)
- [Documentation act](https://github.com/nektos/act)
- [BLACKBOX AI Documentation](https://www.blackbox.ai/docs)
- [Conventions de nommage Python (PEP 8)](https://pep8.org/#naming-conventions)
- [Conventions de nommage TypeScript](https://google.github.io/styleguide/tsguide.html#naming)

---

## ✅ Checklist de Test

- [ ] Secret `BLACKBOX_API_KEY` configuré
- [ ] Permissions du repository vérifiées
- [ ] Branche de test créée
- [ ] Fichiers de test avec mauvais nommage ajoutés
- [ ] Fichiers de test avec bon nommage ajoutés
- [ ] Pull request créée
- [ ] Workflow exécuté avec succès
- [ ] Commentaires de l'IA vérifiés
- [ ] Logs de l'action examinés
- [ ] Résultats documentés
