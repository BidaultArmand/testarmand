# 🚀 Guide Rapide - Tester le GitHub Action

## Méthode la Plus Simple (Recommandée)

### Option 1 : Script Automatique

```bash
# Test complet automatique
./test_github_action.sh full
```

C'est tout ! Le script va :
1. ✅ Créer une branche de test
2. ✅ Ajouter des fichiers avec bon et mauvais nommage
3. ✅ Créer une Pull Request
4. ✅ Déclencher l'action GitHub

Ensuite, allez sur GitHub pour voir les résultats !

---

## Option 2 : Étape par Étape

### 1️⃣ Créer une branche et des fichiers de test
```bash
./test_github_action.sh setup
```

### 2️⃣ Pousser et créer la PR
```bash
./test_github_action.sh push
```

### 3️⃣ Nettoyer après le test
```bash
./test_github_action.sh cleanup
```

---

## Option 3 : Manuellement

### Étape 1 : Créer une branche
```bash
cd testarmand
git checkout -b test/naming-review
```

### Étape 2 : Créer un fichier de test
```bash
cat > test_example.py << 'EOF'
# Mauvais nommage
def calc(x, y):
    tmp = x + y
    return tmp

class usr:
    def __init__(self):
        self.x = 0
EOF
```

### Étape 3 : Commit et push
```bash
git add test_example.py
git commit -m "test: add file to test naming review"
git push origin test/naming-review
```

### Étape 4 : Créer une PR sur GitHub
Allez sur GitHub et créez une Pull Request depuis votre branche.

---

## 📊 Vérifier les Résultats

### Sur GitHub :

1. **Onglet Actions** : Voir l'exécution du workflow
   - URL : `https://github.com/VOTRE_USERNAME/VOTRE_REPO/actions`

2. **Pull Request** : Voir les commentaires de l'IA
   - L'IA va commenter les lignes avec des problèmes de nommage
   - Elle va suggérer des améliorations

### Exemples de ce que l'IA va détecter :

❌ **Mauvais nommage** :
- `calc()` → devrait être `calculate()`
- `tmp` → devrait être `temporary_value` ou `result`
- `x`, `y` → devraient avoir des noms descriptifs
- `usr` → devrait être `User`
- `fct()` → devrait être `function_name()`

✅ **Bon nommage** :
- `calculate_total_price()`
- `OrderProcessor`
- `total_orders_processed`
- `customer_name`

---

## ⚙️ Configuration Requise

### Avant le premier test :

1. **Configurer le secret BLACKBOX_API_KEY** :
   - GitHub → Settings → Secrets and variables → Actions
   - New repository secret
   - Nom : `BLACKBOX_API_KEY`
   - Valeur : Votre clé API

2. **Vérifier les permissions** :
   - Settings → Actions → General
   - Workflow permissions : "Read and write permissions"

---

## 🐛 Problèmes Courants

### L'action ne se déclenche pas
- ✅ Vérifiez que vous avez créé une **Pull Request** (pas juste un push)
- ✅ Vérifiez que la PR n'est pas en mode "Draft"

### Erreur "BLACKBOX_API_KEY not found"
- ✅ Configurez le secret dans les paramètres du repository

### Pas de commentaires sur la PR
- ✅ Vérifiez les logs dans l'onglet Actions
- ✅ Vérifiez les permissions du workflow

---

## 📚 Documentation Complète

Pour plus de détails, consultez : `TESTING_GITHUB_ACTION.md`

---

## 💡 Conseils

1. **Testez avec des vrais problèmes** : Les fichiers `ap_mok.py` et `datatsert.ts` ont déjà des problèmes de nommage
2. **Comparez bon vs mauvais** : Créez deux fichiers pour voir la différence
3. **Vérifiez les logs** : Même si tout fonctionne, regardez les logs pour comprendre
4. **Documentez les résultats** : Notez ce qui fonctionne bien et ce qui peut être amélioré

---

## ✅ Checklist Rapide

Avant de tester :
- [ ] Secret `BLACKBOX_API_KEY` configuré
- [ ] Permissions du repository vérifiées
- [ ] Script `test_github_action.sh` exécutable

Pour tester :
- [ ] Exécuter `./test_github_action.sh full`
- [ ] Vérifier l'onglet Actions sur GitHub
- [ ] Vérifier les commentaires sur la PR
- [ ] Documenter les résultats

Après le test :
- [ ] Exécuter `./test_github_action.sh cleanup`
- [ ] Fermer/merger la PR de test
- [ ] Supprimer la branche de test (optionnel)
