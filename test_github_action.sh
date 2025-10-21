#!/bin/bash

# Script pour tester facilement le GitHub Action AI Naming Review
# Usage: ./test_github_action.sh [option]

set -e

BRANCH_NAME="test/naming-review-$(date +%s)"
REPO_DIR="testarmand"

# Couleurs pour l'affichage
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Script de Test GitHub Action AI Naming Review${NC}\n"

# Fonction pour afficher l'aide
show_help() {
    echo "Usage: ./test_github_action.sh [option]"
    echo ""
    echo "Options:"
    echo "  setup       - Créer des fichiers de test et une branche"
    echo "  push        - Pousser les changements et créer une PR"
    echo "  cleanup     - Nettoyer les fichiers de test"
    echo "  full        - Exécuter setup + push (test complet)"
    echo "  help        - Afficher cette aide"
    echo ""
}

# Fonction pour créer les fichiers de test
setup_test_files() {
    echo -e "${YELLOW}📝 Création des fichiers de test...${NC}"
    
    cd "$REPO_DIR"
    
    # Créer une nouvelle branche
    git checkout -b "$BRANCH_NAME"
    echo -e "${GREEN}✓ Branche créée: $BRANCH_NAME${NC}"
    
    # Créer un fichier avec mauvais nommage
    cat > test_bad_naming.py << 'EOF'
#!/usr/bin/env python3
# Fichier avec des problèmes de nommage intentionnels

def calcul(x, y):
    """Fonction mal nommée"""
    rslt = x + y
    tmp = rslt * 2
    return tmp

class maClasse:
    """Classe avec mauvais nommage"""
    def __init__(self):
        self.var1 = 0
        self.VarMixte = 1
        self.x = 2
    
    def fct(self, a, b):
        """Méthode mal nommée"""
        c = a + b
        return c

# Variables globales mal nommées
X = 10
y = 20
MaVariable = 30
EOF
    
    echo -e "${GREEN}✓ Créé: test_bad_naming.py (mauvais nommage)${NC}"
    
    # Créer un fichier avec bon nommage
    cat > test_good_naming.py << 'EOF'
#!/usr/bin/env python3
"""Module demonstrating good naming conventions."""

def calculate_total_price(item_price: float, quantity: int, tax_rate: float = 0.2) -> float:
    """
    Calculate the total price including tax.
    
    Args:
        item_price: Price of a single item
        quantity: Number of items
        tax_rate: Tax rate as a decimal (default 0.2 for 20%)
    
    Returns:
        Total price including tax
    """
    subtotal = item_price * quantity
    tax_amount = subtotal * tax_rate
    total_price = subtotal + tax_amount
    return total_price


class OrderProcessor:
    """Process customer orders with proper naming conventions."""
    
    def __init__(self):
        self.total_orders_processed = 0
        self.failed_orders_count = 0
        self.revenue_total = 0.0
    
    def process_order(self, order_id: int, customer_name: str, order_amount: float) -> dict:
        """
        Process a customer order.
        
        Args:
            order_id: Unique identifier for the order
            customer_name: Name of the customer
            order_amount: Total amount of the order
        
        Returns:
            Dictionary containing order processing results
        """
        try:
            processed_order = {
                "order_id": order_id,
                "customer_name": customer_name,
                "order_amount": order_amount,
                "status": "processed",
                "timestamp": "2024-01-01T00:00:00Z"
            }
            self.total_orders_processed += 1
            self.revenue_total += order_amount
            return processed_order
        except Exception as error:
            self.failed_orders_count += 1
            raise error


# Module-level constants with clear naming
MAX_ORDER_AMOUNT = 10000.0
DEFAULT_TAX_RATE = 0.2
SUPPORTED_CURRENCIES = ["USD", "EUR", "GBP"]
EOF
    
    echo -e "${GREEN}✓ Créé: test_good_naming.py (bon nommage)${NC}"
    
    # Créer un fichier TypeScript avec mauvais nommage
    cat > test_bad_naming.ts << 'EOF'
// Fichier TypeScript avec mauvais nommage

function calc(x: number, y: number): number {
  const tmp = x + y;
  return tmp;
}

class usr {
  x: number;
  y: number;
  
  constructor() {
    this.x = 0;
    this.y = 1;
  }
  
  fct(a: number, b: number): number {
    const c = a + b;
    return c;
  }
}

const X = 10;
const y = 20;
EOF
    
    echo -e "${GREEN}✓ Créé: test_bad_naming.ts (mauvais nommage)${NC}"
    
    # Modifier un fichier existant avec des problèmes
    cat >> ap_mok.py << 'EOF'

# Ajout de code avec mauvais nommage pour test
def fct_test(x, y):
    tmp = x + y
    return tmp
EOF
    
    echo -e "${GREEN}✓ Modifié: ap_mok.py (ajout de code mal nommé)${NC}"
    
    # Commit des changements
    git add .
    git commit -m "test: add files to test AI naming review action

This commit adds test files with both good and bad naming conventions:
- test_bad_naming.py: Intentionally poor naming (calcul, rslt, maClasse, etc.)
- test_good_naming.py: Good naming conventions (calculate_total_price, OrderProcessor, etc.)
- test_bad_naming.ts: TypeScript with poor naming
- Modified ap_mok.py with additional bad naming examples

This will trigger the AI Naming Review action to verify it correctly identifies naming issues."
    
    echo -e "${GREEN}✓ Changements commités${NC}\n"
    
    cd ..
}

