# 📊 Diagramme du Workflow de Test

## Vue d'ensemble du processus de test

```
┌─────────────────────────────────────────────────────────────────┐
│                    TESTER LE GITHUB ACTION                      │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
                    ┌─────────────────┐
                    │  Configuration  │
                    │   Préalable     │
                    └─────────────────┘
                              │
                ┌─────────────┴─────────────┐
                ▼                           ▼
    ┌───────────────────────┐   ┌───────────────────────┐
    │ Secret BLACKBOX_API   │   │   Permissions du      │
    │   KEY configuré       │   │   Repository OK       │
    └───────────────────────┘   └───────────────────────┘
                │                           │
                └─────────────┬─────────────┘
                              ▼
                    ┌─────────────────┐
                    │ Choisir Méthode │
                    │    de Test      │
                    └─────────────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        ▼                     ▼                     ▼
┌───────────────┐   ┌───────────────┐   ┌───────────────┐
│  Méthode 1:   │   │  Méthode 2:   │   │  Méthode 3:   │
│   Script      │   │   GitHub      │   │   Local       │
│  Automatique  │   │   (Manuel)    │   │   avec act    │
└───────────────┘   └───────────────┘   └───────────────┘
        │                     │                     │
        └─────────────────────┼─────────────────────┘
                              ▼
                    ┌─────────────────┐
                    │  Exécution du   │
                    │  GitHub Action  │
                    └─────────────────┘
                              │
                              ▼
                    ┌─────────────────┐
                    │  Vérification   │
                    │  des Résultats  │
                    └─────────────────┘
                              │
                ┌─────────────┴─────────────┐
                ▼                           ▼
    ┌───────────────────────┐   ┌───────────────────────┐
    │  Onglet Actions       │   │  Commentaires sur     │
    │  (Logs & Status)      │   │  la Pull Request      │
    └───────────────────────┘   └───────────────────────┘
```

---

## Méthode 1 : Script Automatique (Recommandé)

```
┌──────────────────────────────────────────────────────────┐
│  ./test_github_action.sh full                            │
└──────────────────────────────────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  1. Créer branche de test     │
        │     test/naming-review-XXX    │
        └───────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  2. Créer fichiers de test    │
        │     • test_bad_naming.py      │
        │     • test_good_naming.py     │
        │     • test_bad_naming.ts      │
        └───────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  3. Commit des changements    │
        └───────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  4. Push vers GitHub          │
        └───────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  5. Créer Pull Request        │
        │     (avec gh CLI)             │
        └───────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  6. Action se déclenche       │
        │     automatiquement           │
        └───────────────────────────────┘
```

---

## Méthode 2 : Test sur GitHub (Manuel)

```
┌──────────────────────────────────────────────────────────┐
│  Test Manuel sur GitHub                                  │
└──────────────────────────────────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  1. Créer branche             │
        │     git checkout -b test/xxx  │
        └───────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  2. Modifier/Créer fichiers   │
        │     • Ajouter code mal nommé  │
        │     • Ajouter code bien nommé │
        └───────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  3. Commit                    │
        │     git commit -m "test: ..." │
        └───────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  4. Push                      │
        │     git push origin test/xxx  │
        └───────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  5. Créer PR sur GitHub       │
        │     (Interface Web)           │
        └───────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  6. Workflow se déclenche     │
        └───────────────────────────────┘
```

---

## Méthode 3 : Test Local avec act

```
┌──────────────────────────────────────────────────────────┐
│  Test Local avec act                                     │
└──────────────────────────────────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  1. Installer act             │
        │     brew install act          │
        └───────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  2. Créer fichier .secrets    │
        │     BLACKBOX_API_KEY=xxx      │
        └───────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  3. Exécuter act              │
        │     act pull_request          │
        └───────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  4. Voir résultats locaux     │
        └───────────────────────────────┘
```

---

## Flux d'Exécution du GitHub Action

