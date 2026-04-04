# Claude Code Pro (fonctionnalités)

<p align="right"><strong>Français</strong> | <a href="./README.en.md">France</a></p>

Une version exécutable localement basée sur la correction du code source divulgué de Claude Code, prenant en charge n'importe quelle API compatible avec Anthropic (comme MiniMax, OpenRouter, etc.).

Le code source original divulgué ne peut pas être exécuté directement. Ce dépôt corrige plusieurs problèmes bloquants dans la chaîne de démarrage, permettant à l'interface interactive complète Ink TUI de fonctionner en local.

<p align="center">
<img src="docs/00runtime.png" alt="Capture d'écran de l'exécution" width="800">
</p>

## Fonctionnalités

- Interface interactive complète Ink TUI (identique au Claude Code officiel)
- Mode sans interface (headless) --print (pour les scripts ou l'intégration continue / CI)
- Prise en charge des serveurs MCP, des plugins et des Skills
- Prise en charge de points de terminaison (endpoints) API et de modèles personnalisés
- Mode de secours dégradé (Recovery CLI)

---

## Aperçu de l'architecture

<table>
<tr>
<td align="center" width="25%"><img src="docs/01-overall-architecture.png" alt="Architecture globale">


<b>Architecture globale</b></td>
<td align="center" width="25%"><img src="docs/02-request-lifecycle.png" alt="Cycle de vie des requêtes">


<b>Cycle de vie des requêtes</b></td>
<td align="center" width="25%"><img src="docs/03-tool-system.png" alt="Système d'outils">


<b>Système d'outils</b></td>
<td align="center" width="25%"><img src="docs/04-multi-agent.png" alt="Architecture multi-Agent">


<b>Architecture multi-Agent</b></td>
</tr>
<tr>
<td align="center" width="25%"><img src="docs/05-terminal-ui.png" alt="Interface terminal (TUI)">


<b>Interface terminal (TUI)</b></td>
<td align="center" width="25%"><img src="docs/06-permission-security.png" alt="Permissions et sécurité">


<b>Permissions et sécurité</b></td>
<td align="center" width="25%"><img src="docs/07-services-layer.png" alt="Couche de services">


<b>Couche de services</b></td>
<td align="center" width="25%"><img src="docs/08-state-data-flow.png" alt="État et flux de données">


<b>État et flux de données</b></td>
</tr>
</table>
---

## Démarrage rapide## 

Ici je metterais les deux lignes ...


---

## Description des variables d'environnement

|Variable|	Requis|	Description|
|--------|--------|------------|
|ANTHROPIC_API_KEY|	L'un ou l'autre|	Clé API, envoyée via l'en-tête x-api-key|
|ANTHROPIC_AUTH_TOKEN|	L'un ou l'autre|	Jeton d'authentification, envoyé via l'en-tête Authorization: Bearer|
|ANTHROPIC_BASE_URL|	Non|	Point de terminaison (endpoint) API personnalisé, Anthropic officiel par défaut|
|ANTHROPIC_MODEL|	Non|	Modèle par défaut|
|ANTHROPIC_DEFAULT_SONNET_MODEL|	Non|	Mappage pour le modèle de niveau Sonnet|
|ANTHROPIC_DEFAULT_HAIKU_MODEL|	Non|	Mappage pour le modèle de niveau Haiku|
|ANTHROPIC_DEFAULT_OPUS_MODEL|	Non|	Mappage pour le modèle de niveau Opus|
|API_TIMEOUT_MS|	Non|	Délai d'attente (timeout) de la requête API, 600000 (10min) par défaut|
|DISABLE_TELEMETRY|	Non|	Définir sur 1 pour désactiver la télémétrie|
|CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC|	Non|	Définir sur 1 pour désactiver le trafic réseau non essentiel|

---

## Mode dégradé (Recovery)

Si l'interface complète TUI rencontre des problèmes, vous pouvez utiliser le mode interactif simplifié readline :

```bash
CLAUDE_CODE_FORCE_RECOVERY_CLI=1 ./bin/claude-pro
```

---

## Corrections par rapport au code source original divulgué

Le code source divulgué ne pouvait pas être exécuté directement. Les problèmes suivants ont été principalement corrigés :

|Problème|	Cause racine|	Correction|
|--------|--------------|-------------|
|Le TUI ne démarre pas|	Le script d'entrée redirigeait le démarrage sans argument vers le recovery CLI|	Restauration du point d'entrée complet vers cli.tsx|
|Blocage au démarrage|	Le skill verify importait un fichier .md manquant, provoquant une boucle infinie du text loader de Bun|	Création d'un fichier .md de remplacement (stub)|
|Blocage avec --print|	Fichier filePersistence/types.ts manquant|	Création d'un fichier de types de remplacement|
|Blocage avec --print|	Fichier ultraplan/prompt.txt manquant|	Création d'un fichier de ressource de remplacement|
|La touche Entrée ne répond pas|	Package natif modifiers-napi manquant, isModifierPressed() levait une exception interrompant handleEnter, onSubmit ne s'exécutait jamais|	Ajout d'une tolérance aux pannes avec try-catch|
|La configuration (setup) est ignorée|	preload.ts définissait automatiquement LOCAL_RECOVERY=1, sautant toute l'initialisation	|Suppression du paramètre par défaut|
---

## Structure du projet

```
bin/claude-pro           # Script d'entrée
preload.ts               # Bun preload (définition des variables globales MACRO)
.env.example             # Modèle de variables d'environnement
src/
├── entrypoints/cli.tsx  # Point d'entrée principal de la CLI
├── main.tsx             # Logique principale du TUI (Commander.js + React/Ink)
├── localRecoveryCli.ts  # Mode dégradé Recovery CLI
├── setup.ts             # Initialisation au démarrage
├── screens/REPL.tsx     # Interface interactive REPL
├── ink/                 # Moteur de rendu terminal Ink
├── components/          # Composants UI
├── tools/               # Outils Agent (Bash, Edit, Grep, etc.)
├── commands/            # Commandes Slash (/commit, /review, etc.)
├── skills/              # Système de Skill
├── services/            # Couche de services (API, MCP, OAuth, etc.)
├── hooks/               # React hooks
└── utils/               # Fonctions utilitaires```

---

## Pile technologique

|Catégorie|	Technologie|
|---------|------------|
|Environnement d'exécution|	Bun|
|Langage	|TypeScript|
|Terminal UI|	React + Ink|
|Analyseur| CLI	Commander.js|
|API	|Anthropic SDK|
|Protocoles|	MCP, LSP|

---

## Clause de non-responsabilité (Disclaimer)

Ce dépôt est basé sur le code source de Claude Code divulgué le 31 mars 2026 depuis le registre npm d'Anthropic. Tous les droits d'auteur du code source original appartiennent à Anthropic. Ce projet est destiné uniquement à des fins d'apprentissage et de recherche.