# Fonction pour pousser et créer une PR
push_and_create_pr() {
    echo -e "${YELLOW}🚀 Push des changements et création de la PR...${NC}"
    
    cd "$REPO_DIR"
    
    # Pousser la branche
    git push origin "$BRANCH_NAME"
    echo -e "${GREEN}✓ Branche poussée sur GitHub${NC}"
    
    # Créer la PR avec gh CLI si disponible
    if command -v gh &> /dev/null; then
        echo -e "${YELLOW}📝 Création de la Pull Request...${NC}"
        gh pr create \
            --title "Test: AI Naming Review Action" \
            --body "## 🧪 Test de l'Action GitHub AI Naming Review

Cette PR a été créée automatiquement pour tester l'action \`ai-naming-review.yml\`.

### Fichiers de test inclus:

1. **test_bad_naming.py** - Exemples de mauvais nommage:
   - Fonctions: \`calcul()\`, \`fct()\`
   - Variables: \`rslt\`, \`tmp\`, \`x\`, \`y\`
   - Classes: \`maClasse\`

2. **test_good_naming.py** - Exemples de bon nommage:
   - Fonctions: \`calculate_total_price()\`, \`process_order()\`
   - Variables: \`total_orders_processed\`, \`customer_name\`
   - Classes: \`OrderProcessor\`

3. **test_bad_naming.ts** - TypeScript avec mauvais nommage

4. **ap_mok.py** - Modifications avec mauvais nommage

### Résultats attendus:

- ❌ L'IA devrait identifier les problèmes dans \`test_bad_naming.py\`
- ✅ L'IA devrait approuver \`test_good_naming.py\`
- ❌ L'IA devrait identifier les problèmes dans \`test_bad_naming.ts\`
- ❌ L'IA devrait identifier les nouveaux problèmes dans \`ap_mok.py\`

### Vérifications:

- [ ] Le workflow s'exécute sans erreur
- [ ] Des commentaires sont ajoutés sur les lignes problématiques
- [ ] Les suggestions sont pertinentes
- [ ] Le bon nommage n'est pas signalé

---

**Note**: Cette PR peut être fermée après vérification des résultats." \
            --head "$BRANCH_NAME"
        
        echo -e "${GREEN}✓ Pull Request créée!${NC}"
        echo -e "${YELLOW}📊 Ouvrez GitHub pour voir l'exécution de l'action${NC}"
    else
        echo -e "${YELLOW}⚠️  GitHub CLI (gh) n'est pas installé${NC}"
        echo -e "${YELLOW}📝 Créez manuellement une PR sur GitHub:${NC}"
        echo -e "   https://github.com/VOTRE_USERNAME/VOTRE_REPO/compare/$BRANCH_NAME"
    fi
    
    cd ..
}

# Fonction de nettoyage
cleanup() {
    echo -e "${YELLOW}🧹 Nettoyage des fichiers de test...${NC}"
    
    cd "$REPO_DIR"
    
    # Retour à la branche principale
    git checkout main 2>/dev/null || git checkout master 2>/dev/null
    
    # Supprimer les fichiers de test
    rm -f test_bad_naming.py test_good_naming.py test_bad_naming.ts
    
    # Restaurer ap_mok.py si modifié
    git checkout ap_mok.py 2>/dev/null || true
    
    echo -e "${GREEN}✓ Nettoyage terminé${NC}"
    
    cd ..
}

# Menu principal
case "${1:-help}" in
    setup)
        setup_test_files
        echo -e "\n${GREEN}✅ Setup terminé!${NC}"
        echo -e "${YELLOW}Prochaine étape: ./test_github_action.sh push${NC}"
        ;;
    push)
        push_and_create_pr
        echo -e "\n${GREEN}✅ Push et PR créés!${NC}"
        echo -e "${YELLOW}Vérifiez l'onglet Actions sur GitHub${NC}"
        ;;
    cleanup)
        cleanup
        echo -e "\n${GREEN}✅ Nettoyage terminé!${NC}"
        ;;
    full)
        setup_test_files
        push_and_create_pr
        echo -e "\n${GREEN}✅ Test complet terminé!${NC}"
        echo -e "${YELLOW}Vérifiez l'onglet Actions et la PR sur GitHub${NC}"
        ;;
    help|*)
        show_help
        ;;
esac