```
┌──────────────────────────────────────────────────────────┐
│  Pull Request créée/mise à jour                          │
└──────────────────────────────────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  Trigger: on.pull_request     │
        │  Types: opened, synchronize   │
        └───────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  Job: review                  │
        │  Runs-on: ubuntu-latest       │
        └───────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  Step 1: Checkout PR          │
        │  actions/checkout@v4          │
        └───────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  Step 2: AI Naming Review     │
        │  BidaultArmand/blackbox42     │
        └───────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  Analyse du code avec IA      │
        │  • Détection problèmes        │
        │  • Génération suggestions     │
        └───────────────────────────────┘
                        │
                        ▼
        ┌───────────────────────────────┐
        │  Commentaires sur la PR       │
        │  • Lignes problématiques      │
        │  • Suggestions d'amélioration │
        └───────────────────────────────┘
```

---

## Vérification des Résultats

```
┌──────────────────────────────────────────────────────────┐
│  Où vérifier les résultats ?                             │
└──────────────────────────────────────────────────────────┘
                        │
        ┌───────────────┴───────────────┐
        ▼                               ▼
┌───────────────────┐       ┌───────────────────┐
│  Onglet Actions   │       │  Pull Request     │
└───────────────────┘       └───────────────────┘
        │                               │
        ▼                               ▼
┌───────────────────┐       ┌───────────────────┐
│  • Status (✅/❌)  │       │  • Commentaires   │
│  • Logs détaillés │       │  • Suggestions    │
│  • Temps exec     │       │  • Check status   │
│  • Erreurs        │       │  • Review summary │
└───────────────────┘       └───────────────────┘
```

---

## Exemples de Détection

### ❌ Mauvais Nommage Détecté

```python
# Fichier: test_bad_naming.py

def calc(x, y):           # ← IA commente: "calc" → "calculate"
    tmp = x + y           # ← IA commente: "tmp" → "result"
    return tmp

class usr:                # ← IA commente: "usr" → "User"
    def fct(self, a, b):  # ← IA commente: "fct" → descriptif
        return a + b
```

### ✅ Bon Nommage Approuvé

```python
# Fichier: test_good_naming.py

def calculate_total_price(item_price, quantity):
    subtotal = item_price * quantity
    return subtotal

class OrderProcessor:
    def process_order(self, order_id, customer_name):
        return {"order_id": order_id, "customer": customer_name}
```

---

## Timeline Typique d'un Test

```
T+0s    : Push de la branche
T+5s    : Création de la Pull Request
T+10s   : Déclenchement du workflow
T+15s   : Checkout du code
T+30s   : Analyse IA en cours
T+60s   : Génération des commentaires
T+90s   : Publication des commentaires sur la PR
T+120s  : Workflow terminé ✅
```

---

## Checklist de Vérification

```
┌─────────────────────────────────────────────────────┐
│  ✅ Checklist Post-Test                             │
├─────────────────────────────────────────────────────┤
│  □ Le workflow s'est exécuté sans erreur            │
│  □ Des commentaires apparaissent sur la PR          │
│  □ Les problèmes de nommage sont identifiés         │
│  □ Les suggestions sont pertinentes                 │
│  □ Le bon code n'est pas signalé à tort             │
│  □ Le temps d'exécution est raisonnable (<2 min)    │
│  □ Les logs sont clairs et informatifs              │
│  □ Le check status est correct (✅ ou ❌)            │
└─────────────────────────────────────────────────────┘
```

---

## Dépannage Visuel

```
Problème détecté ?
        │
        ▼
    ┌───────┐
    │ Quel  │
    │ type? │
    └───────┘
        │
    ┌───┴────────────────────────────┐
    ▼                                ▼
┌─────────┐                  ┌──────────────┐
│ Action  │                  │ Commentaires │
│ échoue  │                  │ manquants    │
└─────────┘                  └──────────────┘
    │                                │
    ▼                                ▼
┌─────────────────┐          ┌──────────────────┐
│ • Vérifier logs │          │ • Vérifier perms │
│ • Check secrets │          │ • Check API key  │
│ • Check syntax  │          │ • Check mode     │
└─────────────────┘          └──────────────────┘
