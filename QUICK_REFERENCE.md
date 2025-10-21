# 📋 Carte de Référence Rapide - Test GitHub Action

## 🚀 Commandes Essentielles

```bash
# Test complet en une commande
./test_github_action.sh full

# Étape par étape
./test_github_action.sh setup    # Créer fichiers de test
./test_github_action.sh push     # Pousser et créer PR
./test_github_action.sh cleanup  # Nettoyer après test
```

---

## ⚙️ Configuration Requise

| Élément | Où le configurer | Valeur |
|---------|------------------|--------|
| `BLACKBOX_API_KEY` | Settings → Secrets → Actions | Votre clé API |
| Permissions | Settings → Actions → General | Read and write |

---

## 📊 Où Vérifier les Résultats

| Emplacement | URL | Que voir |
|-------------|-----|----------|
| **Actions** | `/actions` | Logs, statut, temps |
| **Pull Request** | `/pulls` | Commentaires IA, suggestions |

---

## ❌ Problèmes Courants

| Problème | Solution Rapide |
|----------|-----------------|
| Action ne se déclenche pas | Créer une PR (pas juste push) |
| "API KEY not found" | Vérifier secret dans Settings |
| Pas de commentaires | Vérifier permissions "write" |
| Workflow échoue | Consulter logs dans Actions |

---

## 🎯 Exemples de Détection

### ❌ Mauvais (détecté)
```python
def calc(x, y):
    tmp = x + y
    return tmp
```

### ✅ Bon (approuvé)
```python
def calculate_sum(first_number, second_number):
    result = first_number + second_number
    return result
```

---

## 📚 Documentation

| Guide | Usage |
|-------|-------|
| `GUIDE_RAPIDE_TEST.md` | Démarrage rapide |
| `TESTING_GITHUB_ACTION.md` | Documentation complète |
| `TEST_WORKFLOW_DIAGRAM.md` | Diagrammes visuels |
| `README_TESTING.md` | Vue d'ensemble |

---

## ✅ Checklist Minimale

- [ ] Secret `BLACKBOX_API_KEY` configuré
- [ ] Permissions "Read and write" activées
- [ ] Script exécutable : `chmod +x test_github_action.sh`
- [ ] Lancer : `./test_github_action.sh full`
- [ ] Vérifier Actions et PR sur GitHub

---

## 🔗 Liens Rapides

```bash
# Voir workflows
gh workflow list

# Voir exécutions
gh run list --workflow="AI Naming Review"

# Voir logs
gh run view <run-id> --log
```

---

## 💡 Conseil Pro

**Premier test ?** → Utilisez `./test_github_action.sh full`

C'est la méthode la plus simple et la plus fiable ! 🎉
